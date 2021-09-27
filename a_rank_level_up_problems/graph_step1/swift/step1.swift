/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「隣接行列」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_step1
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
    // 続く M 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ M)
    var graph: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])!
        let b = Int(itemsI[1])!
        graph[a-1][b-1] = 1
        graph[b-1][a-1] = 1
    }
    // 結果出力
    for i in 0..<n {
        for j in 0..<n {
            print(graph[i][j], terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()