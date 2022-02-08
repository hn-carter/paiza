/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「自己ループ・無向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_step1

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
    // 自己ループの判定
    var loops: [Int] = [Int]()
    for i in 0..<n {
        if adjacencyMatrix[i][i] == 1 {
            loops.append(i+1)
        }
    }
    // 結果出力
    print(loops.count)
    for v in loops {
        print(v)
    }
}

// エントリーポイント
main()