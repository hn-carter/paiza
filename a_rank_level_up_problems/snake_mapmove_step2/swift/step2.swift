/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「移動が可能かの判定・方向」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_mapmove_step2

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // 現在位置
    var Y: Int
    var X: Int
    // 現在向いている方角 N, S, E, W
    var D: String
    // マップ
    var S: [[Character]]
    // 渡された方向(L, R)に移動する
    mutating func Move(dir: String) -> Bool {
        var tx = self.X
        var ty = self.Y
        var step = 1
        if dir == "L" {
            step = -1
        }
        switch self.D {
        case "N":
            tx += step
        case "E":
            ty += step
        case "S":
            tx -= step
        case "W":
            ty -= step
        default:
            break
        }
        // 範囲外チェック
        if 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
            // 障害物チェック
            if self.S[ty][tx] != "#" {
                self.X = tx
                self.Y = ty
                return true
            }
        }
        return false
    }
}

// メイン関数
func main() {
    //  1 行目にはマップの行数を表す整数 H , マップの列数を表す整数 W , 
    // 現在の y, x 座標を表す sy sx , 現在向いている方角 d , 1 マス移動する方向 m が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let sy = Int(items[2])!
    let sx = Int(items[3])!
    let d = String(items[4])
    let m = String(items[5])
    //  続く H 行のうち i 行目 (0 ≦ i < H) には、マップの i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、マップの i 行目の j 列目に書かれ
    // ている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, Y: sy, X: sx, D: d, S: s) 
    // 移動
    let ok = current.Move(dir: m)
    // 結果出力
    if ok {
        print("Yes")
    } else {
        print("No")
    }
}

// エントリーポイント
main()