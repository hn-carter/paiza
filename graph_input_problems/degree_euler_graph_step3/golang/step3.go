/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「オイラーグラフ・無向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step3

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
	var degree = make([]int, n)
	for i := 0; i < m; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var a, _ = strconv.Atoi(items[0])
		var b, _ = strconv.Atoi(items[1])
		// 頂点につながる辺をカウント
		degree[a-1]++
		degree[b-1]++
	}
	// 連結な無向グラフにおいて、ある頂点から始めてすべての辺を一筆書きして最初の頂点に戻ってくることが
	// できるための必要十分条件は以下のようになります。
	// ・すべての頂点の次数が偶数である。
	var answer int = 1
	for _, v := range degree {
		if v%2 != 0 {
			answer = 0
			break
		}
	}
	// 答えを出力する
	fmt.Println(answer)
	return
}
