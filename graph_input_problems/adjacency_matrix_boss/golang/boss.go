/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の入力・辺の存在判定」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_boss

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

// 頂点を結ぶ辺
type Graph struct {
	// 頂点A
	a int
	// 頂点B
	b int
}

// main はエントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目に、頂点の個数を表す整数 n, 整数の組の個数を表す整数 q が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var n, _ = strconv.Atoi(items[0])
	var q, _ = strconv.Atoi(items[1])
	// 続く n 行では、隣接行列の上から i 行目の n 個の整数が、半角スペース区切りで与えられます。(1 ≦ i ≦ n)
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	for y := 0; y < n; y++ {
		sc.Scan()
		var itemsG []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		for x := 0; x < n; x++ {
			adjacencyMatrix[y][x], _ = strconv.Atoi(itemsG[x])
		}
	}
	// 続く q 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ q)
	var graphList []Graph
	for i := 0; i < q; i++ {
		sc.Scan()
		var itemsG []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var newGraph = new(Graph)
		newGraph.a, _ = strconv.Atoi(itemsG[0])
		newGraph.b, _ = strconv.Atoi(itemsG[1])
		graphList = append(graphList, *newGraph)
	}
	// 辺の判定
	for _, g := range graphList {
		fmt.Println(adjacencyMatrix[g.a-1][g.b-1])
	}
	return
}
