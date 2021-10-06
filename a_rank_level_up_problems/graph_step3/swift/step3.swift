/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「有向グラフの隣接行列と隣接リスト」にswiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_step3
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    //  1 行目には、頂点の数 N と、辺の数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く M 行では、各辺の始点 a_i と、終点 b_i が与えられます。(1 ≦ i ≦ M)
    // 隣接行列
    var adjacency_matrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    // 隣接リスト
    var adjacency_list: [[Int]] = [[Int]](repeating: [Int](), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])! - 1
        let b = Int(itemsI[1])! - 1
        adjacency_matrix[a][b] = 1
        adjacency_list[a].append(b)
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
        adjacency_list[i].sort()
        for v in adjacency_list[i] {
            print(v, terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()