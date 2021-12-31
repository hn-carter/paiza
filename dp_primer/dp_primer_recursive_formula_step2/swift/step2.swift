/*
これはpaizaラーニングの「DPメニュー」から「特殊な2項間漸化式 1」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行で、数列の初項 x と公差 d_1, d_2, 求める k 項目が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let x = Int(items[0])!
    let d1 = Int(items[1])!
    let d2 = Int(items[2])!
    let k = Int(items[3])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: k+1)
    dp[1] = x
    if k > 1 {
        for i in 2...k {
            if (i % 2) == 0 {
                // 偶数
                dp[i] = dp[i-1] + d2
            } else {
                // 奇数
                dp[i] = dp[i-1] + d1
            }
        }
    }
    // 結果出力
    print(dp[k])
}

// エントリーポイント
main()
