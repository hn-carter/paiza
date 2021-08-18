/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「マップの判定・縦」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_map_step4

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
    let border = Array(String(repeating: "#", count: w))
    s.append(border)    // 端を#にすることでチェック時の判定が簡単になる
    for _ in 1...h {
        let sarray = Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
        s.append(sarray)
    }
    s.append(border)
    // 縦方向に左右が#となるマスを求める
    // 調査対象マス
    let direction: [Position] = [Position(Y: -1, X: 0), Position(Y: 1, X: 0)]
    var result: [Position] = []
    for y in 0..<h {
        for x in 0..<w {
            // 周辺チェック
            var find: Bool = true
            for p in direction {
                let tx: Int = x + p.X
                let ty: Int = y + p.Y + 1   // 周囲に#を付加した分座標を調整する
                if s[ty][tx] != "#" {
                    find = false
                    break
                }
            }
            // 周囲が#なので結果に追加する
            if find {
                result.append(Position(Y: y, X: x))
            }
        }
    }

    // 結果出力
    for pos in result {
        print("\(pos.Y) \(pos.X)")
    }
}

// エントリーポイント
main()