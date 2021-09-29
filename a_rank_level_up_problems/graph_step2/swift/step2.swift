/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「隣接リスト」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_graph_step2
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 配列に昇順になるように挿入する
// 前提　1.配列初期値は最大値　2.配列があふれることはない
func insertTo(arr: inout [Int], val: Int) {
    let size = arr.count
    for i in (0..<size).reversed() {
        if val > arr[i] {
            // 小さい値だったので一つ後ろに挿入
            arr[i+1] = val
            break
        } else {
            if arr[i] != Int.max {
                // 一つ後ろに移動
                arr[i+1] = arr[i]
            }
            if i == 0 {
                // 先頭に挿入
                arr[i] = val
            }
        }
    }
}

// メイン関数
func main() {
    //  1 行目には、頂点の数 N と、辺の数 M が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く M 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ M)
    var graph: [[Int]] = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
    for _ in 0..<m {
        let itemsI = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsI[0])! - 1
        let b = Int(itemsI[1])! - 1
        insertTo(arr: &graph[a], val: b)
        insertTo(arr: &graph[b], val: a)
    }
    // 結果出力
    for i in 0..<n {
        for j in 0..<n {
            if graph[i][j] == Int.max {
                break
            }
            print(graph[i][j], terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()