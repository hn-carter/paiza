/*
これはpaizaラーニングの「クエリメニュー」から「区間和」
https://paiza.jp/works/mondai/query_primer/query_primer__interval_sum
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

// 区間
type Interval struct {
	// 区間開始位置
	L int
	//区間終了位置
	R int
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、配列 A の要素数 N と与えられる整数の数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行では、配列 A の要素が A_1 から順に与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 続く K 行では、和を求めるのに使う区間の値 l , r が与えられます。
	var interList = make([]Interval, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		interList[i].L, _ = strconv.Atoi(itemsI[0])
		interList[i].R, _ = strconv.Atoi(itemsI[1])
	}
	// 問題を解く
	// 区間の和は [1-終了位置]の合計から[1-開始位置-1]の合計を引いた値になる
	// 与えられた数列 A   16    88    10   -65
	// 1からの合計      | 16 | 104 | 114 |  49 |
	// 区間 2 4 の和は、 1 から 4 の合計値 49 から、2番目未満の合計値、この場合 1 のみで 16 を引いて
	// 49 - 16 = 33となる

	// 区間の開始からの合計値を求める
	var q = make([]int, n+1)
	q[0] = 0
	for i, val := range a {
		q[i+1] = q[i] + val
	}

	// 指示された区間和を出力
	for _, interval := range interList {
		var answer int = q[interval.R] - q[interval.L-1]
		fmt.Println(answer)
	}

	return
}
