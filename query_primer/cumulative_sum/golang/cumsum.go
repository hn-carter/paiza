/*
これはpaizaラーニングの「クエリメニュー」から「累積和」
https://paiza.jp/works/mondai/query_primer/query_primer__cumulative_sum
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
	// 続く K 行では、整数 Q_1 ... Q_K が与えられます。
	var q = make([]int, k)
	var maxQ int = 0 // 求める最大値
	for i := 0; i < k; i++ {
		sc.Scan()
		q[i], _ = strconv.Atoi(sc.Text())
		if maxQ < q[i] {
			maxQ = q[i]
		}
	}
	// 問題を解く
	// 加算回数毎の合計を計算
	var temp = make([]int, maxQ+1)
	temp[0] = 0
	for i := 1; i <= maxQ; i++ {
		temp[i] = temp[i-1] + a[i-1]
	}
	// 指示された加算回数を出力
	for _, val := range q {
		fmt.Println(temp[val])
	}

	return
}
