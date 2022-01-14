/*
これはpaizaラーニングの問題集にある「日付セット」-「西暦の和暦変換2」
https://paiza.jp/works/mondai/dateset/ad_to_era2
にSwiftでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE)
*/

import Foundation

struct era {
    var year: Int
    var month: Int
    var day: Int
    var eraString: String
    // 年月日の比較用
    var ymd: Int {
        get { return self.year * 10000 + self.month * 100 + self.day }
    }
}

struct wareki {
    var ad_year: Int = 0
    var eraStr: String = ""
    var era_year: Int = 0
    var month: Int = 0
    var day: Int = 0
    // 年号が切り替わる日
    static let revision: [era] = [era(year: 2019, month: 5, day: 1, eraString: "令和"),
                        era(year: 1989, month: 1, day: 8, eraString: "平成"),
                        era(year: 1926, month: 12, day: 25, eraString: "昭和"),
                        era(year: 1912, month: 7, day: 30, eraString: "大正"),
                        era(year: 1868, month: 1, day: 25, eraString: "明治")]

    init(adYear: Int, month: Int, day: Int) {
        self.ad_year = adYear
        let ymd = adYear * 10000 + month * 100 + day
        for e in wareki.revision {
            if ymd >= e.ymd {
                self.eraStr = e.eraString
                self.era_year = adYear - e.year + 1
                break
            }
        }
        self.month = month
        self.day = day
    }

    // 日付文字列を返す　Gx年m月d日
    func toString() -> String {
        var yearString: String = ""
        if era_year == 1 {
            yearString = "元"
        } else {
            yearString = String(era_year)
        }
        return "\(eraStr)\(yearString)年\(month)月\(day)日"
    }   
}

// メイン関数
func main() {

    // 1行で、西暦年y、月m、日付dが与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let m = Int(items[1])!
    let d = Int(items[2])!
    // 和暦判定
    let wa = wareki(adYear: y, month: m, day: d)
    // 結果出力
    print(wa.toString())
}

// エントリーポイント
main()
