/*
これはpaizaラーニングの「クエリメニュー」から「連想配列」
https://paiza.jp/works/mondai/query_primer/query_primer__map_easy
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
	// 1 行目では、生徒の人数 N と与えられる出席番号の個数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち i 行目 (1 ≦ i ≦ N) では、i 番目の生徒の出席番号と識別 ID の組 num_i , ID_i が半角スペース区切りで与えられます。
	var students map[int]string = map[int]string{}
	for i := 0; i < n; i++ {
		sc.Scan()
		var s []string = strings.Split(sc.Text(), " ")
		var num, _ = strconv.Atoi(s[0])
		students[num] = s[1]
	}
	//続く K 行では、出席番号 Q_i (1 ≦ i ≦ K) が与えられます。
	var q = make([]int, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		q[i], _ = strconv.Atoi(sc.Text())
	}
	// 生徒の検索
	for _, num := range q {
		var val, e = students[num]
		if e {
			fmt.Println(val)
		} else {
			fmt.Fprintf(os.Stderr, "%dの生徒は存在しない\n", num)
		}
	}

	return
}
