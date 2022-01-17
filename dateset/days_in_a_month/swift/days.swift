/*
これはpaizaラーニングの「日付セット」から「月の日数」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dateset/days_in_a_month

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct YearMonth {
    // 年
    var year: Int
    // 月
    var month: Int
    // teur:閏年
    var isLeap: Bool
    // 月の日数
    var daysInAMonth: Int

    static let days: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        let is_leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        self.isLeap = is_leap
        if month == 2 && is_leap {
            self.daysInAMonth = 29
        } else {
            self.daysInAMonth = YearMonth.days[month-1]
        }
    }
}

// メイン関数
func main() {
    // 1行目に、年 y と月 m が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let m = Int(items[1])!
    // 年月情報
    let ym = YearMonth(year: y, month: m)
    // 結果出力
    print(ym.daysInAMonth)
}

// エントリーポイント
main()
