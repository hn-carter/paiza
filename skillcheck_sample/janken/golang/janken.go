/*
これはpaizaラーニングの問題集にある「じゃんけんの手の出し方」
https://paiza.jp/works/mondai/skillcheck_sample/janken
にGo言語でチャレンジした試行錯誤コードです。
Go初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

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

// 入力データを表す構造体
// 名前を大文字で始めると他のパッケージからアクセス可能となる
// 小文字で始めると同じパッケージ内からのみアクセスできる
type Data struct {
	n int    // じゃんけんを行う回数
	m int    // あなたが出す指の本数の合計
	s []rune // じゃんけんで相手が出す手を表す
	// `G`:グー、`C`:チョキ、`P`:パー runeの配列を使ってみる
}

// 入力データの初期化関数
// i num    : じゃんけんを行う回数
//   finger : あなたが出す指の本数の合計
// o *Data  : 初期化済み入力データ
func newData(num int, finger int) *Data {
	var d *Data = new(Data)
	d.n = num
	d.m = finger
	d.s = make([]rune, num)
	return d
}

// じゃんけんを行う構造体
type Janken struct {
	n int    // じゃんけんを行う回数
	m int    // あなたが出す指の本数の合計
	s []rune // じゃんけんで相手が出す手を表す
}

// じゃんけんの初期化処理
// i n        : じゃんけんを行う回数
//   m        : あなたが出す指の本数の合計
//   s        : じゃんけんで相手が出す手
// o *Janken  : 初期化済みじゃんけん
func newJanken(n int, m int, s []rune) *Janken {
	var j *Janken = new(Janken)
	j.n = n
	j.m = m
	j.s = s
	return j
}

// じゃんけんで勝つ最大値を求める
func (jan *Janken) execJanken() (int, error) {
	// 勝てる最大回数
	var result int = 0
	// まず相手が出す手ごとの回数を求める
	var aG, aC, aP int
	for _, r := range jan.s {
		switch r {
		case 'G': // グー
			aG++
		case 'C': // チョキ
			aC++
		case 'P': // パー
			aP++
		}
	}

	// 出す指の数は、グーが0、チョキが2、パーが5なので指の本数は以下の式で求まる
	// 出す指の本数＝グーの勝ち数×0 ＋ チョキの勝ち数×2 ＋ パーの勝ち数×5
	// チョキかパーのどちらかの勝利数が決まればもう一方の勝利数も決まる

	// チョキとパーを出す組み合わせが「出す指の合計数」になる場合で最大の勝ち数を求める
	// チョキを出せる最大回数＝出す指の合計数÷2
	// からループ回数(チョキを出す回数)が求まる
	var maxC int = jan.m / 2
	if maxC > jan.n {
		maxC = jan.n // ただし出せる最大回数はじゃんけんの回数まで
	}
	for c := 0; c <= maxC; c++ {
		// cはチョキを出す回数
		// チョキ以外の指の本数がパー(5本)の倍数でないならスキップ
		if ((jan.m - c*2) % 5) != 0 {
			continue
		}
		// pはパーを出す回数
		var p int = (jan.m - c*2) / 5
		// gはグーを出す回数
		// 全体の回数からチョキとパーの回数を引けば残りはグー
		var g int = jan.n - c - p
		if g < 0 {
			continue
		}
		// この手で全体の勝ち数を求める
		// minは小さい方を返す自作関数
		// min(aC, g) : グーで勝てるのは相手がチョキを出したときだけ
		// 他の手も同様に計算し全体の勝ち数を求める
		var win int = min(aC, g) + min(aP, c) + min(aG, p)
		if result < win {
			result = win // 計算した勝ち数が多い場合に更新
		}
	}
	// 結果
	return result, nil
}

// エントリーポイント
func main() {
	// データ入力
	var data, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var nunberOfWins, err2 = computeData(data)
	if err2 != nil {
		fmt.Fprintln(os.Stderr, err2)
		return
	}
	// 処理結果出力
	// 返却値受け取りと結果判定を1行でするパターン
	if err3 := outputData(nunberOfWins); err3 != nil {
		fmt.Fprintln(os.Stderr, err3)
		return
	}
	return
}

// 標準入力からデータを読み込み、処理しやすい形に変換する
// o *Data : データを表す構造体
//   error : 処理続行不可なエラー発生時のみ設定される
func inputData() (*Data, error) {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1行目読み込み
	if ret := sc.Scan(); ret == false {
		return nil, errors.New("1行目が読み込めませんでした")
	}
	var numbers1, err1 = convertNumArray(sc.Text())
	if err1 != nil || len(numbers1) != 2 {
		return nil, errors.New("1行目は不正な内容です。")
	}
	if numbers1[0] < 1 || 1000 < numbers1[0] {
		return nil, errors.New(
			fmt.Sprintf("じゃんけんを行う回数[%d]が範囲外です。",
				numbers1[0]))

	}
	if numbers1[1] < 0 || 5000 < numbers1[1] {
		return nil, errors.New(
			fmt.Sprintf("あなたが出す指の本数の合計[%d]が範囲外です。",
				numbers1[1]))
	}
	// 返却する構造体を作成し初期化
	var data *Data = newData(numbers1[0], numbers1[1])
	// じゃんけんで相手が出す手を読み込む
	if ret := sc.Scan(); ret == false {
		return nil, errors.New("2行目が読み込めませんでした")
	}
	// 2行目の文字列を取得
	var line = sc.Text()
	if len(line) > data.n {
		return nil, errors.New(
			fmt.Sprintf("相手がじゃんけんで出す手の数が多い[%s]", line))
	}
	// 1文字ずつ処理する
	// 文字列(string)のrangeはルーン(rune)を返す
	// ルーン(rune)はユニコードコードポイントを表す整数値(int32)
	for j, c := range line {
		data.s[j] = c
	}
	// 正常結果を返す
	return data, nil
}

// 「じゃんけんの手の出し方」を解く
// i *Data : 入力データ
// o int   : 最大勝利回数
//   error : 続行不可能なエラーが発生した場合に設定する
func computeData(d *Data) (int, error) {
	if d == nil {
		return 0, errors.New("入力データがありません。")
	}
	// じゃんけん
	var jan *Janken = newJanken(d.n, d.m, d.s)
	// 問題を解く関数を実行
	if numberOfWins, err := jan.execJanken(); err != nil {
		return 0, err
	} else {
		return numberOfWins, nil
	}
}

// 処理結果を出力する
// i num   : 出力データ
// o error : 続行不可能なエラーが発生した場合に設定する
func outputData(num int) error {
	fmt.Println(num)
	return nil
}

// スペース区切り文字列を数値配列に変換する
// i str   : 処理対象文字列
// o []int : 変換後の数値配列 変換に失敗した文字列は0が設定される
//   error : エラーの場合にセットされる
//           処理を続行するかは受け取り手が判断する
func convertNumArray(str string) ([]int, error) {
	// スペースで分割
	var items []string = strings.Split(str, " ")
	// 処理結果配列作成
	var result []int = make([]int, len(items))
	// エラーの定義
	var err error = nil
	// 配列の個数分繰り返す iに0開始のループ回数、sに要素が入る
	for i, s := range items {
		// intに変換
		if num, e := strconv.Atoi(s); e != nil {
			if err == nil {
				err = errors.New("数値への変換に失敗しました。")
			}
			result[i] = 0
		} else {
			// 変換成功
			result[i] = num
		}
	}
	return result, err
}

// 小さい方のint値を返す
func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
