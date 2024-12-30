/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「画像のハッシュ値」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__picture

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

/// メイン関数
// 画像のハッシュ値を求める
// H(picture) = 各 # の (i^2 * j) の和 % 100
func main() {
    // 各 # についてその位置 i, j を求めて (i^2 * j)の合計
    var total: Int = 0
    // 6行の画像 (picture)を処理する
    for i in 1...6 {
        let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        // 1行を1文字ずつ処理する
        for (index, char) in zip(line.indices, line) {
            if char == "#" {
                let j = index.utf16Offset(in: line) + 1
                let h = Int(pow(Double(i), 2.0)) * j
                total += h
            }
        }
    }
    // ハッシュ値    
    let hash = total % 100
    print(hash)
}

// エントリーポイント
main()
