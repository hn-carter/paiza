/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「盤面の情報変更」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_map_step2

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

// 文字列の指定位置の文字を変更する
func replaceAt(str: String, index: Int, newChar: Character) -> String {
    // 文字の配列に変換する Array<Character>
    var charArray = Array(str)
    // 文字を置き換える
    charArray[index] = newChar
    // 文字列に変換する
    let replacedString = String(charArray)
    return replacedString
}

// メイン関数
func main() {
    // 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W , 
    // 与えられる座標の数を表す整数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    //let w = Int(items[1])!  // 使わないのでコメントアウト
    let n = Int(items[2])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、盤面の i 行目の j 列目に
    // 書かれている文字を表します。(0 ≦ j < W)
    var s: [String] = []
    for _ in 1...h {
        s.append(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // 続く N 行 には、 文字を書き換えるマスの y , x 座標が与えられます。(1 ≦ i ≦ N)
    var pos: [Position] = []
    for _ in 1...n {
        let itemsP = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let y = Int(itemsP[0])!
        let x = Int(itemsP[1])!
        pos.append(Position(Y: y, X: x))
    }

    // 処理を行う
    for p in pos {
        // 指定位置の文字を"#"に更新する
        s[p.Y] = replaceAt(str: s[p.Y], index: p.X, newChar: "#")
    }
    // 結果出力
    for line in s {
        print(line)
    }
}

// エントリーポイント
main()