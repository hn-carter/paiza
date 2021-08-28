/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「へび」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_mapmove_boss

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 移動経路
struct Path {
    // 移動時刻
    var T: Int
    // 移動方向 L, R
    var D: String
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // 現在位置
    var Y: Int
    var X: Int
    // 現在向いている方角 0:N, 1:E, 2:S, 3:W
    var D: Int
    // マップ
    var S: [[Character]]
    // 方向転換する
    mutating func Turn(dir: String) {
        var td = 1
        if dir == "L" {
            // 左
            td = 3
        }
        self.D = (self.D + td) % 4
    }

    // 移動する
    mutating func Move(len: Int) -> Bool {
        var tx = self.X
        var ty = self.Y
        var goFlag = true
        // 進む
        switch self.D {
        case 0: //"N"
            ty -= len
        case 1: //"E"
            tx += len
        case 2: //"S"
            ty += len
        case 3: //"W"
            tx -= len
        default:
            break
        }
        // 移動可能チェック
        if ty < 0 || self.H <= ty || tx < 0 || self.W <= tx || self.S[ty][tx] == "#" || self.S[ty][tx] == "*" {
            // 移動不可
            goFlag = false
        } else {
            // 移動可能
            self.S[ty][tx] = "*"
            self.X = tx
            self.Y = ty
        }
        return goFlag
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
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、マップの i 行目の文字をまとめた
    // 文字列 S_i が与えられ、 S_i の j 文字目は、マップの i 行目の j 列目に書か
    // れている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    var current = World(H: h, W: w, Y: sy, X: sx, D: 0, S: s) 
    // 続く N 行のうち i 行目 (1 ≦ i ≦ N) には、i 回目の方向転換をおこなう時刻 t_i と
    // 方向転換の向き d_i が与えられます。
    // d_i は、L, R のいずれかであり、それぞれ 左・右 を意味します。
    var paths: [Path] = []
    for _ in 0..<n {
        let itemsP = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let t = Int(itemsP[0])!
        let d = String(itemsP[1])
        paths.append(Path(T: t, D: d))
    }
    // スタート位置
    current.S[sy][sx] = "*"
    // 移動
    // 移動情報の添字
    var pIdx = 0
    for i in 0...99 {
        if pIdx < paths.count && i == paths[pIdx].T {
            // 方向転換
            current.Turn(dir: paths[pIdx].D)
            pIdx += 1
        }
        // 1マス移動
        if !current.Move(len: 1) {
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