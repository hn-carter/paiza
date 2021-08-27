/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「幅のある移動」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_mapmove_step5

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 移動経路
struct Path {
    // 移動方向 L, R
    var D: String
    // 移動量
    var L: Int
}

// マップ
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
    // 渡された方向(L, R)に指定量移動する
    mutating func Move(dir: String, len: Int) -> Bool {
        var tx = self.X
        var ty = self.Y
        var td = self.D
        var step = 1
        if dir == "L" {
            step = -1
        }
        var stopped = false // 移動できない
        for _ in 0..<len {
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
            // 移動可能チェック
            if ty < 0 || self.H <= ty || tx < 0 || self.W <= tx || self.S[ty][tx] == "#" {
                // 移動不可
                stopped = true
                break
            } else {
                // 移動可能
                self.S[ty][tx] = "*"
                self.X = tx
                self.Y = ty
            }
        }
        td = (4 + td + step) % 4
        self.D = td
        return !stopped
    }
}

// メイン関数
func main() {
    //  1 行目にはマップの行数を表す整数 H , マップの列数を表す整数 W , 
    // 現在の y, x 座標を表す sy sx , 移動する回数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let sy = Int(items[2])!
    let sx = Int(items[3])!
    let n = Int(items[4])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、マップの i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、マップの i 行目の j 列目に書か
    // れている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, Y: sy, X: sx, D: 0, S: s) 
    // 続く N 行のうち i 行目 (1 ≦ i ≦ N) には、i 回目の移動の向き d_i と移動
    // するマス数 l_i が与えられます。
    var paths: [Path] = []
    for _ in 0..<n {
        let itemsP = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let d = String(itemsP[0])
        let l = Int(itemsP[1])!
        paths.append(Path(D: d, L: l))
    }
    // スタート位置
    current.S[sy][sx] = "*"
    // 移動
    for m in paths {
        let ok = current.Move(dir: m.D, len: m.L)
        if !ok {
            // 行き止まり
            break
        }
    }
    // 結果出力
    for y in 0..<h {
        for x in 0..<w {
            print(current.S[y][x], terminator: "")
        }
        print("")
    }
}

// エントリーポイント
main()