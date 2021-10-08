/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「重みあり有向グラフの隣接行列と隣接リスト」にswiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_step4
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Digraph {
    var b: Int
    var k: Int
}

// メイン関数
func main() {
    //  1 行目には、頂点の数 N と、辺の数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く M 行では、各辺の両端の頂点 a_i , b_i と、その辺の重み k_i が与えられます。(1 ≦ i ≦ M)
    // 隣接行列
    var adjacency_matrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    // 隣接リスト
    var adjacency_list: [[Digraph]] = [[Digraph]](repeating: [Digraph](), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])! - 1
        let b = Int(itemsI[1])! - 1
        let k = Int(itemsI[2])!
        adjacency_matrix[a][b] = k
        adjacency_list[a].append(Digraph(b: b, k:k))
    }
    // 結果出力
    // 隣接行列
    for i in 0..<n {
        for j in 0..<n {
            print(adjacency_matrix[i][j], terminator: "")
        }
        print("")
    }
    // 隣接リスト
    for i in 0..<n {
        // 隣接リストのソート
        adjacency_list[i].sort(by: {$0.b < $1.b})
        for v in adjacency_list[i] {
            print("\(v.b)(\(v.k))", terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()