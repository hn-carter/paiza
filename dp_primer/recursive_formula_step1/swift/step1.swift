/*
これはpaizaラーニングの「DPメニュー」から「2項間漸化式 2」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step1


作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目では、数列の初項 x と公差 d が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let x = Int(items[0])!
    let d = Int(items[1])!
    // 2行目では、3行目以降で与えられる入力の行数 Q が与えられます。
    let Q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く Q 行のうち i 行目では、k_i が与えられます。
    var k: [Int] = [Int](repeating: 0, count: Q)
    for i in 0..<Q {
        k[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    // 動的計画法で漸化式を計算
    var dp: [Int] = [Int](repeating: 0, count: Q)
    dp[0] = x
    for i in 1..<Q {
        dp[i] = dp[i-1] + d
    }
    // 結果出力
    for v in k {
        print(dp[v-1])
    }
}

// エントリーポイント
main()
