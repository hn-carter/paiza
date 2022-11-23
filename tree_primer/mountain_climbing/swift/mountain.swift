/*
これはpaizaラーニングの「木のメニュー」-「山登り」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__mountain_climbing

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
/*
// 辺
struct Edge {
    var a: Int
    var b: Int
}*/

// 頂点
struct Vertex {
    var parent: Int = -1
    var children: [Int] = []
    // 根からの深さ
    var depth: Int = -1
}

// 根からの深さを求める
// n : 葉の数
// root : 根
// edges : 葉に接続する葉
func calc_depth(n: Int , root: Int, edges: [Int:[Int]]) -> [Vertex] {
    // チェックポイント毎の根からの距離
    var depthFromRoot: [Vertex] = [Vertex](repeating: Vertex(), count: n+1)
    // 行き先を入れるキュー
    var q: Queue = Queue()
    // キューに根を入れて行き止まりまでたどっていく
    q.push(root)
    depthFromRoot[root].depth = 0
    depthFromRoot[root].parent = -1
    depthFromRoot[root].children = edges[root]!
    // キューが空になるということは行けるところは全て行った
    while (!q.isEmpty) {
        if let pos = q.pop() {
            for v in depthFromRoot[pos].children {
                if depthFromRoot[v].depth == -1 {
                    depthFromRoot[v].depth = depthFromRoot[pos].depth + 1
                    depthFromRoot[v].parent = pos
                    depthFromRoot[v].children = edges[v]!
                    q.push(v)
                }
            }
        }
    }
    return depthFromRoot
}

// メイン関数
func main() {
    // 1 行目には、山のチェックポイントの数 N,
    // 山の頂点に割り当てられたチェックポイントの番号 T,
    // paiza 君が出発したチェックポイントの番号 S,
    // paiza 君が山を登った回数 C, 降りた回数 D が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let t = Int(items[1])!
    let s = Int(items[2])!
    let c = Int(items[3])!
    let d = Int(items[4])!
    // 続く N-1 行では、山の N-1 本の道の両端のチェックポイントの番号が与えられます。
    var adjacent: [Int:[Int]] = [:]
    //var tree: [Edge] = []
    for _ in 1..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        //tree.append(Edge(a: a, b: b))
        // 頂点に紐つく頂点をそれぞれ追加
        if adjacent[a] != nil {
            adjacent[a]!.append(b)
        } else {
            adjacent[a] = [b]
        }
        if adjacent[b] != nil {
            adjacent[b]!.append(a)
        } else {
            adjacent[b] = [a]
        }
    }

    // 点ごとの深さを求める
    let vertices = calc_depth(n: n, root: t, edges: adjacent)

    // 山登り
    if vertices[s].depth <= c {
        // 出発地から頂きまでの距離が登る回数よりも少ない場合、
        // 頂からどこへでも行ける
        // （答えは頂からの距離のみで判断できる）
        for i in 0..<n {
            if vertices[i].depth == vertices[s].depth - c + d {
                print(i)
            }
        }
    } else {
        // 最大数分(c)登っても頂きまで到達できないということは、
        // 現在地から最も高く登れる場所から行ける範囲になる
        // まずは最も高く登れる場所を求める highest
        var highest = s
        for _ in 0..<c {
            highest = vertices[highest].parent
        }
        // 次に到達できる距離となる場所毎に、登ったときに[highest]に到達できるか
        // 判定する
        for i in 0..<n {
            if vertices[i].depth == vertices[s].depth - c + d {
                var pos = i
                for _ in 0..<d {
                    pos = vertices[pos].parent
                }
                if pos == highest {
                    print(i)
                }
            }
        }
    }
}

// エントリーポイント
main()