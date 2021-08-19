/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「マップからの座標取得」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_move_step1

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
}

// メイン関数
func main() {
    // 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、盤面の i 行目の j 列目に書か
    // れている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 1...h {
        let larray = Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
        s.append(larray)
    }
    // #となるマスを求める
    var answer: Position = Position(Y: 0, X: 0)
    for_find: for y in 0..<h {
        for x in 0..<w {
            if s[y][x] == "#" {
                // 見つけたので座標をセットしてループ脱出
                answer.Y = y
                answer.X = x
                break for_find
            }
        }
    }
    // 結果出力
    print("\(answer.Y) \(answer.X)")
}

// エントリーポイント
main()