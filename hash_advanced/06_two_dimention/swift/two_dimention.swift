/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「2 次元のハッシュテーブルを使おう」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__two_dimention

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 点の個数
var N: Int = 0
// 調べる整数の組の個数
var M: Int = 0
// ハッシュ関数で使用
var A: Int = 0
var B: Int = 0

// 座標
class Point: CustomStringConvertible {
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    // 等価演算子オーバーロード
    static func == (left: Point, right: Point) -> Bool {
        return left.x == right.x && left.y == right.y
    }
    // 不等価演算子オーバーロード
    static func != (left: Point, right: Point) -> Bool {
        return left.x != right.x || left.y != right.y
    }
    // 文字列表現
    var description: String {
        return "\(self.x) \(self.y)"
    }
}

// 片方向リストに保存するデータ
class Node {
    var value: Point
    var next: Node?
    init(value: Point) {
        self.value = value
        self.next = nil
    }
}

// 片方向リスト
struct LinkedList {
    // 先頭
    var head: Node? = nil
    // 末尾
    var tail: Node? = nil

    // 末尾にデータを追加
    // parameters
    //   value 追加する値
    mutating func append(value: Point) {
        let newNode = Node(value: value)
        if self.head == nil {
            self.head = newNode
            self.tail = newNode
        } else {
            self.tail!.next = newNode
            self.tail = newNode
        }
    }

    // 値が等しいデータを削除
    // parameters
    //   value 削除する値
    mutating func remove(value: Point) {
        if self.head == nil {
            return
        }
        var previousNode: Node? = nil
        var currentNode: Node? = self.head
        while currentNode != nil {
            if currentNode!.value == value {
                // このノードを削除
                // 先頭を削除したなら更新します
                if previousNode == nil {
                    self.head = currentNode!.next
                } else {
                    previousNode!.next = currentNode!.next
                    // 末尾を削除したなら更新します
                    if currentNode!.next == nil {
                        self.tail = previousNode
                    }
                }
                return
            } else {
                // 次へ
                previousNode = currentNode
                currentNode = currentNode!.next
            }
        }
    }

    // リストの値を全て連結し返す
    // return スペース区切りの値
    func getAllData() -> String {
        var currentNode: Node? = self.head
        var result: String = ""
        if currentNode != nil {
            result = "(\(currentNode!.value))"
            currentNode = currentNode!.next
        } else {
            return ""
        }
        while currentNode != nil {
            result += ","
            result += "(\(currentNode!.value))"
            currentNode = currentNode!.next
        }
        return result
    }
}

class HashTable {
    // ハッシュ関数で使用
    private var a: Int
    private var b: Int
    // ハッシュテーブル　片方向リスト
    private var ht: [[LinkedList]]

    init(a: Int, b: Int) {
        self.a = a
        self.b = b
        self.ht = Array(repeating: Array(repeating: LinkedList(), count: B), count: A)
    }
    // ハッシュ関数X
    // Hx(X) = X % A
    // parameters
    //   x: X座標 1 ≦ X ≦ 100,000
    // return xのハッシュ値
    private func hashFunctionX(_ x: Int) -> Int {
        let hx = x % self.a
        return hx
    }
    // ハッシュ関数Y
    // Hy(Y) = Y % B
    // parameters
    //   y: Y座標 1 ≦ Y ≦ 100,000
    // return yのハッシュ値
    private func hashFunctionY(_ y: Int) -> Int {
        let hy = y % self.b
        return hy
    }
    // ハッシュテーブルに座標を追加する
    // parameters
    //   p: 追加する座標
    func append(_ p: Point) {
        let hx = self.hashFunctionX(p.x)
        let hy = self.hashFunctionY(p.y)
        self.ht[hx][hy].append(value: p)
    }

    // ハッシュテーブルから最後に追加された座標を取得する
    // parameters
    //   p: ハッシュテーブルの行番号 0 ≦ p ≦ A-1
    //   q: ハッシュテーブルの列番号 0 ≦ p ≦ B-1
    // return 座標
    func getTailValue(_ p: Int, _ q: Int) -> Point? {
        if let tail = self.ht[p][q].tail {
            return tail.value
        } else {
            return nil
        }
    }

    // ハッシュテーブルの内容を出力する
    func printHashTable() {
        var result = ""
        for r in self.ht {
            result += "["
            for (i, c) in r.enumerated() {
                if i > 0 {
                    result += ","
                }
                result += "[\(c.getAllData())]"
            }
            result += "]\n"
        }
        print(result)
    }
}

// 2次元のハッシュテーブルを使う
func main() {
    // 1 行目に点の個数を表す整数 N と調べる整数の組の個数を表す整数 M と
    // ハッシュ関数で用いる整数 A と B が与えられます
    let items1 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: " ")
    N = Int(items1[0]) ?? 0
    M = Int(items1[1]) ?? 0
    A = Int(items1[2]) ?? 0
    B = Int(items1[3]) ?? 0
    // 2 行目に点の X 座標を表す長さ N の整数列が与えられます
    let items2 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: " ")
    // 3 行目に点の Y 座標を表す長さ N の整数列が与えられます
    let items3 = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
                    .split(separator: " ")
    // 初期ハッシュテーブル作成
    let ht = HashTable(a: A, b: B)
    // ハッシュテーブルに座標を保存する
    for i in 0 ..< N {
        let x = Int(items2[i]) ?? 0
        let y = Int(items3[i]) ?? 0
        let p = Point(x: x, y: y)
        ht.append(p)
    }

    // -D DEBUG
    #if DEBUG
        // ハッシュテーブルの内容を出力
        ht.printHashTable()
    #endif

    // 3 + j 行目に調べる整数の組 p_j と q_j が与えられます (1 ≦ j ≦ M)
    for _ in 0..<M {
        let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        let items = line.split(separator: " ")
        let p = Int(items[0]) ?? 0
        let q = Int(items[1]) ?? 1
        if let tailPoint = ht.getTailValue(p, q) {
            print("\(tailPoint)")
        } else {
            print("-1")
        }
    }
}

// エントリーポイント
main()
