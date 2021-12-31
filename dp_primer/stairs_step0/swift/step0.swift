/*
これはpaizaラーニングの「DPメニュー」から「階段の上り方 1」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_step0

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行で、階段の段数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+1)
    // 1段目は1通りの上り方
    dp[0] = 1
    for i in 1...n {
        if i >= 1 {
            // 1段下から1段上がる
            dp[i] = dp[i-1]
        }
        if i >= 2 {
            // 2段下から2段上がる
            dp[i] += dp[i-2]
        }
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
