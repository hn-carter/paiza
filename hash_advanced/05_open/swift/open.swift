/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ハッシュテーブルを使おう（オープンアドレス法）」に
swiftでチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__open

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ハッシュ関数で使用する定数
let B: Int = 997
let mod: Int = 1000
// ハッシュテーブル
var hashTable: [String] = Array(repeating: "", count: mod)

// ハッシュ関数
// H(p) = (d の 1 文字目の文字コード * B^1 + d の 2 文字目の文字コード * B^2 + ... +
// d の m 文字目の文字コード * B^m) % mod
// B = 997、mod = 1000、文字コード ASCII
func hashFunction(_ text: String) -> Int {
    var total: Int = 0
    for (index, char) in zip(text.indices, text) {
        let i = index.utf16Offset(in: text) + 1
        var power = 1
        for _ in 1...i {
            power *= B
            if power > (mod * 10) {
                power %= (mod * 10)
            }
        }
        total += Int(char.asciiValue ?? 0) * power % (mod * 10)
    }
    let h = total % mod
    return h
}

// ハッシュテーブルにデータを追加する
// parameters
//   text 文字列
// return なし
func addData(_ text: String) {
    var h = hashFunction(text)
    let endH = h
    while hashTable[h] != "" {
        h += 1
        if h >= mod {
            h = 0
        }
        if h == endH {
            // ハッシュテーブルが満杯で追加できない
            return
        }
    }
    hashTable[h] = text
}

// ハッシュテーブルにデータがあるか検索する
// parameters
//   text 文字列
// return ハッシュテーブルの位置 1からmod ない場合は -1
func existsData(_ text: String) -> Int {
    var h = hashFunction(text)
    let endH = h
    while hashTable[h] != text {
        h += 1
        if h >= mod {
            h = 0
        }
        if h == endH {
            // ハッシュテーブルにない
            return -2
        }
    }
    return h + 1
}

// ハッシュテーブルをオープンアドレス法で操作する
func main() {
    // 1 行目にクエリの数を表す整数 Q が与えられます。
    let q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    // 1 + i 行目に各クエリが与えられます。(1 ≦ i ≦ Q)
    for _ in 0..<q {
        let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        let items = line.split(separator: " ")
        switch items[0] {
            case "1":
                // ハッシュテーブルにデータ d を格納する
                addData(String(items[1]))
            case "2":
                // ハッシュテーブルにデータ d が格納されているか調べ
                // 存在するなら先頭から何番目かを出力
                // ない場合は-1を出力する
                let ret = existsData(String(items[1]))
                print(ret)
            default:
                break
        }
    }
}

// エントリーポイント
main()
