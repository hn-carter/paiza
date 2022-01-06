/*
これはpaizaラーニングの「DPメニュー」から「【最安値】最安値を達成するには 4」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_apples_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行でほしいりんごの個数 n、りんごの値段 x 個で a 円、りんご y 個で b 円、
    // りんご z 個で c 円が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    var xyz: [Int] = [Int](repeating: 0, count: 3)
    var abc: [Int] = [Int](repeating: 0, count: 3)
    for i in 0..<3 {
        xyz[i] = Int(items[1+i*2])!
        abc[i] = Int(items[2+i*2])!
    }
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: n+xyz[2])
    // 1段目は1通りの上り方
    dp[0] = 0
    for i in 1..<n+xyz[2] {
        var minPrice = Int.max
        for j in 0..<3 {
            if i >= xyz[j] {
                // i 個のりんごを買うのに最小の金額を求める
                for k in 0...j {
                    minPrice = min(minPrice, dp[i-xyz[k]] + abc[k])
                }
            }
        }
        if minPrice == Int.max {
            minPrice = abc[0]
        }
        dp[i] = minPrice
    }
    // 結果出力
    print(dp[n])
}

// エントリーポイント
main()
