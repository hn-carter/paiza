/*
これはpaizaラーニングの「グリッド版ダイクストラ問題セット」から
「問題3: ダイクストラ法 - 経路復元」にswiftでチャレンジした試行錯誤コードです。
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d3
*/

/*
問題の解き方はpaiza開発日誌「最短経路問題で頻出の「ダイクストラ法」とは？練習問題で徹底解説」
https://paiza.hatenablog.com/entry/2020/11/27/150000
の通りです。

構造体　Position　位置を表す
※通過位置の判定用にDictionaryのキーに使用するため、Hashableに準拠

クラス　Route　通過ルートを表す

構造体　Board　盤面を表す
関数　　func getCost(_ pos: Position) -> Int　指定位置のコストを返す
　　　　func isWithinRange(_ pos: Position) -> Bool　位置が盤面の範囲内か判定

構造体　Dijkstra　ダイクストラ法で問題を解く
関数　　func less(l: Route, r: Route) -> Bool　優先度付きキューの優先度判定関数
　　　　func run()　問題を解く

優先度付きキューのためにヒープを作成
構造体　Heap<T>　ジェネリックで定義したヒープ
　　　　var isEmpty: Bool　要素が空か判定
　　　　var count: Int　要素の数を返す
関数　　func Push(_ item: T)　優先順に従って要素を追加
　　　　func Pop() -> T?　優先順に従って要素を取り出し、バッファから削除
*/

import Foundation

// このプログラムで使用する例外
enum GridDijkstraD3Error: Error {
    case invalidH(string: String)               // 盤面の行数が無効
    case hOutOfRange(number: Int)               // 盤面の行数が範囲外
    case invalidW(string: String)               // 盤面の列数が無効
    case wOutOfRange(number: Int)               // 盤面の列数が範囲外
    case invalidCost(string: String)            // 盤面のコストが無効
    case costOutOfRange(number: Int)            // 盤面のコストが範囲外
    case invalidData(no: Int, line: String)     // 入力行が無効
}

// 標準エラー出力の定義
// print(_: separator: terminator: to:)のto:に指定するTextOutputStream
// 標準出力から標準エラー出力へリダイレクトする
final class StandardErrorOutputStream: TextOutputStream {
    func write(_ string: String) {
        // 標準エラー出力のファイルハンドル
        try! FileHandle.standardError.write(contentsOf: string.data(using: .utf8)!)
    }
}

// 盤面の位置を表す構造体
// Dictionaryのキーに使えるようにHashableプロトコルに準拠する
struct Position : Hashable {
    // 列 0〜W-1
    var x: Int
    // 行 0〜H-1
    var y: Int

    static func + (lhs: Position, rhs: Position) -> Position {
        let x = lhs.x + rhs.x
        let y = lhs.y + rhs.y
        return Position(x: x, y: y)
    }

    static func == (lhs: Position, rhs: Position) -> Bool {
        if lhs.x == rhs.x && lhs.y == rhs.y {
            return true
        }
        return false
    }

    func hash(into hasher: inout Hasher) {
        // ハッシャーに使用する変数をセット
        hasher.combine(x)
        hasher.combine(y)
    }
}

// 盤面上の移動可能方向を定義する 右、上、左、下の4方向
let MOVABLE_DIRECTION: [Position] = [
	Position(x: 1, y: 0),
	Position(x: 0, y: -1),
	Position(x: -1, y: 0),
	Position(x: 0, y: 1)]

// 通過経路 参照型
final class Route {
    // 現在位置
    var pos: Position
    // 現在位置までのコスト
    var cost: Int
    // 現在位置に来る直前にいたルート
    var ref: Route?

    init(pos: Position, cost: Int, ref: Route?) {
        self.pos = pos
        self.cost = cost
        self.ref = ref
    }

    // デバッグ用
    func printD() {
        let msg = String(format: "x=%d, y=%d, cost=%d", pos.x, pos.y, cost)
        print(msg)
    }
}

struct Board {
    // 盤面の行数
    var h: Int
    // 盤面の列数
    var w: Int
    // マス目のコスト 2次元配列
	var cell: [[Int]]

