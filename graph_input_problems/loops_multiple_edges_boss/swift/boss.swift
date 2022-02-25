/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「多重辺・有向グラフ (辺入力)」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct Graph {
    // 頂点a
    var a: Int
    // 頂点b
    var b: Int
}

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<m {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        adjacencyMatrix[a-1][b-1] += 1
    }
    // 多重辺の判定
    var multipleEdges: [Graph] = [Graph]()
    for y in 0..<n {
        for x in (y+1)..<n {
            if (adjacencyMatrix[y][x] + adjacencyMatrix[x][y]) > 1 {
                multipleEdges.append(Graph(a: y+1, b: x+1))
            }
        }
    }
    // 結果出力
    print(multipleEdges.count)
    for g in multipleEdges {
        print("\(g.a) \(g.b)")
    }
}

// エントリーポイント
main()