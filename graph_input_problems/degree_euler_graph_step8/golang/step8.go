/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「準オイラーグラフ・有向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_step8

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
	// 弱連結な有向グラフにおいて、すべての辺を一筆書きすることができるための
	// 必要十分条件は以下のいずれかを満たすことです。
	// ・すべての頂点において、入次数と出次数が一致する。
	// ・以下の条件をすべて満たす。
	// ・(入次数) = (出次数 + 1) となる頂点がちょうど 1 つ存在する。
	// ・(入次数 + 1) = (出次数) となる頂点がちょうど 1 つ存在する。
	// ・残りのすべての頂点について、入次数と出次数が一致する。
	var isSame bool = true
	var oneManyIn int = 0
	var oneManyOut int = 0
	for i := 0; i < n; i++ {
		if indegree[i] != outdegree[i] {
			isSame = false
			if indegree[i]-outdegree[i] == 1 {
				oneManyIn++
			} else if outdegree[i]-indegree[i] == 1 {
				oneManyOut++
			}
		}
	}
	// すべての辺を一筆書きすることができる場合は 1, そうでない場合は 0
	var answer int
	if isSame || (oneManyIn == 1 && oneManyOut == 1) {
		answer = 1
	} else {
		answer = 0
	}
	// 答えを出力する
	fmt.Println(answer)
	return
}
