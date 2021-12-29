/*
これはpaizaラーニングの「DPメニュー」から「3項間漸化式 1」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step4

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行で、整数 k が与えられます
    let k = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 動的計画法で漸化式を計算
    // フィボナッチ数列を格納する配列
    var dp: [Int] = [Int](repeating: 0, count: k)
    // 0 は 1
    dp[0] = 1
    // 1 は 1
    if k > 1 {
        dp[1] = 1
    }
    for i in 2..<k {
        dp[i] = dp[i-2] + dp[i-1]
    }
    // 結果出力
    print(dp[k-1])
}

// エントリーポイント
main()
