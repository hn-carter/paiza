/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「入出次数・有向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step6

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

// main はエントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var n, _ = strconv.Atoi(items[0])
	var m, _ = strconv.Atoi(items[1])
	// 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
	var indegree = make([]int, n)
	var outdegree = make([]int, n)
	for i := 0; i < m; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var a, _ = strconv.Atoi(items[0])
		var b, _ = strconv.Atoi(items[1])
		// 頂点につながる辺をカウント
		outdegree[a-1]++
		indegree[b-1]++
	}
	// 答えを出力する
	for i := 0; i < n; i++ {
		if i > 0 {
			print(" ")
		}
		fmt.Print(indegree[i])
	}
	fmt.Println("")
	for i := 0; i < n; i++ {
		if i > 0 {
			print(" ")
		}
		fmt.Print(outdegree[i])
	}
	fmt.Println("")
	return
}
