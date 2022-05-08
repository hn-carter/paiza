/*
これはpaizaラーニングの「木のメニュー」-「子の頂点」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__rooted_tree_child

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Node {
    var parent: Int
    var children: [Int]
    // 子を出力
    func printChildren() {
        var isFirst = true
        children.forEach {
            if !isFirst {
                print(" " ,terminator: "")
            } else {
                isFirst = false
            }
            print($0 ,terminator: "")
        }
        print("")
    }
}

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 与えられる頂点の数 K, 根付き木の根の頂点番号 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    //let r = Int(items[2])!
    // 続く N-1 行では、根付き木の各辺の両端の頂点 a_i , b_i が与えられます。
    // ただし、a_i が b_i の親になります。(1 ≦ i ≦ N-1)
    var tree: [Node] = [Node](repeating: Node(parent: 0, children: []), count: n)
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let p = Int(itemsG[0])!
        let c = Int(itemsG[1])!
        tree[p-1].children.append(c)
        tree[c-1].parent = p
    }
    for i in 0..<n {
        tree[i].children.sort { $0 < $1 }
    }
    // 続く K 行では、子の頂点を求めたい頂点の番号 v_i が与えられます。(1 ≦ i ≦ K)
    var kList: [Int] = [Int](repeating: 0, count: k)
    for i in 0..<k {
        kList[i] = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    // 子を出力
    kList.forEach {
        tree[$0-1].printChildren()
    }
}

// エントリーポイント
main()