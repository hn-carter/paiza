/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「連結の判定」にswiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_boss
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    //  1 行目には頂点の数を表す整数 N , 辺の数を表す整数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く M 行では、辺の両端の頂点 a_i , b_i が与えられます。 (1 ≦ i ≦ M)
    // 隣接行列
    var adjacency_matrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])! - 1
        let b = Int(itemsI[1])! - 1
        adjacency_matrix[a][b] = 1
        adjacency_matrix[b][a] = 1
    }
    // 1 からスタート
    var travel = [Int]()
    travel.append(0)
    while travel.count > 0 {
        let current = travel.popLast()!
        for i in 0..<n {
            if current != i && adjacency_matrix[current][i] == 1 {
                // i と現在位置 current は連結しているので i と連結している点も含める
                for j in 0..<n {
                    if adjacency_matrix[i][j] == 1 && adjacency_matrix[current][j] == 0 {
                        adjacency_matrix[current][j] = 1
                        adjacency_matrix[j][current] = 1
                        travel.append(j)
                    }
                }
            }
        }
    }
    // 連結していない点を判定
    var answer = "Yes"
    for_i: for i in 0..<n {
        for j in 0..<n {
            if i != j && adjacency_matrix[i][j] == 0 {
                answer = "No"
                break for_i
            }
        }
    }
    // 結果出力
    print(answer)
}

// エントリーポイント
main()