    init(height: Int, width: Int) {
        self.h = height
        self.w = width
        // 2次元配列の初期化
        self.cell = [[Int]](repeating: [Int](repeating: 0, count: height), count: width)
    }

    // getCost は指定位置のコストを返す
    public func getCost(_ pos: Position) -> Int {
        return self.cell[pos.x][pos.y]
    }
    // isWithinRange は渡された位置が盤面の範囲内か判定する
    public func isWithinRange(_ pos: Position) -> Bool {
	    return 0 <= pos.y && pos.y < self.h && 0 <= pos.x && pos.x < self.w
    }
}

// ダイクストラ法で問題を解く
struct Dijkstra {
    // 盤面データ
    var b: Board
    // スタート
    var start: Position
    // ゴール
    var goal: Position
    // ゴールまでの経路
    var r: Route?

    init(board: Board, start: Position, goal: Position) {
        self.b = board
        self.start = start
        self.goal = goal
        self.r = nil
    }

    // 優先度付きキューの優先度判定関数
    static func less(l: Route, r: Route) -> Bool {
        return l.cost < r.cost
    }

    // 実行
    mutating func run() {
        // チェックするマス
        var open = Heap<Route>(priorityFunction: Dijkstra.less)
        // チェック済みのマス
        var closed: [Position: Bool] = [:]
        let startRoute = Route(pos: self.start, cost: self.b.getCost(self.start), ref: nil)
        open.Push(startRoute)
        while !open.isEmpty {
            let st = open.Pop()!
            // ゴールならルートを退避して終了
            if st.pos == self.goal {
                // ゴール
                self.r = st
                return
            }
            // すでに探索済みマスなら処理を飛ばす
            if closed[st.pos] != nil {
                continue
            }
            closed.updateValue(true, forKey: st.pos)
            // 次に移動するマスを追加する
            for move in MOVABLE_DIRECTION {
                let nextPos = st.pos + move
                if b.isWithinRange(nextPos) {
                    let nextCost = st.cost + b.getCost(nextPos)
                    open.Push(Route(pos: nextPos, cost: nextCost, ref: st))
                }
            }
        }
        return
    }
}

/////////////////////////////////////////
// ここから優先度付きキューのためのheap
struct Heap<T> {
    // バッファ　二分木の構造でデータを保存する
    private var data: [T]
    // 優先度判定関数 true:1番目の引数を優先
    private let priorityFunction: (T, T) -> Bool

    // コンストラクタ
    // i data             : 初期データ配列
    //   priorityFunction : データの優先度を判定する関数
    //     @escaping を指定することで外部で定義された関数がエスケープされる
    //     指定しないときは、関数を即時実行し残す必要がない場合
    public init(data: [T] = [], priorityFunction: @escaping (T, T) -> Bool) {
        self.data = data
        self.priorityFunction = priorityFunction
        buildHeap() // heap用に二分木作成
    }

    // buildHeap はheap用に二分木を作成する
    // 構造体と列挙型は値型のため、デフォルトではインスタンス関数から値を変更することができない
    // mutatingを指定することで値を変更できるようになる
    private mutating func buildHeap() {
        // 二分木では層が増えるたびに二倍になるため、半分のデータを処理するだけでいい
        for index in stride(from: data.count / 2 - 1, to: 0, by: -1) {
            shiftDown(dataIndex: index)
        }
    }

    // isEmpty は要素が空か判定する
    public var isEmpty: Bool {
        return data.isEmpty
    }
    // count は要素の数を返す
    public var count: Int {
        return data.count
    }

    // Push は優先順に従って要素を追加する
    // i item : 追加する値
    public mutating func Push(_ item: T) {
        // 配列の最後に要素を追加し
        data.append(item)
        // 二分木を上に向かって配置位置を決める
        shiftUp(dataIndex: data.count - 1)
    }

