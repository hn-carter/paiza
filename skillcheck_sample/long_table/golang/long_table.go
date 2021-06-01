/*
これはpaizaラーニングの問題集にある「長テーブルのうなぎ屋」
https://paiza.jp/works/mondai/skillcheck_sample/long-table
にGo言語でチャレンジした試行錯誤コードです。
Go初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

// 全てパッケージにしないとだめのようだ
// プログラムはmainパッケージが初期化されmain関数から実行される
package main

// このプログラムで使用するパッケージ（ライブラリ）
// "bufio"   バッファリングされたI/Oを実装したパッケージ
// "errors"  エラーを操作する関数を実装する
// "fmt"     Cのprintfやscanfに類似するフォーマットされたI/Oを提供する
// "os"      OSの機能をプラットフォームに依存しないインターフェースで提供する
// "strconv" 文字列を基本的なデータ型へ変換する
// "strings" UTF-8文字列を操作する関数を実装する
import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// Goではクラスがないので、代わりに構造体で代用？

// グループを表す構造体定義
type Group struct {
	a int // グループの人数
	b int // 1始まりの着席開始座席番号
}

// 読み込んだデータを表す構造体
type Data struct {
	n      int     // 座席数
	m      int     // グループ数
	groups []Group // グループ情報 ※Sliceという可変配列定義
}

// うなぎ屋構造体
type EelRestaurant struct {
	numberOfSeats    int    // 座席数
	numberOfVisitors int    // うなぎ屋にいる客数
	seatStatus       []bool // 座席の状態 true:座っている
}

// うなぎ屋構造体の初期化関数
// i : num 座席数
func newEelRestaurant(num int) *EelRestaurant {
	// うなぎ屋を作成し、初期化する
	var er *EelRestaurant = new(EelRestaurant)
	er.numberOfSeats = num
	// 0で初期化される、ということはfalseで初期化されていると考えても良いのか？
	er.seatStatus = make([]bool, num)
	return er
}

// うなぎ屋構造体にメソッドを定義する
// グループを可能なら座席に座らせる、できない場合はエラーを返す
// i people : グループ人数
//   seat   : 1始まりの着席開始座席番号
// o bool   : true全員座れた
//   error  : エラー
func (er *EelRestaurant) directToSeat(people, seat int) (bool, error) {
	if people < 0 || er.numberOfSeats < people {
		return false, errors.New("グループ人数が範囲外です。")
	}
	// 座席配列の着席開始位置を設定
	var no int = seat - 1
	// true:全員座れる
	var result bool = true
	// 人数分ループ
	for i := 0; i < people; i++ {
		// 座席は空いているかな？
		if er.seatStatus[no] {
			// すでに先客がいる！帰るぞ！
			result = false
			break
		}
		no++ // 次に座る座席配列番号
		// 座席配列番号が最後を超えたら0番に戻る
		if no >= er.numberOfSeats {
			no = 0
		}
	}
	// 全員座れるなら座席状態を着席に設定
	if result {
		no = seat - 1
		for i := 0; i < people; i++ {
			er.seatStatus[no] = true
			// 座席数で割ったあまりを設定すれば、配列の範囲を超えてアクセスすることはない
			no = (no + 1) % er.numberOfSeats
		}
		// 店の来店人数にグループ人数を加算
		er.numberOfVisitors += people
	}
	// エラーのたびに返しているのでここまで来たら正常
	return result, nil
}

// デフォルトではmain関数がエントリーポイントとなる
func main() {
	// データ入力
	// 返却値を受け取って結果判定するパターン
	var data, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var eelRestaurant, err2 = computeData(data)
	if err2 != nil {
		fmt.Fprintln(os.Stderr, err2)
		return
	}
	// 処理結果出力
	// 返却値受け取りと結果判定を1行でするパターン
	if err3 := outputData(eelRestaurant); err3 != nil {
		fmt.Fprintln(os.Stderr, err3)
		return
	}
	return
}

// 標準入力からテキストデータを行単位の配列として読み込む
func inputData() (*Data, error) {
	// 標準入力から読み取るScannerへのポインタを返す
	// Scannerは改行で区切られたテキスト行のファイルなどのデータを
	// 読み取るインターフェイス
	// os.Stdinは標準入力へのファイルポインタを開く
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)

	// Scannerを次のトークンへ進め、読み込んだデータはBytesまたは
	// Textメソッドで使用することができる
	// ※デフォルトでは改行単位で読み込む
	// 入力の最後（io.EOF）かエラーの場合falseを返す
	var ret bool = sc.Scan()
	if ret == false {
		return nil, errors.New("1行目が読み込めませんでした。")
	}
	// 1行目文字列を数値配列に変換
	var numbers1, err1 = convertNumArray(sc.Text())
	if err1 != nil || len(numbers1) != 2 {
		return nil, errors.New("1行目は不正な内容です。")
	}
	// 読み込みんだデータで返却値を作成
	var data Data
	if numbers1[0] < 1 || 100 < numbers1[0] {
		return nil, errors.New(
			fmt.Sprintf("座席数[%d]が範囲外です。", numbers1[0]))
	}
	data.n = numbers1[0] // 座席数
	if numbers1[1] < 1 || 100 < numbers1[1] {
		return nil, errors.New(
			fmt.Sprintf("グループ数[%d]が範囲外です。", numbers1[1]))
	}
	data.m = numbers1[1] // グループ数

	// グループ情報を読み込み
	for i := 0; i < data.m; i++ {
		ret = sc.Scan()
		if ret == false {
			return nil, errors.New(
				fmt.Sprintf("%d行目が読み込めませんでした。", (i + 2)))
		}
		// 文字列を数値配列に変換
		var numbers2, err2 = convertNumArray(sc.Text())
		if err2 != nil || len(numbers2) != 2 {
			return nil, errors.New(
				fmt.Sprintf("%d行目は不正な内容です。", (i + 2)))
		}
		// グループ情報を作成
		if numbers2[0] < 1 || data.n < numbers2[0] {
			return nil, errors.New(
				fmt.Sprintf("グループ人数[%d]が範囲外です。", numbers2[0]))
		}
		if numbers2[1] < 1 || data.n < numbers2[1] {
			return nil, errors.New(
				fmt.Sprintf("着席開始座席番号[%d]が範囲外です。", numbers2[1]))
		}
		var g Group
		g.a = numbers2[0]
		g.b = numbers2[1]
		// appendで追加する場合、内部に確保済みの配列よりも大きくなる場合は、
		// 新しくより大きな配列を割り当てて返す
		// ※個数があらかじめ分かっている場合はsliceは使わないほうが良いのかな？
		data.groups = append(data.groups, g)
	}
	// エラーが発生した時点で返しているので、処理がここまで来たら正常
	return &data, nil
}

// 長テーブルのうなぎ屋問題を解く
func computeData(d *Data) (*EelRestaurant, error) {
	if d == nil {
		return nil, errors.New("入力データがありません。")
	}
	// うなぎ屋作成
	var restaurant *EelRestaurant = newEelRestaurant(d.n)
	for _, g := range d.groups {
		// i番目のグループは座れ
		// 客が座れなくてもここでする処理はないので返却値に'_'を指定して捨てている
		var _, err = restaurant.directToSeat(g.a, g.b)
		if err != nil {
			return nil, err
		}
	}
	return restaurant, nil
}

// 処理結果を出力する
func outputData(er *EelRestaurant) error {
	if er == nil {
		return errors.New("入力データがありません。")
	}
	fmt.Println(er.numberOfVisitors)
	return nil
}

// スペース区切り文字列を数値配列に変換する
func convertNumArray(str string) ([]int, error) {
	var items []string = strings.Split(str, " ")
	// Goは配列のサイズに変数を指定できない
	// なのでsliceに大きさを指定して作る
	var length int = len(items)
	var result []int = make([]int, length)
	// エラーの定義
	var err error = nil
	// 配列の個数分繰り返す iに0開始のループ回数、sに要素が入る
	for i, s := range items {
		// intに変換
		if num, e := strconv.Atoi(s); e == nil {
			// 変換成功
			result[i] = num
		} else {
			if err == nil {
				err = errors.New("数値への変換に失敗しました。")
			}
			result[i] = 0
		}
	}
	return result, err
}
