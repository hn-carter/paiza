/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「準オイラーグラフ・無向グラフ」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step4

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let m = Int(items[1])!
    // 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
    var count: [Int] = [Int](repeating: 0, count: n)
    for _ in 0..<m {
        let itemsG = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsG[0])!
        let b = Int(itemsG[1])!
        // 頂点につながる辺をカウント
        count[a-1] += 1
        count[b-1] += 1
    }
    // すべての辺を一筆書きすることができるかどうか判定
    var odd = 0
    for v in count {
        if v % 2 == 1 {
            odd += 1
        }
    }
    // 結果出力
    if odd == 0 || odd == 2 {
        // 一筆書きできる
        print("1")
    } else {
        print("0")
    }
}

// エントリーポイント
main()