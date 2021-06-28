// これはpaizaラーニングの「クエリメニュー」から「連想配列(query)」
// https://paiza.jp/works/mondai/query_primer/query_primer__map_normal
// にswiftでチャレンジした試行錯誤コードです。
import Foundation

struct Data {
    // 生徒の人数
    var n: Int
    // イベントの回数
    var k: Int
    // クラスに在籍する生徒 生徒番号、識別ID
    var students: Dictionary<Int, String>
    // イベント
    var event: [String]
    // イニシャライザ
    // i people : 人数
    //   times  : 回数
    init(people: Int, times: Int) {
        // イニシャライザでは全てのプロパティを初期化しないといけない
        self.n = people
        self.k = times
        self.students = [:]
        self.event = []
    }
}

// inputData は入力データを取り込む
func inputData() -> Data {
    // 1 行目では、初めに覚える生徒の人数 N と与えられるイベントの回数 K が与えられます。
    let items = readLine()!.split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    var result = Data(people: n, times: k)
    // 続く N 行のうち i 行目 (1 ≦ i ≦ N) では、i 番目の生徒の出席番号と
    // 識別 ID の組 num_i , ID_i が半角スペース区切りで与えられます。
    for _ in 1...n {
        let sitems = readLine()!.split(separator: " ")
        let num: Int = Int(sitems[0])!
        // 生徒Dictionaryに追加or更新
        result.students.updateValue(String(sitems[1]), forKey: num)
    }
    // 続く K 行では、起きるイベントを表す文字列 S_i (1 ≦ i ≦ K) が与えられます。
    for _ in 1...k {
        let line: String = readLine()!
        // イベント配列の最後に追加
        result.event.append(line)
    }
    return result
}

// computeData は処理を実行する
func computeData(data: Data) {
    // 引数は定数のため同名の変数を作る
    var data = data
    // 0〜イベントの回数未満ループ
    for i in 0..<data.k {
        let event = data.event[i].split(separator: " ")
        switch event[0] {
            case "join":    // 生徒番号 num , 識別 ID id の生徒を新たに覚える。
                let num: Int = Int(event[1])!
                data.students.updateValue(String(event[2]), forKey: num)
            case "leave":   // 生徒番号 num の生徒を忘れる。
                let num: Int = Int(event[1])!
                data.students.removeValue(forKey: num)
            case "call":    // 生徒番号 num の生徒の識別 ID を出力する。
                let num: Int = Int(event[1])!
                if let id = data.students[num] {
                    // idが見つかった場合
                    print(id)
                } else {
                    // 生徒が見つからなかった
                }
            default:
                // 何もしない
                break
        }
    }
}

// メイン関数
func main() {
    // 入力データ取り込み
    let d: Data = inputData()
    // 処理実行
    computeData(data: d)
}

// エントリーポイント
main()
