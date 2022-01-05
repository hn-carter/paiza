/*
これはpaizaラーニングの「DPメニュー」から「最安値を達成するには 3」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行でほしいりんごの個数 n、りんごの値段 x 個で a 円、りんご y 個で b 円が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let x = Int(items[1])!
    let a = Int(items[2])!
    let y = Int(items[3])!
    let b = Int(items[4])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+y)
    // 1段目は1通りの上り方
    dp[0] = 0
    for i in 1..<n+y {
        if i <= x {
            dp[i] = a
        } else if i <= y {
            dp[i] = min(dp[i-x] + a, b)
        } else {
            dp[i] = min(dp[i-x] + a, dp[i-y] + b)
        }
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
