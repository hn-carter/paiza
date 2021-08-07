/*
これはpaizaラーニングの「クエリメニュー」から「二次元区間和」
https://paiza.jp/works/mondai/query_primer/query_primer__two_dimensions_interval_sum
にGo言語でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// ペアの数字
type WPair struct {
	Y1 int
	X1 int
	Y2 int
	X2 int
}

// 数字文字列をintスライスに変換する
func ConvertIntSlice(s string) []int {
	var items []string = strings.Split(s, " ")
	var ret = make([]int, len(items))
	for i, str := range items {
		ret[i], _ = strconv.Atoi(str)
	}
	return ret
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、配列 A の行数 H と列数 W , 与えられる整数のペアの個数 N が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var h, _ = strconv.Atoi(items[0])
	var w, _ = strconv.Atoi(items[1])
	var n, _ = strconv.Atoi(items[2])
	// 続く H 行のうち i 行目では、行列 A の i 行の要素が半角スペース区切りで A[i][1] から順に与えられます。
	var a = make([][]int, h)
	for i := 0; i < h; i++ {
		sc.Scan()
		a[i] = ConvertIntSlice(sc.Text())
	}
	// 続く N 行のうち i 行目では、累積和を求めるのに使う 2 つの
	// 行番号・列番号のペア {a_i , b_i} {c_i , d_i} が与えられます。
	var pairList = make([]WPair, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		pairList[i].Y1, _ = strconv.Atoi(itemsI[0])
		pairList[i].X1, _ = strconv.Atoi(itemsI[1])
		pairList[i].Y2, _ = strconv.Atoi(itemsI[2])
		pairList[i].X2, _ = strconv.Atoi(itemsI[3])
	}
	// 問題を解く
	// 二次元配列の[1][1]からの全てのパターンの合計を計算する
	// 区間和は
	//        |  1 |  2 |  3 |
	//        |  4 |  5 |  6 |
	//        |  7 |  8 |  9 |
	// と入力が与えられた場合、
	//   |  0 |  0 |  0 |  0 |
	//   |  0 |  1 |  3 |  6 |
	//   |  0 |  5 | 12 | 21 |
	//   |  0 | 12 | 27 | 45 |
	// 計算をしやすくするため、端に0を付加して全てのマスの和を求める
	// S({2,2},{3,3})の区間和を求める場合
	//   {3, 3}の和 - {2-1, 3}の和 - {3, 2-1}の和 + {2-1, 2-1}の和
	// で求められる
	// ※端の0埋めをしない場合、配列の範囲チェックが必要になる
	var sum = make([][]int, h+1)
	for i := 0; i <= h; i++ {
		sum[i] = make([]int, w+1)
	}
	for x := 0; x <= w; x++ {
		sum[0][x] = 0
	}
	for y := 0; y <= h; y++ {
		sum[y][0] = 0
	}
	// X方向に加算
	for y := 0; y < h; y++ {
		sum[y+1][1] = a[y][0]
		for x := 1; x < w; x++ {
			sum[y+1][x+1] = sum[y+1][x] + a[y][x]
		}
	}
	// Y方向に加算
	for y := 2; y <= h; y++ {
		for x := 1; x <= w; x++ {
			sum[y][x] += sum[y-1][x]
		}
	}
	// 指示された累積和を出力
	for _, p := range pairList {
		var answer int = sum[p.Y2][p.X2] - sum[p.Y2][p.X1-1] - sum[p.Y1-1][p.X2] + sum[p.Y1-1][p.X1-1]
		fmt.Println(answer)
	}

	return
}
