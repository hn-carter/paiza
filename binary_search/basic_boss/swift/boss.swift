/*
これはpaizaラーニングの「二分探索メニュー」の「ある範囲に含まれている整数の個数」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__basic_boss
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// ソート済みの数列 A で 値 k 以上の添字を返す
// 以下の値が存在しない場合には n を返す
// A : 数列, n : 数列のサイズ, k : 探索する値
func binary_search(A: [Int], n: Int, k: Int) -> Int {
    // 探索範囲 [left, right]
    var left = 0
    var right = n
    // 探索範囲を狭めていく
    while left < right {
        // 探索範囲の中央
        let mid = (left + right) / 2
        if A[mid] < k {
            // a[0]からa[mid]は k 未満の数
            left = mid+1
        } else {
            right = mid
        }
    }
    return right
}

// メイン関数
func main() {
    // 1行目に、数列の要素数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 2行目に、A_i が半角スペース区切りで与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(items[i])!
    }
    // 数列をソート
    a.sort()
    // 3行目に、与えられる整数の組の個数 q が与えられます。
    let q = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く q 行のうち i (1 ≦ i ≦ q) 行目に、整数の組 (l_i, r_i) が与えられます。
    // 探索結果
    var ans: [Int] = [Int]()
    for _ in 0..<q {
        let itemsQ = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let l = Int(itemsQ[0])!
        let r = Int(itemsQ[1])!
        // 検索実行
        let lp = binary_search(A: a, n: n, k: l)
        let rp = binary_search(A: a, n: n, k: r+1)
        ans.append(rp - lp)
    }
    // 結果出力
    for v in ans {
        print(v)
    }
}

// エントリーポイント
main()
