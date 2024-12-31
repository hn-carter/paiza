/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ハッシュテーブルを使おう（チェイン法）」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__chain

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 片方向リストに保存するデータ
class Node {
    var value: String
    var next: Node?
    init(value: String) {
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
    mutating func append(value: String) {
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
    mutating func remove(value: String) {
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
            result = currentNode!.value
            currentNode = currentNode!.next
        } else {
            return ""
        }
        while currentNode != nil {
            result += " "
            result += currentNode!.value
            currentNode = currentNode!.next
        }
        return result
    }
}

// ハッシュ関数
// H(p) = (d の 1 文字目の文字コード * B^1 + d の 2 文字目の文字コード * B^2 + ... +
// d の m 文字目の文字コード * B^m) % mod
// B = 7、mod = 100、文字コード ASCII
func hashFunction(_ text: String) -> Int {
    var total: Int = 0
    for (index, char) in zip(text.indices, text) {
        let i = index.utf16Offset(in: text) + 1
        total += Int(char.asciiValue ?? 0) * Int(pow(7.0, Double(i)))
    }
    let h = total % 100
    return h
}

// ハッシュテーブルをチェイン法で操作する
func main() {
    // ハッシュテーブル
    var hashTable: [LinkedList] = Array(repeating: LinkedList(), count: 100)
    // 1 行目にクエリの数を表す整数 Q が与えられます。
    let q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    // 1 + i 行目に各クエリが与えられます。(1 ≦ i ≦ Q)
    for _ in 0..<q {
        let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        let items = line.split(separator: " ")
        switch items[0] {
            case "1":
                // ハッシュテーブルにデータ d を格納する
                let h = hashFunction(String(items[1]))
                hashTable[h].append(value: String(items[1]))
            case "2":
                // ハッシュテーブルの先頭から x 番目のデータを全て出力する
                // データがない場合は-1を出力する
                let x = Int(items[1]) ?? 1
                let dataString = hashTable[x-1].getAllData()
                if dataString.count == 0 {
                    print("-1")
                } else {
                    print(dataString)
                }
            case "3":
                // ハッシュテーブルのデータ d を削除する
                let h = hashFunction(String(items[1]))
                hashTable[h].remove(value: String(items[1]))
            default:
                break
        }
    }
}

// エントリーポイント
main()
