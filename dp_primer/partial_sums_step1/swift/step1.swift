/*
これはpaizaラーニングの「DPメニュー」から「部分和問題 2」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_partial_sums_step1

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1行目に、おもりの個数 n と目標とする重さの和 x が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let x = Int(items[1])!
    // 続く n 行のうち i 行目では、おもり i の重さ a_i が与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    for i in 0..<n {
        a[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    // 動的計画法で漸化式を計算

    // 重さを添字とした配列dpを初期化する
    var dp: [Int] = [Int](repeating: 0, count: x+1)
    // おもりを選ばなければ、重さの和を0とすることができる
    dp[0] = 1
    // おもり i までのおもりを使って
    for i in 0..<n {
        // 重さの和を j とすることができるか？
        // 大きい方から逆にループしないと複数の重りを組み合わせたときに正しく計算できない
        for j in (a[i]...x).reversed() {
            // 配列が求めたい重さ j から 追加する重さ a_i を引いたときに
            // true なら和を求めることができる
            if (dp[j - a[i]] > 0) {
                dp[j] = (dp[j] + dp[j-a[i]]) % 1000000007
            }
        }
    }
    // 結果出力
    print(dp[x])
}

// エントリーポイント
main()
