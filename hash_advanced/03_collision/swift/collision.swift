/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ハッシュテーブルの衝突」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__collision

作成環境
Ubuntu 22.04.5 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ハッシュ値１を求める
// parameters
//   dateNumber 日付を表す値yyyyMMdd
// return ハッシュ値１
func getHash1(dateNumber: Int) -> Int {
    return dateNumber % 10000
}

// ハッシュ値２を求める
// parameters
//   dateNumber 日付を表す値yyyyMMdd
// return ハッシュ値２
func getHash2(dateNumber: Int) -> Int {
    return dateNumber / 10000
}

// メイン関数
// ハッシュテーブルの衝突数を求める
func main() {
    // 1 行目にデータの数を表す整数 N が与えられます
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    // ハッシュ値の衝突を判定する配列を用意する
    var h1Table: [Int] = Array(repeating: 0, count: 10000)
    var h2Table: [Int] = Array(repeating: 0, count: 2023)
    // i + 1 行目に日付を表す整数 d_i が与えられます。(1 ≦ i ≦ N)
    for _ in 0..<n {
        let d_n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        // ハッシュ値を求め判定配列に設定する
        let h1 = getHash1(dateNumber: d_n)
        h1Table[h1] += 1
        let h2 = getHash2(dateNumber: d_n)
        h2Table[h2] += 1
    }
    // 衝突したハッシュ値を数える
    var h1Counter = 0
    h1Table.forEach({ n in
        if n > 1 {
            h1Counter += n - 1
        }
    })
    var h2Counter = 0
    h2Table.forEach({ n in
        if n > 1 {
            h2Counter += n - 1
        }
    })
    print(h1Counter)
    print(h2Counter)
}

// エントリーポイント
main()
