/*
これはpaizaラーニングの「DPメニュー」から「部分和問題 3」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dp_primer/dp_primer_partial_sums_step2

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

    // 重さを添字とした配列dpを初期化する
    var dp: [Int] = [Int](repeating: n+1, count: x+1)
    // おもりの合計を 0 にするには 0 個の重りを使う
    dp[0] = 0
    // おもり i までのおもりを使って
    for i in 0..<n {
        // 重さの和を j とすることができるか？
        // 大きい方から逆にループしないと複数の重りを組み合わせたときに正しく計算できない
        if a[i] <= x {
            for j in (a[i]...x).reversed() {
                // 配列が求めたい重さ j から 追加する重さ a_i を引いたときに
                // 作れる重さならカウント
                if dp[j - a[i]] != n+1 {
                    // おもりの個数が少ない方
                    dp[j] = min(dp[j], dp[j-a[i]] + 1)
                }
            }
        }
    }
    // 結果出力
    if dp[x] == n+1 {
        // 組み合わせが見つからなかった
        print("-1")
    } else {
        print(dp[x])
    }
}

// エントリーポイント
main()