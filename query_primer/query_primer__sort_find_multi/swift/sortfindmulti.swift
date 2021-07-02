// これはpaizaラーニングの「クエリメニュー」から「ソートと検索(query)」
// https://paiza.jp/works/mondai/query_primer/query_primer__sort_find_multi
// にswiftでチャレンジした試行錯誤コードです。
import Foundation

// このプログラムで使用する例外
enum SortFindMultiError: Error {
    case invalidN(string: String)               // クラス人数が無効
    case nOutOfRange(number: Int)               // クラス人数が範囲外
    case invalidK(string: String)               // イベント回数が無効
    case kOutOfRange(number: Int)               // イベント回数が範囲外
    case invalidP(string: String)               // paiza身長が無効
    case pOutOfRange(height: Int)               // paiza身長が範囲外
    case invalidClassmate(string: String)       // クラスメイト身長が無効
    case classmateOutOfRange(height: Int)       // クラスメイト身長が範囲外
    case invalidEvent(string: String)           // イベントが無効
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

// 入力データ
struct Data {
    // paiza君を除いたクラスの人数
    var n: Int
    // イベントの回数
    var k: Int
    // paiza君の身長
    var p: Int
    // paiza君を含めた生徒の身長
    var students: [Int]
    // イベント
    var event: [String]
    // イニシャライザ
    // i people : 人数
    //   times  : 回数
    //   height : 身長
    init(people: Int, times: Int, height: Int) {
        // イニシャライザでは全てのプロパティを初期化しないといけない
        self.n = people
        self.k = times
        self.p = height
        self.students = []
        self.event = []
    }
}

// 入力文字列をpaiza君を除いたクラスの人数に変換する
//   Swiftでは'throws'で関数が例外を投げることができることを示す
//   呼び出し側では'try'で受ける必要がある
// i string : 入力文字列
// o Int    : paiza君を除いたクラスの人数
//   throws : SortFindMultiError.invalidN, SortFindMultiError.nOutOfRange
func toN(_ string: String) throws -> Int {
    // 文字列を数値に変換
    // Intは数値変換できなかった場合nilを返す
    guard let n = Int(string) else {
        // 数値変換失敗
        throw SortFindMultiError.invalidN(string: string)
    }
    // 範囲チェック
    if n < 1 || 100000 < n {
        throw SortFindMultiError.nOutOfRange(number: n)
    }
    // paiza君を除いたクラスの人数を返す
    return n
}

// 入力文字列をイベントの回数に変換する
// i string : 入力文字列
// o Int    : イベントの回数
//   throws : SortFindMultiError.invalidK, SortFindMultiError.kOutOfRange
func toK(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let k = Int(string) else {
        throw SortFindMultiError.invalidK(string: string)
    }
    // 範囲チェック
    if k < 1 || 100000 < k {
        throw SortFindMultiError.kOutOfRange(number: k)
    }
    // イベントの回数を返す
    return k
}

// 入力文字列をpaiza君の身長に変換する
// i string : 入力文字列
// o Int    : paiza君の身長
//   throws : SortFindMultiError.invalidP, SortFindMultiError.pOutOfRange
func toP(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let p = Int(string) else {
        throw SortFindMultiError.invalidP(string: string)
    }
    // 範囲チェック
    if p < 100 || 200 < p {
        throw SortFindMultiError.pOutOfRange(height: p)
    }
    // paiza君の身長を返す
    return p
}

// 入力文字列をクラスメイトの身長に変換する
// i string : 入力文字列
// o Int    : クラスメイトの身長
//   throws : SortFindMultiError.invalidClassmate, SortFindMultiError.classmateOutOfRange
func toA(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let a = Int(string) else {
        // 数値変換失敗
        throw SortFindMultiError.invalidClassmate(string: string)
    }
    // 範囲チェック
    if a < 100 || 200 < a {
        throw SortFindMultiError.classmateOutOfRange(height: a)
    }
    // クラスメイトの身長を返す
    return a
}

// 入力文字列を追加するクラスメイトの身長に変換する
// i string : 入力文字列
// o Int    : クラスメイトの身長
//   throws : SortFindMultiError.invalidEvent
func toNum(_ string: String) throws -> Int {
    // 文字列を数値に変換
    guard let num = Int(string) else {
        // 数値変換失敗
        throw SortFindMultiError.invalidEvent(string: string)
    }
    // 範囲チェック
    if num < 100 || 200 < num {
        throw SortFindMultiError.invalidEvent(string: string)
    }
    // クラスメイトの身長を返す
    return num
}

// 入力文字列をイベントに変換する
// i string : 入力文字列
// o String : イベント
//   throws : SortFindMultiError.invalidEvent
func toEvent(_ string: String) throws -> String {
    // 複雑なイベントであればデータの持ち方を工夫するけど
    // 単純なので実行時に解析する

    // ここではそのまま返す
    return string
}

// inputData は入力データを取り込む
func inputData() -> Data? {
    // 標準エラー出力
    var errorStream = StandardErrorOutputStream()
    // 1 行目では、paizaくんを除いたクラスの人数Nと起こるイベントの回数Kと
    // paiza君の身長Pが与えられます。
    guard let line1 = readLine() else {
        print("1行目の標準入力に失敗しました。", to: &errorStream)
        return nil
    }
    let items = line1.split(separator: " ")
    if items.count != 3 {
        print("1行目が無効なデータです。[" + line1 + "]", to: &errorStream)
        return nil
    }
    do {
        let n = try toN(String(items[0]))   // paiza君を除いたクラスの人数
        let k = try toK(String(items[1]))   // イベントの回数
        let p = try toP(String(items[2]))   // paiza君の身長
        var result = Data(people: n, times: k, height: p)
        // 続く N 行では、初めにクラスにいる N 人の生徒の身長が与えられます
        for i in 1...result.n {
            guard let line2 = readLine() else {
                print(String(i + 1) + "行目の標準入力に失敗しました。", to: &errorStream)
                return nil
            }
            // クラスメイトの身長を追加
            let height = try toA(line2)
            result.students.append(height)
        }
        // 続く K 行では、起こるイベントを表す文字列が与えられます
        for i in 1...result.k {
            guard let line3 = readLine() else {
                print(String(i + 1 + result.n) + "行目の標準入力に失敗しました。", to: &errorStream)
                return nil
            }
            let event = try toEvent(line3)
            // イベント配列の最後に追加
            result.event.append(event)
        }
        // クラスメイトの身長にpaiza君も追加する
        result.students.append(result.p)
        // 入力データを返す
        return result
    } catch SortFindMultiError.invalidN(let str) {
        // 標準エラー出力にプリント
        print("「paiza君を除いたクラスの人数」が無効です。[" + str + "]", to: &errorStream)
    } catch SortFindMultiError.nOutOfRange(let num) {
        print("「paiza君を除いたクラスの人数」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch SortFindMultiError.invalidK(let str) {
        print("「イベントの回数」が無効です。[" + str + "]", to: &errorStream)
    } catch SortFindMultiError.kOutOfRange(let num) {
        print("「イベントの回数」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch SortFindMultiError.invalidP(let str) {
        print("「paiza君の身長」が無効です。[" + str + "]", to: &errorStream)
    } catch SortFindMultiError.pOutOfRange(let num) {
        print("「paiza君の身長」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch SortFindMultiError.invalidClassmate(let str) {
        print("「生徒の身長」が無効です。[" + str + "]", to: &errorStream)
    } catch SortFindMultiError.classmateOutOfRange(let num) {
        print("「生徒の身長」が範囲外です。[" + String(num) + "]", to: &errorStream)
    } catch SortFindMultiError.invalidEvent(let str) {
        print("「イベント」が無効です。[" + str + "]", to: &errorStream)
    } catch {
        print("不明なエラーです。\(error)", to: &errorStream)
    }
    return nil
}

// computeData は処理を実行する
func computeData(data: Data) throws {
    // 引数は定数のため同名の変数を作る
    var data = data
    // 0〜イベントの回数未満ループ
    for i in 0..<data.k {
        let event = data.event[i].split(separator: " ")
        switch event[0] {
            case "join":    // 身長 num(cm) の生徒を加える。
                // toNumが投げた例外はここで処理せずにそのまま呼び出し元へ投げる
                let num: Int = try toNum(String(event[1]))
                data.students.append(num)
            case "sorting":   // 生徒が背の順に並ぶ。paiza君の並び位置を表示
                // 身長をソート
                data.students.sort()
                // paiza君の身長を検索し位置を表示
                if let index = data.students.firstIndex(of: data.p) {
                    print(String(index + 1))
                }
            default:
                // 無効なイベント
                throw SortFindMultiError.invalidEvent(string: data.event[i])
        }
    }
}

// メイン関数
func main() {
    // 標準エラー出力
    var errorStream = StandardErrorOutputStream()

    // 入力データ取り込み
    if let d: Data = inputData() {
        do {
            // 処理実行
            try computeData(data: d)
        } catch SortFindMultiError.invalidEvent(let str) {
            print("「イベント」が無効です。[" + str + "]", to: &errorStream)
            exit(1)
        } catch {
            print("不明なエラーです。\(error)", to: &errorStream)
            exit(1)
        }
    } else {
        // 入力データを読み込んだ結果がnilならここに来る
        exit(1)
    }
    // 返り値がnilならプログラムをすぐに終了する場合、guard letを使う
    // 気分的にif letを使ってみたかっただけで、guard letならネストが深くなることもない
}

// エントリーポイント
main()
