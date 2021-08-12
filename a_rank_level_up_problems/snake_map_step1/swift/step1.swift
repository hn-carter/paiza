/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の
「盤面の情報取得」にswiftでチャレンジした試行錯誤コードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_map_step1
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
}

// メイン関数
func main() {
    // 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W , 
    // 与えられる座標の数を表す整数 N が与えられます。 
    let items = readLine()!.split(separator: " ")
    let h = Int(items[0])!
    // let w = Int(items[1])!  // 使わないのでコメントアウト
    let n = Int(items[2])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、S_i の j 文字目は、盤面の i 行目の j 列目に書かれ
    // ている文字を表します。
    var s: [String] = []
    for _ in 1...h {
        s.append(readLine()!)
    }
    // 続く N 行 には、文字を答えるための y_i , x_i 座標が与えられます。(1 ≦ i ≦ N)
    var pos: [Position] = []
    for _ in 1...n {
        let itemsP = readLine()!.split(separator: " ")
        let y = Int(itemsP[0])!
        let x = Int(itemsP[1])!
        pos.append(Position(Y: y, X: x))
    }

    // 処理を行う
    for p in pos {
        // 行から指定された文字位置を求める
        let index = s[p.Y].index(s[p.Y].startIndex, offsetBy: p.X)
        // 指定位置の文字を出力する
        print(s[p.Y][index])
    }
}

// エントリーポイント
main()