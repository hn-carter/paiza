// テストデータ作成
import Foundation

func main() {
    let filename = "test1.txt"

    // データ件数
    let snum = String(199 * 7 + 1) + "\n"

    guard let fh = FileHandle(forWritingAtPath: filename) else { return }
    fh.seekToEndOfFile()
    let wnum = String(snum).data(using: .utf8)!
    fh.write(wnum)
    fh.closeFile()
}

// エントリーポイント
main()