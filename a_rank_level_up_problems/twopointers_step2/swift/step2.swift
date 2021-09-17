/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「区間和の計算」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_twopointers_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、数列 A の要素数 N が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 2 行目には、数列 A の各要素 A_1, A_2 ... A_N が与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(items[i])!
    }
    // 区間の和を計算
    var sum: [Int] = [Int](repeating: 0, count: n)
    sum[0] = a[0]
    for i in 1..<n {
        sum[i] = sum[i-1] + a[i]
    }
    // 3 行目には、クエリの数 num が与えられます。
    let num = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く n 行には、各クエリに用いる整数 l_i u_i (1 ≦ i ≦ n) が与えられます。
    var answer = [Int](repeating: 0, count: num)
    for i in 0..<num {
        let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let l  = Int(itemsA[0])!
        let u  = Int(itemsA[1])!
        if l > 0 {
            answer[i] = sum[u] - sum[l-1]
        } else {
            answer[i] = sum[u]
        }
    }
    // 結果出力
    for i in answer {
        print(i)
    }
}

// エントリーポイント
main()