/*
これはpaizaラーニングの「木のメニュー」-「頂点の高さ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__vertex_height

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// キュー
struct Queue {
    private var list: [Int] = []
    // キューが空
    var isEmpty: Bool {
        return list.isEmpty
    }
    // キューに追加
    mutating func push(_ item: Int) {
        list.append(item)
    }
    // キューから取り出す
    mutating func pop() -> Int? {
        guard !list.isEmpty, let item = list.first else {
            return nil
        }
        list.removeFirst()
        return item
    }
}

// 辺
struct Edge {
    var a: Int
    var b: Int
}

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 根付き木の根の頂点番号 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let r = Int(items[1])!
    // 続く N-1 行では、根付き木の各辺の両端の頂点の番号 a_i , b_i が与えられます。
    // (1 ≦ i ≦ N-1)
    var verticies: [Int:[Int]] = [:]
    var tree: [Edge] = []
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        tree.append(Edge(a: a, b: b))
        // 頂点に紐つく頂点をそれぞれ追加
        if verticies[a] != nil {
            verticies[a]!.append(b)
        } else {
            verticies[a] = [b]
        }
        if verticies[b] != nil {
            verticies[b]!.append(a)
        } else {
            verticies[b] = [a]
        }
    }

    // 頂点毎の深さを求める
    var queue = Queue()
    var depth = [Int](repeating: -1, count: n+1)

    queue.push(r)
    depth[r] = 0

    while (!queue.isEmpty) {
        let pos = queue.pop()!
        if let list = verticies[pos] {
            for v in list {
                if depth[v] == -1 {
                    depth[v] = depth[pos] + 1
                    queue.push(v)
                }
            }
        }
    }

    // 結果出力
    for edge in tree {
        if depth[edge.a] < depth[edge.b] {
            print("A")
        } else {
            print("B")
        }
    }
}

// エントリーポイント
main()