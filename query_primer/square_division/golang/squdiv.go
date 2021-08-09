/*
これはpaizaラーニングの「クエリメニュー」から「平方分割」
https://paiza.jp/works/mondai/query_primer/query_primer__square_division
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
	"strings"
)

// 区間
type Pair struct {
	Begin int
	End   int
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、与えられる区間の個数 K が与えられます。
	sc.Scan()
	var k, _ = strconv.Atoi(sc.Text())
	// 続く 10,000 行で数列 A の要素が先頭から順に与えられます。
	var NUMBER int = 10000
	var a = make([]int, NUMBER)
	for i := 0; i < NUMBER; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 続く K 行のうち i 行目では、 i 個目の区間の両端の
	// 要素番号を表す整数 l_i , r_i が与えられます。
	var inteList = make([]Pair, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		inteList[i].Begin, _ = strconv.Atoi(itemsI[0])
		inteList[i].End, _ = strconv.Atoi(itemsI[1])
	}
	// 配列の平方根区間ごとに分割し、それぞれの区間の最大値を求める
	var interval = int(math.Sqrt(float64(NUMBER)))
	var maxList = make([]int, interval)
	for i := 0; i < interval; i++ {
		maxList[i] = math.MinInt32
		var begin = i * interval
		var end = begin + interval
		for j := begin; j < end; j++ {
			if maxList[i] < a[j] {
				maxList[i] = a[j]
			}
		}
	}
	// 区間ごとの最大値を出力
	for _, inte := range inteList {
		// 配列は0始まりのため-1する
		var b = inte.Begin - 1
		var e = inte.End - 1
		var answer = math.MinInt32
		for b <= e {
			// あらかじめ求めておいた区間内に収まるか判定
			var remainder int = b % interval
			var limit int = b + interval - 1
			if (remainder) == 0 && limit <= e {
				// 区間内に収まる場合
				var i = int(b / interval)
				if answer < maxList[i] {
					answer = maxList[i]
				}
				b += interval
			} else {
				// 区切りの区間からはみ出る場合
				if answer < a[b] {
					answer = a[b]
				}
				b++
			}
		}
		// 区間の最大値
		fmt.Println(answer)
	}

	return
}
