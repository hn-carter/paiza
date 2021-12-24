/*
これはpaizaラーニングの「DPメニュー」から「2項間漸化式 1」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step0

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目に、整数 x, d, k が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let x = Int(items[0])!
    let d = Int(items[1])!
    let k = Int(items[2])!
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: k)
    dp[0] = x
    for i in 1..<k {
        dp[i] = dp[i-1] + d
    }
    // 結果出力
    print(dp[k-1])
}

// エントリーポイント
main()
