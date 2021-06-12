/*
これはpaizaラーニングの問題集にある「選択ソート」
https://paiza.jp/works/mondai/sort_naive/sort_naive__selection
にGo言語でチャレンジした試行錯誤コードです。
Go言語初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// selection_sort は選択ソートを行う
// i numbers : ソート対象
func selection_sort(numbers []int) []int {
	// 並べ替える数値の個数
	var n int = len(numbers)
	for i := 0; i < n-1; i++ {
		// A[i] ~ A[n-1] の最小値を見つけ、A[i]と交換する
		// つまり、整列済みとなっている A[0] ~ A[i-1] の末尾に、A[i] ~ A[n-1] の最小値を付け加える

		// A[i] ~ A[n-1] の最小値の位置を保存する変数 min_index を用意
		// 暫定的に A[i] を最小値とする
		var min_index int = i

		// 最小値を探す
		for j := i + 1; j < n; j++ {
			if numbers[j] < numbers[min_index] {
				min_index = j
			}
		}
		// A[i] と A[min_index]を交換
		// Go言語はこれで内容の入れ替えができる
		numbers[i], numbers[min_index] = numbers[min_index], numbers[i]

		// A[0] ~ A[i] が整列済みになった
		outputData(numbers)
	}
	// ソート結果を返す
	return numbers
}

// inputData はデータを読み込む
// o n       : 配列の要素数
//   numbers : ソート対象
//   error   : 処理続行不可能なエラーが発生した場合に返す
func inputData() (int, []int, error) {
	// 標準入力のScanner
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)

	// 1行目には盤面の行数を表す h , 盤面の列数を表す w が与えらる
	var n int
	var ret bool = sc.Scan()
	if ret == false {
		return 0, nil, errors.New("1行目が読み込めませんでした。")
	}
	var str_n string = sc.Text()
	if num, e := strconv.Atoi(str_n); e == nil {
		// 変換成功
		n = num
	} else {
		return 0, nil, errors.New(fmt.Sprintf(
			"数値変換に失敗しました。[%s]", str_n))
	}
	// 2行目に配列の要素 A_1, A_2, ... , A_n が半角スペース区切りで与えられる
	// 改行までの1行まるごと読み込む
	ret = sc.Scan()
	if ret == false {
		return 0, nil, errors.New("2行目が読み込めませんでした。")
	}
	var line string = sc.Text()
	// 数値配列変換
	var numbers, err = convertNumArray(line)
	if err != nil || len(numbers) != n {
		return 0, nil, errors.New(fmt.Sprintf(
			"2行目は不正な内容です。[%s]", line))
	}
	// 読み込んだデータ
	return n, numbers, nil
}

// convertNumArray はスペース区切り文字列を数値配列に変換する
// i str     : 処理対象文字列
// o []int   : 結果数値配列 変換にできない場合は0がセットされる
//   []error : 変換に失敗した場合に返す
func convertNumArray(str string) ([]int, []error) {
	var items []string = strings.Split(str, " ")
	var length int = len(items)
	var result []int = make([]int, length)
	// エラーをsliceで定義
	var err []error
	// 配列の個数分繰り返す iに0開始のループ回数、sに要素が入る
	for i, s := range items {
		// intに変換
		if num, e := strconv.Atoi(s); e == nil {
			// 変換成功
			result[i] = num
		} else {
			// sliceに追加
			err = append(err, errors.New(fmt.Sprintf(
				"[%d]番目 : [%s] 数値への変換に失敗しました。", (i+1), s)))
			result[i] = 0
		}
	}
	// エラー値はエラーがない場合はnilを返す
	if len(err) == 0 {
		return result, nil
	} else {
		return result, err
	}
}

// computeData は問題を解く
// i numbers : ソート対象
// o []int   : ソート結果の数値配列
//   error   : 処理続行不可なエラー発生時のみ返す
func computeData(numbers []int) ([]int, error) {
	if numbers == nil {
		return nil, errors.New("入力データがありません。")
	}
	// 選択ソート実行
	var result = selection_sort(numbers)

	return result, nil
}

// outputData は数値配列を出力する
// i numbers : 出力対象
func outputData(numbers []int) error {
	if numbers == nil {
		return errors.New("入力データがありません。")
	}
	// スペース区切りで数値配列を出力する
	fmt.Print(numbers[0])
	for i, max := 1, len(numbers); i < max; i++ {
		fmt.Printf(" %d", numbers[i])
	}
	fmt.Println()

	return nil
}

// main はエントリーポイント
func main() {
	// データ入力
	var _, numbers, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var _, err2 = computeData(numbers)
	if err2 != nil {
		fmt.Fprintln(os.Stderr, err2)
		return
	}
	// 処理完了
	return
}
