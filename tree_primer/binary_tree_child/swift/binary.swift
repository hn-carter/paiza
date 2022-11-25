/*
これはpaizaラーニングの「木のメニュー」-「子の頂点」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__binary_tree_child

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Vertex {
    var left: Int = -1
    var right: Int = -1
}

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 与えられる頂点の数 K,
    // 二分木の根の頂点番号 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    //let r = Int(items[2])!
    // 続く N-1 行では、根付き木の各辺の両端の頂点 a_i , b_i と
    // 左右の関係 LR_i が与えられます。ただし、LR_i が L のとき、
    // b_i が a_i の左の子であることを、R のとき、b_i が a_i の
    // 右の子であることを表しています。(1 ≦ i ≦ N-1)
    var vertices: [Vertex] = [Vertex](repeating: Vertex(), count: n+1)
    for _ in 1..<n {
        let itemsLR = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsLR[0])!
        let b = Int(itemsLR[1])!
        if itemsLR[2] == "L" {
            vertices[a].left = b
        } else if itemsLR[2] == "R" {
            vertices[a].right = b
        }
    }
    // 続く K 行では、子の頂点を求めたい頂点の番号 v_i と調べたい子の
    // 左右 lr_i が与えられます。(1 ≦ i ≦ K)
    var answer: [Int] = [Int](repeating: -1, count: k)
    for i in 0..<k {
        let itemsK = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let v = Int(itemsK[0])!
        // 求めた番号を配列に出力
        if itemsK[1] == "L" {
            answer[i] = vertices[v].left
        } else if itemsK[1] == "R" {
            answer[i] = vertices[v].right
        }
    }
    // 答えを出力
    for a in answer {
        if a != -1 {
            print(a)
        } else {
            print()
        }
    }
}

// エントリポイント
main()
