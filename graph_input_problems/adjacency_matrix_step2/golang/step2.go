/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「隣接行列の出力・有向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__adjacency_matrix_step2

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
	// 1 行目に、頂点の個数を表す整数 n と、頂点の組の個数を表す整数 m が半角スペース区切りで与えられます。
	sc.Scan()
	var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
	var n, _ = strconv.Atoi(items[0])
	var m, _ = strconv.Atoi(items[1])
	// 続く m 行では、頂点の組 a_i, b_i が半角スペース区切りで与えられます。(1 ≦ i ≦ m)
	var graphList []Graph
	for i := 0; i < m; i++ {
		sc.Scan()
		var itemsG []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var newGraph = new(Graph)
		newGraph.a, _ = strconv.Atoi(itemsG[0])
		newGraph.b, _ = strconv.Atoi(itemsG[1])
		graphList = append(graphList, *newGraph)
	}
	// 結果の隣接行列
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	// 隣接行列を作成する
	for _, g := range graphList {
		adjacencyMatrix[g.a-1][g.b-1] = 1
	}
	// 隣接行列を出力する
	for y := 0; y < n; y++ {
		for x := 0; x < n; x++ {
			if x > 0 {
				print(" ")
			}
			fmt.Print(adjacencyMatrix[y][x])
		}
		fmt.Println("")
	}
	return
}
