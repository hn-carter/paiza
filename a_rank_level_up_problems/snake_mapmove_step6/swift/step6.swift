/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「時刻に伴う移動」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_snake_mapmove_step6

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
    // 現在向いている方角 0:N, 1:S, 2:E, 3:W
    var D: Int
    // マップ
    var S: [[Character]]
    // 移動する
    mutating func Move(paths: [Path]) {
        var tx = self.X
        var ty = self.Y
        var td = self.D
        var step = -1 // 移動量 初期値北向き
        var pathIdx = 0
        for turn in 0...99 {
            if pathIdx < paths.count && turn == paths[pathIdx].T {
                // 方向転換する
                if paths[pathIdx].D == "L" {
                    step = -1
                } else {
                    step = 1
                }
                td = (4 + td + step) % 4
                pathIdx += 1
            }
            // 1 マス進む
            switch td {
            case 0: //"N"
                ty -= 1
            case 1: //"E"
                tx += 1
            case 2: //"S"
                ty += 1
            case 3: //"W"
                tx -= 1
            default:
                break
            }
            // 移動可能チェック
            if ty < 0 || self.H <= ty || tx < 0 || self.W <= tx || self.S[ty][tx] == "#" {
                // 移動不可
                print("Stop")
                break
            } else {
                // 移動可能
                print("\(ty) \(tx)")
            }
        }
        // 移動後の状態を保存
        self.D = td
        self.X = tx
        self.Y = ty
    }
}

// メイン関数
func main() {
    // 1 行目にはマップの行数を表す整数 H , マップの列数を表す整数 W , 
    // 現在の y, x 座標を表す sy sx , 方向転換する回数 N が与えられます。
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
    // 移動、結果出力
    current.Move(paths: paths)
}

// エントリーポイント
main()