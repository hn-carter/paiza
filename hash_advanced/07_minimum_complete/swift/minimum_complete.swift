/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「最小完全ハッシュ関数を作ろう」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__minimum_complete

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ハッシュ関数X
// parameters
//   s: 文字列
// return sのハッシュ値
func hashFunction(_ s: String) -> Int {
    let string = "abcdef"
    var total = 0
    let length = s.count
    for (i, char) in zip(s.indices, s) {
        if let index = string.firstIndex(of: char)?.utf16Offset(in: string) {
            let iInt = i.utf16Offset(in: s)
            total += index * Int(pow(6.0, Double(length - iInt - 1)))
        }
    }
    return total
}

// 最小完全ハッシュ関数を作る
func main() {
    // 文字列 s が与えられます。
    let s = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    // ハッシュ値を求める
    let hashValue = hashFunction(s)
    // 結果出力
    print(hashValue)
}
// エントリーポイント
main()
