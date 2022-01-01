/*
これはpaizaラーニングの「DPメニュー」から「階段の上り方 2」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_step1


作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行で階段の段数n、1歩で登る段数a,bが与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let a = Int(items[1])!
    let b = Int(items[2])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+1)
    // 1段目は1通りの上り方
    dp[0] = 1
    for i in 1...n {
        if i >= a {
            // a段下からa段上がる
            dp[i] = dp[i-a]
        }
        if i >= b {
            // b段下からb段上がる
            dp[i] += dp[i-b]
        }
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