    // Pop は優先順に従って要素を取り出し、バッファから削除する
    // o T : 取り出した値 バッファが空ならnilを返す
    public mutating func Pop() -> T? {
        if data.count == 0 {
            return nil
        }
        // 取り出す値は最も優先度が高い値で、バッファの0にある
        // 優先度が低い値はバッファの最後尾にある
        // 場所を入れ替えて0:優先度が低い、最後尾:優先度が最も高い状態にし
        // 最後尾の値を退避しバッファから削除する
        // 二分木の0:優先度が低い値を葉に向けて配置変えしていけば
        // 再び0に最も優先度が高い値が来る
        data.swapAt(0, data.count - 1)
        let item = data.removeLast()
        shiftDown(dataIndex: 0)

        return item
    }

/*
heapで使用する二分木は以下のように配列に格納する
幹から見て左の葉は"幹×2＋1"、右の葉は"高さ×2＋2"で求められる
葉から幹は"(葉−1)÷2"の商で求められる
高さ　　　配列の添字
1st            0
          /         \
2nd      1           2
       /   \       /   \
3rd   3     4     5     6
     / \   / \   /
4th 7   8 9  10 11
*/

    // shiftUp は上に向かって優先度に従い項目を移動する
    // i dataIndex : 移動対象項目
    private mutating func shiftUp(dataIndex index: Int) {
        var childIndex = index
        while true {
            // 親の位置を求める
            let parentIndex = (childIndex - 1) / 2
            // ルートに到達したか、優先度が幹、葉の順になっているなら終了
            if childIndex == parentIndex ||
               priorityFunction(data[parentIndex], data[childIndex]) {
                break
            }
            // 優先度にしたがって入れ替え
            data.swapAt(parentIndex, childIndex)
            // 処理対象が上へ向かって進む
            childIndex = parentIndex
        }
    }

    // shiftDown は下(葉)の方向に優先度に従い項目を移動する
    // i dataIndex : 移動対象項目
    private mutating func shiftDown(dataIndex index: Int) {
        // 入力データと左右の葉で優先度が高い方を取得する
        var parentIndex = index
        while true {
            // 左の葉
            let leftChildIndex = parentIndex * 2 + 1
            if leftChildIndex >= data.count {
                // これ以上葉が無いので終了
                break
            }
            var childIndex = leftChildIndex
            // 右の葉
            let rightChildIndex = parentIndex * 2 + 2
            if rightChildIndex < data.count {
                // 左右の葉で優先度判定する
                if priorityFunction(data[rightChildIndex], data[leftChildIndex]) {
                    childIndex = rightChildIndex
                }
            }
            // 幹と葉で優先度を判定する
            if priorityFunction(data[parentIndex], data[childIndex]) {
                // 幹、葉で優先度が正しく並んでいるので終了
                break
            }
            // 葉のほうが優先度が高いので入れ替える
            data.swapAt(parentIndex, childIndex)
            // 処理対象が下へ向かって進む
            parentIndex = childIndex
        }
    }
}
// ここまで優先度付きキューのためのheap
/////////////////////////////////////////

// 入力文字列を盤面の行数に変換する
// i string : 入力文字列
// o Int    : 盤面の行数
//   throws : GridDijkstraD3Error.invalidH, GridDijkstraD3Error.hOutOfRange
func toH(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let h = Int(string) else {
        throw GridDijkstraD3Error.invalidH(string: string)
    }
    // 範囲チェック
    if h < 1 || 20 < h {
        throw GridDijkstraD3Error.hOutOfRange(number: h)
    }
    // 盤面の行数を返す
    return h
}

// 入力文字列を盤面の列数に変換する
// i string : 入力文字列
// o Int    : 盤面の列数
//   throws : GridDijkstraD3Error.invalidH, GridDijkstraD3Error.hOutOfRange
func toW(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let w = Int(string) else {
        throw GridDijkstraD3Error.invalidW(string: string)
    }
    // 範囲チェック
    if w < 1 || 20 < w {
        throw GridDijkstraD3Error.wOutOfRange(number: w)
    }
    // 盤面の列数を返す
    return w
}

