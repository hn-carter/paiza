/*
これはpaizaラーニングの「木のメニュー」-「完全二分木の管理」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__binary_tree_array

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// メイン関数
func main() {
    // 1 行目には、根付き木の頂点の数 N, 与えられる頂点の数 K,
    // 完全二分木の根の頂点の番号 R が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    let r = Int(items[2])!
    // 続く N-1 行のうち、i 行目では、根から近い方の辺から順に、
    // 辺がつなぐ 2 頂点の親の番号 a_i と子の番号 b_i と、子が左右どちらの
    // 子であるかを表す文字 LR_i が与えられます。(1 ≦ i ≦ N-1)
    var number_to_index:[Int:Int] = [:]                     // 頂点番号から位置を取得
    var index_to_number = [Int](repeating: -1, count: n * 2)    // 位置から頂点番号を取得
    // 根の頂点番号を代入
    number_to_index[r] = 0
    index_to_number[0] = r
    for _ in 0..<n-1 {
        let itemsN = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let a = Int(itemsN[0])!
        let b = Int(itemsN[1])!
        // 根から近い方の頂点aから与えられていくので、bの情報を代入
        if itemsN[2] == "L" {
            number_to_index[b] = 2 * number_to_index[a]! + 1
        } else if itemsN[2] == "R" {
            number_to_index[b] = 2 * number_to_index[a]! + 2
        }
        index_to_number[number_to_index[b]!] = b
    }
    // 続く K 行では、子の頂点を求めたい頂点の番号 v_i と調べたい子の
    // 左右 lr_i が与えられます。(1 ≦ i ≦ K)
    var answer = [Int](repeating: -1, count: k)
    for i in 0..<k {
        let itemsK = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let v = Int(itemsK[0])!
        if itemsK[1] == "L" {
            answer[i] = index_to_number[2 * number_to_index[v]! + 1]
        } else if itemsK[1] == "R" {
            answer[i] = index_to_number[2 * number_to_index[v]! + 2]
        }
    }
    // 答えを出力します
    for a in answer {
        if a != -1 {
            print(a)
        } else {
            print()
        }
    }
}

// エントリポイント
main()
