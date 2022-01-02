/*
これはpaizaラーニングの「DPメニュー」から「【階段の上り方】階段の上り方 3」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行で階段の段数n、1歩で登る段数a,b,cが与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    // 1度に登る段数
    var steps: [Int] = [Int](repeating: 0, count: 3)
    steps[0] = Int(items[1])!
    steps[1] = Int(items[2])!
    steps[2] = Int(items[3])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+1)
    // 1段目は1通りの上り方
    dp[0] = 1
    for i in 1...n {
        for v in steps {
            if i >= v {
                // v段下からv段上がる
                dp[i] += dp[i-v]
            }
        }
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
