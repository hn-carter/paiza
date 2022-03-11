/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「多重辺・有向グラフ (辺入力)」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_boss

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

// コンストラクタ
func NewGraph(a int, b int) *Graph {
	var g = new(Graph)
	g.a = a
	g.b = b
	return g
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
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	for i := 0; i < m; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var a, _ = strconv.Atoi(items[0])
		var b, _ = strconv.Atoi(items[1])
		adjacencyMatrix[a-1][b-1] += 1
	}
	// 多重辺を求める
	var edges []Graph
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if adjacencyMatrix[i][j]+adjacencyMatrix[j][i] > 1 {
				edges = append(edges, *NewGraph(i+1, j+1))
			}
		}
	}
	// 答えを出力する
	fmt.Println(len(edges))
	for _, v := range edges {
		fmt.Printf("%d %d\n", v.a, v.b)
	}
	return
}
