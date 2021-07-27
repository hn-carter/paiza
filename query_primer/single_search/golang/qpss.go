/*
これはpaizaラーニングの「クエリメニュー」から「指定要素の検索」
https://paiza.jp/works/mondai/query_primer/query_primer__single_search
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
	// 1 行目では、配列 A の要素数 N と検索する値 K が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行では、配列 A の要素が先頭から順に与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// A に K が含まれているか調べる
	var result string = "NO"
	for _, v := range a {
		if v == k {
			result = "YES"
			// 見つかったのでループ脱出
			break
		}
	}
	// 結果出力
	fmt.Println(result)

	return
}
