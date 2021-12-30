/*
これはpaizaラーニングの「DPメニュー」から「3項間漸化式 2」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目では、2行目以降で与えられる入力の行数 Q が与えられます。
    let Q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く Q 行のうち i 行目では、k_i が与えられます。
    var k: [Int] = [Int](repeating: 0, count: Q)
    var max: Int = 0
    for i in 0..<Q {
        k[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
        if k[i] > max {
            max = k[i]
        }
    }
    // 動的計画法で漸化式を計算
    // フィボナッチ数列を格納する配列
    var dp: [Int] = [Int](repeating: 0, count: max)
    // 0 は 1
    dp[0] = 1
    // 1 は 1
    if max > 1 {
        dp[1] = 1
    }
    if max > 2 {
        for i in 2..<max {
            dp[i] = dp[i-2] + dp[i-1]
        }
    }
    // 結果出力
    for v in k {
        print(dp[v-1])
    }
}

// エントリーポイント
main()
