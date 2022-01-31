/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の入力・辺の個数」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_step3

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n が与えられます。
    let n = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
    // 続く n 行では、隣接行列の上から i 行目の n 個の整数が左から順に半角スペース区切りで与えられます。(1 ≦ i ≦ n)
    var adjacencyMatrix: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for y in 0..<n {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        for x in 0..<n {
            let a = Int(itemsG[x])!
            adjacencyMatrix[y][x] = a
        }
    }
    // 辺の数を求める
    // 無向グラフの隣接行列なら頂点をつなげている数を数えて半分にする
    var count: Int = 0
    for y in 0..<n {
        for x in 0..<n {
            if adjacencyMatrix[y][x] == 1 {
                count += 1
            }
        }
    }
    let answer = count / 2
    // 答えを出力する
    print(answer)
}

// エントリーポイント
main()
