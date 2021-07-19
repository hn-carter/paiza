/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
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
)

func main() {
	sc := bufio.NewScanner(os.Stdin)
	sc.Scan()
	// 人数 n
	var n, _ = strconv.Atoi(sc.Text())
	// 身長 a_n
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 動的計画法で問題を解く
	var dp = make([]int, n)
	dp[0] = 1
	for i := 1; i < n; i++ {
		if a[i-1] <= a[i] {
			dp[i] = dp[i-1] + 1
		} else {
			dp[i] = 1
		}
	}
	// 結果出力
	var max = dp[0]
	for i := 1; i < n; i++ {
		if max < dp[i] {
			max = dp[i]
		}
	}
	fmt.Println(max)

	return
}
