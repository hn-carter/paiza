/*
これはpaizaラーニングの「日付セット」から「次の日」
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/dateset/tomorrow

作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

struct YearMonthDay {
    // 年
    var year: Int
    // 月
    var month: Int
    // 日
    var day: Int
    // teur:閏年
    var isLeap: Bool
    // 月の日数
    var daysInAMonth: Int

    static let days: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        let is_leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        self.isLeap = is_leap
        if month == 2 && is_leap {
            self.daysInAMonth = 29
        } else {
            self.daysInAMonth = YearMonthDay.days[month-1]
        }
    }
    // true: 月末
    func isEndOfMonth() -> Bool {
        return day == daysInAMonth
    }
    // 翌日を返す
    func getTomorrow() -> YearMonthDay {
        var newYear: Int
        var newMonth: Int
        var newDay: Int
        if isEndOfMonth() {
            if month == 12 {
                newYear = year + 1
                newMonth = 1
            } else {
                newYear = year
                newMonth = month + 1
            }
            newDay = 1
        } else {
            newYear = year
            newMonth = month
            newDay = day + 1
        }
        return YearMonthDay(year: newYear, month: newMonth, day: newDay)
    }
}

// メイン関数
func main() {
    // 1行目に、年 y と月 m と日 d が半角スペース区切りで与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let y = Int(items[0])!
    let m = Int(items[1])!
    let d = Int(items[2])!
    // 年月日情報
    let ymd = YearMonthDay(year: y, month: m, day: d)
    // 翌日取得
    let tomorrow = ymd.getTomorrow()
    // 結果出力
    print("\(tomorrow.year) \(tomorrow.month) \(tomorrow.day)")
}

// エントリーポイント
main()
