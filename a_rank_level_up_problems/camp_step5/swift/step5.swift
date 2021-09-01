/*
これはpaizaラーニングの「Aランクレベルアップメニュー」の「陣取りのターン数」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/a_rank_level_up_problems/a_rank_camp_step5

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// 座標
struct Position {
    var Y: Int
    var X: Int
    // 回数
    var N: Int
    func Print() {
        print("Y=\(self.Y) X=\(self.X)")
    }
}

// キュー　ジェネリクス
struct Queue<T> {
    private var list: [T] = []
    // キューの中身が空
    var isEmpty: Bool {
        return list.isEmpty
    }
    // キューに追加する
    mutating func push(_ item: T) {
        list.append(item)
    }
    // キューから取り出す
    mutating func pop() -> T? {
        guard !list.isEmpty, let item = list.first else {
            return nil
        }
        list.removeFirst()
        return item
    }
}

// マップ
struct World {
    // マップの大きさ
    var H: Int
    var W: Int
    // マップ
    var S: [[Character]]
    // 陣取り
    mutating func Take(l: [Int: Bool]) {
        
        // 現在地取得
        var sx: Int = 0
        var sy: Int = 0
        for y in 0..<self.H {
            for x in 0..<self.W {
                if self.S[y][x] == "*" {
                    sy = y
                    sx = x
                }
            }
        }
        // Position構造体のキューを定義
        var queue = Queue<Position>()
        // キューにスタート位置を追加
        queue.push(Position(Y: sy, X: sx, N: 0))
        if l[0] != nil {
            self.S[sy][sx] = "?"
        }
        // 4方向に陣地拡張
        let able: [Position] = [Position(Y: -1, X: 0, N: 0), Position(Y: 0, X: 1, N: 0),
                                Position(Y: 1, X: 0, N: 0), Position(Y: 0, X: -1, N: 0)]
        while !queue.isEmpty {
            let pos = queue.pop()!
            for a in able {
                let ty = pos.Y + a.Y
                let tx = pos.X + a.X
                // マップの範囲内チェック
                if 0 <= ty && ty < self.H && 0 <= tx && tx < self.W {
                    // 陣取りチェック
                    if self.S[ty][tx] == "." {
                        let key = pos.N + 1
                        if l[key] != nil {
                            self.S[ty][tx] = "?"
                        } else {
                            self.S[ty][tx] = "*"
                        }
                        queue.push(Position(Y: ty, X: tx, N: key))
                    }
                }
            }
        }
    }
    // 出力
    func Print() {
        for y in 0..<self.H {
            for x in 0..<self.W {
                print(self.S[y][x], terminator: "")
            }
            print("")
        }
    }
}

// メイン関数
func main() {
    // 1 行目では、盤面の行数 H , 列数 W , l の入力の回数 N が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let h = Int(items[0])!
    let w = Int(items[1])!
    let n = Int(items[2])!
    // 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた
    // 文字列 S_i が与えられ、S_i の j 文字目は、盤面の i 行目の j 列目に書かれ
    // ている文字を表します。(0 ≦ j < W)
    var s: [[Character]] = []
    for _ in 0..<h {
        s.append(Array(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    // 続く N 行では、マスを '?' にするときの開始時の位置からの距離 l_i が与えられます。(1 ≦ i ≦ N)
    var l: [Int: Bool] = [:]
    for _ in 0..<n {
        let key = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines))!
        l[key] = true
    }
    var current = World(H: h, W: w, S: s)
    // 陣取り
    current.Take(l: l)
    // 結果出力
    current.Print()
}

// エントリーポイント
main()