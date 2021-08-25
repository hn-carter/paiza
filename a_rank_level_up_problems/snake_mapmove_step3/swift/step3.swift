/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「移動が可能かの判定・複数回の移動」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_mapmove_step3

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
    // 現在向いている方角 0:N, 1:S, 2:E, 3:W
    var D: Int
    // マップ
    var S: [[Character]]
    // 渡された方向(L, R)に移動する
    mutating func Move(dir: String) -> Bool {
        var tx = self.X
        var ty = self.Y
        var td = self.D
        var step = 1
        if dir == "L" {
            step = -1
        }
        switch self.D {
        case 0: //"N"
            tx += step
        case 1: //"E"
            ty += step
        case 2: //"S"
            tx -= step
        case 3: //"W"
            ty -= step
        default:
            break
        }
        td = (4 + td + step) % 4
        // 範囲外チェック
        if 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
            // 障害物チェック
            if self.S[ty][tx] != "#" {
                self.X = tx
                self.Y = ty
                self.D = td
                return true
            }
        }
        return false
    }
}

// メイン関数
func main() {
    // 1 行目にはマップの行数を表す整数 H , マップの列数を表す整数 W , 
    // 現在の y, x 座標を表す sy sx , 移動する回数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let sy = Int(items[2])!
    let sx = Int(items[3])!
    let n = Int(items[4])!
    //  続く H 行のうち i 行目 (0 ≦ i < H) には、マップの i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、マップの i 行目の j 列目に書かれ
    // ている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, Y: sy, X: sx, D: 0, S: s) 
    // 続く N 行のうち i 行目 (1 ≦ i ≦ N) には、i 回目の移動の向き d_i が与えられます。
    var d: [String] = []
    for _ in 0..<n {
        d.append(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    // 移動
    for m in d {
        let ok = current.Move(dir: m)
        if ok {
            // 移動先位置を出力
            print("\(current.Y) \(current.X)")
        } else {
            // 行き止まり
            print("Stop")
            break
        }
    }
}

// エントリーポイント
main()