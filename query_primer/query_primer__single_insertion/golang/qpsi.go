/*
これはpaizaラーニングの「クエリメニュー」から「指定の位置への要素の追加」
https://paiza.jp/works/mondai/query_primer/query_primer__single_insertion
にGo言語でチャレンジした試行錯誤コードです。
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
	// 1 行目では、配列 A の要素数 N と整数 K , Q が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	var q, _ = strconv.Atoi(items[2])
	// 続く N 行では、配列 A の要素が先頭から順に与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 配列 A の位置 K の後ろに Q を挿入する
	// 配列 A は0始まりだが、位置 K は1始まりなので1つずれる
	a = append(a[:k], a[k-1:]...)
	a[k] = q
	// 配列の各要素を先頭から改行区切りで出力する
	for _, v := range a {
		fmt.Println(v)
	}

	return
}
