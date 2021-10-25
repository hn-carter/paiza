/*
これはpaizaラーニングの「二分探索メニュー」の「パイプを切り出そう」に
swiftでチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__application_step0
作成環境
Ubuntu 20.04.2 LTS
Swift version 5.4 (swift-5.4-RELEASE) Target: x86_64-unknown-linux-gnu
*/
import Foundation

// パイプを指定の長さで切り出した場合、必要な本数が確保できるか判定
// A : 数列, n : 数列のサイズ, l : 長さ, k : 必要な本数
func condition(A: [Int], n: Int,l: Double, k: Int) -> Bool {
    // 切り出せる本数
    var num: Int = 0
    for i in 0..<n {
        num += Int(Double(A[i]) / l)
    }
    return num >= k
}

// メイン関数
func main() {
    // 1行目に、パイプの本数 n と、切り出したいパイプの本数 k が与えられます。
    let items = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    let n = Int(items[0])!
    let k = Int(items[1])!
    // 2行目に、パイプの長さ A_i が半角スペース区切りで与えられます。
    var a: [Int] = [Int](repeating: 0, count: n)
    let itemsA = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
    for i in 0..<n {
        a[i] = Int(itemsA[i])!
    }
    // パイプを最も長いパイプの長さと0の間の長さを変えながら、必要な本数が確保される長さを求める
    var min: Double = 0.0
    var max: Double = Double(a.max()!)
    // 長さを変えながら試す回数をとりあえず101回にしました
    // 問題文通りminとmaxの誤差が10^-6 (0.000001) 以下となるでもいいけど無限ループが怖くて出来ませんでした
    //while (max - min) >= 10e-6 {
    for _ in 0...100 {
        let mid: Double = (min + max) / 2.0
        if condition(A: a, n: n, l: mid, k: k) {
            min = mid
        } else {
            max = mid
        }
    }

    // 結果出力
    print(max)
}

// エントリーポイント
main()
