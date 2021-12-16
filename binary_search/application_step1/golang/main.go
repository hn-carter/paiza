/*
これはpaizaラーニングの「二分探索メニュー」から「効率よく盗もう」
にGo言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/binary_search/binary_search__application_step1

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

// 財宝
type Treasure struct {
	// 重さ
	Weight float64
	// 価値
	Value float64
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1行目に、財宝の個数 n と、盗み出す財宝の個数 k が与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 2行目に、財宝の重さ W_i が半角スペース区切りで与えられます。
	var treasure []Treasure = make([]Treasure, n)
	sc.Scan()
	var itemsW []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	for i := 0; i < n; i++ {
		treasure[i].Weight, _ = strconv.ParseFloat(itemsW[i], 64)
	}
	// 3行目に、財宝の価値 V_i が半角スペース区切りで与えられます。
	sc.Scan()
	var itemsV []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	for i := 0; i < n; i++ {
		treasure[i].Value, _ = strconv.ParseFloat(itemsV[i], 64)
	}
	// 答えを求める
	var left float64 = 0.0
	var right float64 = 5001.0
	var mid float64 = 0.0
	for i := 0; i < 50; i++ {
		mid = (left + right) / 2.0
		var tmp []float64 = make([]float64, n)
		for j := 0; j < n; j++ {
			tmp[j] = treasure[j].Value - (treasure[j].Weight * mid)
		}
		// 重さあたりの価値を降順にソートして高価な k 個の財宝の価値を求める
		sort.Sort(sort.Reverse(sort.Float64Slice(tmp)))
		var sum float64 = 0.0
		for l := 0; l < k; l++ {
			sum += tmp[l]
		}
		if sum >= 0 {
			left = mid
		} else {
			right = mid
		}
	}
	// 結果出力
	fmt.Println(left)

	return
}
