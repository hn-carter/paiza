/*
これはpaizaラーニングの「クエリメニュー」から「先頭の要素の削除」
https://paiza.jp/works/mondai/query_primer/query_primer__single_pop
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

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、配列 A の要素数 N が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(sc.Text())
	// 続く N 行では、配列 A の要素が先頭から順に与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 先頭の要素を取り出して捨てる
	var _ = a[0]
	// 配列(slice)から先頭の要素を削除する
	a = a[1:]
	// 結果出力
	for _, ans := range a {
		fmt.Println(ans)
	}

	return
}
