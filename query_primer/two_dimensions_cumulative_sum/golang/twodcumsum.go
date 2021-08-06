/*
これはpaizaラーニングの「クエリメニュー」から「二次元累積和」
https://paiza.jp/works/mondai/query_primer/query_primer__two_dimensions_cumulative__sum
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
type Pair struct {
	Y int
	X int
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
	// 続く N 行では、累積和を求めるのに使う整数のペア y , x が N 個与えられます。
	var pairList = make([]Pair, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		pairList[i].Y, _ = strconv.Atoi(itemsI[0])
		pairList[i].X, _ = strconv.Atoi(itemsI[1])
	}
	// 問題を解く
	// 二次元配列の全てのパターンの合計を計算する
	var sum = make([][]int, h)
	for i := 0; i < h; i++ {
		sum[i] = make([]int, w)
	}
	// X方向に加算
	for y := 0; y < h; y++ {
		sum[y][0] = a[y][0]
		for x := 1; x < w; x++ {
			sum[y][x] = sum[y][x-1] + a[y][x]
		}
	}
	// Y方向に加算
	for y := 1; y < h; y++ {
		for x := 0; x < w; x++ {
			sum[y][x] += sum[y-1][x]
		}
	}
	// 指示された累積和を出力
	for _, p := range pairList {
		var answer int = sum[p.Y-1][p.X-1]
		fmt.Println(answer)
	}

	return
}
