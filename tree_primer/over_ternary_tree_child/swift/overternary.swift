/*
これはpaizaラーニングの「木のメニュー」-「子の頂点2」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__ovar_ternary_tree_child

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Vertex {
    var children: [Int] = []

    // 子を追加します
    mutating func addChild(_ c: Int) {
        children.append(c)
    }
    // 左からn番目の子を返します
    func getChild(_ n: Int) -> Int {
        if 0 < n && children.count >= n {
            return children[n-1]
        } else {
            return -1
        }
    }
}

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 与えられる頂点の数 K,
    // 多分木の根の頂点番号 Rが与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    //let r = Int(items[2])!

    // 続く N-1 行では、根付き木の各辺の両端の頂点 a_i , b_i が与えられます。
    // ただし、a_i は b_i の親であることが保証されています。(1 ≦ i ≦ N-1)
    var vertices = [Vertex](repeating: Vertex(), count: n+1)
    for _ in 1..<n {
        let itemsN = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsN[0])!
        let b = Int(itemsN[1])!
        vertices[a].addChild(b)
    }

    // 続く K 行では、子の頂点を求めたい頂点の番号 v_i と調べたい子の左からの
    // 順番 l_i が与えられます。(1 ≦ i ≦ K)
    var answer: [Int] = [Int](repeating: -1, count: k)
    for i in 0..<k {
        let itemsK = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let v = Int(itemsK[0])!
        let l = Int(itemsK[1])!
        answer[i] = vertices[v].getChild(l)
    }

    // 答えを出力します
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
