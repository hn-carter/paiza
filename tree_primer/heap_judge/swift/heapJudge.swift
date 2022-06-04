/*
これはpaizaラーニングの「木のメニュー」-「ヒープの判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__heap_judge

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 根付き木の根の頂点番号 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let r = Int(items[1])!
    // 続く N-1 行では、根付き木の各辺の両端の頂点の値 a_i , b_i が与えられます。
    // ただし、a_i を値として持つ頂点が b_i を値として持つ頂点の親であることが
    // 保証されています。(1 ≦ i ≦ N-1)
    var result: String = "YES"
    var maxValue: Int = 0
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let p = Int(itemsG[0])!
        let c = Int(itemsG[1])!
        // 根に近い方が大きい
        if p < c {
            result = "NO"
        } else {
            if maxValue < p {
                maxValue = p
            }
        }
    }
    if maxValue != r {
        result = "NO"
    }

    // 結果出力
    print(result)
}

// エントリーポイント
main()