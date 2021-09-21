/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「区間の積」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_twopointers_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 条件を満たす A の部分列の最短の長さを求める
func compute(a: [Int64], k: Int64) -> Int {
    let len = a.count
    var l = 0
    var u = 0
    var sum: Int64 = a[0]
    var minLen = len
    while true {
        // デバッグプリント
        //print("sum = \(sum), l = \(l), u = \(u), minLen = \(minLen)")
        if sum >= k {
            // 左端の値が1ならさらに区間長を短縮できるかも
            while (l < u && a[l] == 1) {
                l += 1
            }
            // 要素の積が K 以上になったので区間長を判定する
            let curLen = u - l + 1
            if minLen > curLen {
                minLen = curLen
            }
            sum /= a[l]
            l += 1
        }
        u += 1
        // 配列Aの終わりまで見たら終了
        if u == len {
            break
        }
        // 0は含めないのて左端位置も更新する
        if a[u] == 0 {
            sum = 0
            l = u + 1
        } else {
            if sum == 0 {
                sum = a[u]
            } else {
                sum *= a[u]
            }
        }
    }
    return minLen
}

// メイン関数
func main() {
    // 1 行目には、数列 A の要素数 N と、条件に使う整数 K が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int64(items[1])!
    // 2 行目には、数列 A の各要素 A_1, A_2 ... A_N が与えられます。A_i は、0, 1, 2のいずれか
    var a: [Int64] = [Int64](repeating: 0, count: n)
    let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int64(itemsA[i])!
    }
    // 計算
    let answer = compute(a: a, k: k)

    // 結果出力
    print(answer)
}

// エントリーポイント
main()