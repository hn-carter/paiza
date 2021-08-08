/*
これはpaizaラーニングの「クエリメニュー」から「平方分割のバケット」
https://paiza.jp/works/mondai/query_primer/query_primer__square_division_bucket
にGo言語でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 10000 行で数列 A の要素が先頭から順に与えられます。
	var NUMBER int = 10000
	var array = make([]int, NUMBER)
	for i := 0; i < NUMBER; i++ {
		sc.Scan()
		array[i], _ = strconv.Atoi(sc.Text())
	}
	// 配列を100区間ごとに分割し、それぞれの区間の最大値を求める
	var interval = 100
	var maxList = make([]int, interval)
	for i := 0; i < interval; i++ {
		maxList[i] = math.MinInt32
		var begin = i * interval
		var end = begin + interval
		for j := begin; j < end; j++ {
			if maxList[i] < array[j] {
				maxList[i] = array[j]
			}
		}
	}
	// 区間ごとの最大値を出力
	for _, val := range maxList {
		fmt.Println(val)
	}

	return
}
