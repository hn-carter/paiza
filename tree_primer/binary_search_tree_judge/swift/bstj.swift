/*
これはpaizaラーニングの「木のメニュー」-「二分探索木の判定」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__binary_search_tree_judge

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 
    // 根付き木の根の頂点の値 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    //let r = Int(items[1])!
    // 続く N-1 行のうち、i 行目では、辺の親の値 a_i と子の値 b_i と、
    // 子が左右どちらにあるかを表す LR_i が与えられます。(1 ≦ i ≦ N-1)
    var is_binary_tree: Bool = true
    for _ in 0..<n-1 {
        let itemsN = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsN[0])!
        let b = Int(itemsN[1])!
        if itemsN[2] == "L" {
            if a < b {
                is_binary_tree = false
            }
        } else {
            if a > b {
                is_binary_tree = false
            }
        }
    }
    // 答えを出力します
    if is_binary_tree {
        print("YES")
    } else {
        print("NO")
    }
}

// エントリポイント
main()
