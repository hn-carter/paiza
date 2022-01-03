/*
これはpaizaラーニングの「DPメニュー」から「最安値を達成するには 1 」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_step0

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行でほしいりんごの個数 n、1個が a 円で、りんご2個が b 円が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let a = Int(items[1])!
    let b = Int(items[2])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+1)
    // 1段目は1通りの上り方
    dp[0] = 0
    dp[1] = a
    for i in 2...n {
        dp[i] = min(dp[i-1]+a, dp[i-2]+b)
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