// 入力文字列をマスのコストに変換する
// i string : 入力文字列
// o Int    : マスのコスト
//   throws : GridDijkstraD3Error.invalidCost, GridDijkstraD3Error.costOutOfRange
func toCost(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let cost = Int(string) else {
        throw GridDijkstraD3Error.invalidCost(string: string)
    }
    // 範囲チェック
    if cost < 0 || 100 < cost {
        throw GridDijkstraD3Error.costOutOfRange(number: cost)
    }
    // マスのコストを返す
    return cost
}

// inputData は標準入力からデータを取り込む
// o Board? : 取り込みデータ　失敗した場合はnilを返す
func inputData() -> Board? {
    // 標準エラー出力
    var errorStream = StandardErrorOutputStream()
    // 1 行目には盤面の行数を表す h , 盤面の列数を表す w が与えられます。
    guard let line1 = readLine() else {
        print("1行目の標準入力に失敗しました。", to: &errorStream)
        return nil
    }
    let items1 = line1.split(separator: " ")
    if items1.count != 2 {
        print("1行目が無効なデータです。[" + line1 + "]", to: &errorStream)
        return nil
    }
    do {
        let h = try toH(String(items1[0]))   // 盤面の行数
        let w = try toW(String(items1[1]))   // 盤面の列数
        var board = Board(height: h, width: w)
        // 続く h 行の各行では i 行目 (0 ≦ i < h) には、盤面が与えられます。
        // t_{i,j} は i 行目の j 列目のコストです。
        for i in 0..<board.h {
            guard let line2 = readLine() else {
                print(String(i + 2) + "行目の標準入力に失敗しました。", to: &errorStream)
                return nil
            }
            // マスのコスト追加
            let items2 = line2.split(separator: " ")
            if items2.count != board.w {
                print(String(i + 2) + "行目が無効なデータです。[" + line2 + "]", to: &errorStream)
                return nil
            }
            for j in 0..<board.w {
                let cost = try toCost(String(items2[j]))
                board.cell[j][i] = cost
            }
        }
        // 入力データを返す
        return board
    } catch GridDijkstraD3Error.invalidH(let str) {
        // 標準エラー出力にプリント
        print("「盤面の行数」が無効です。[" + str + "]", to: &errorStream)
    } catch GridDijkstraD3Error.hOutOfRange(let num) {
        print("「盤面の行数」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch GridDijkstraD3Error.invalidW(let str) {
        print("「盤面の列数」が無効です。[" + str + "]", to: &errorStream)
    } catch GridDijkstraD3Error.wOutOfRange(let num) {
        print("「盤面の列数」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch GridDijkstraD3Error.invalidCost(let str) {
        print("「マスのコスト」が無効です。[" + str + "]", to: &errorStream)
    } catch GridDijkstraD3Error.costOutOfRange(let num) {
        print("「マスのコスト」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch {
        print("不明なエラーです。\(error)", to: &errorStream)
    }
    return nil
}

// computeData は問題を解く
func computeData(board: Board) throws -> Dijkstra {
    // 問題を解く
    let start = Position(x: 0, y: 0)
    let goal = Position(x: board.w - 1, y: board.h - 1)
    var answer = Dijkstra(board: board, start: start, goal: goal)
    answer.run()
    return answer
}

// outputData は結果を出力する
func outputData(data: Dijkstra) throws {
    var travel = data.r
    // コストを出力
    print(travel!.cost)
    // ルートをゴールから出力
    while travel != nil {
        print("--")
        for y in 0..<data.b.h {
            for x in 0..<data.b.w {
                if travel!.pos.x == x && travel!.pos.y == y {
                    print("*", terminator: "")
                } else {
                    print(" ", terminator: "")
                }
                print(String(data.b.cell[x][y]), terminator: "")
            }
            print("")
        }
        travel = travel!.ref
    }
    return
}

// メイン関数
func main() {
    // 標準エラー出力
    var errorStream = StandardErrorOutputStream()

    // 入力データ取り込み
    guard let d: Board = inputData() else {
        exit(1)
    }
    do {
        // 処理実行
        let answer = try computeData(board: d)
        try outputData(data: answer)
    } catch {
        print("不明なエラーです。\(error)", to: &errorStream)
        exit(1)
    }
}

// エントリーポイント
main()
