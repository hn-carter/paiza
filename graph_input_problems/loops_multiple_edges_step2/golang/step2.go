/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「多重辺・無向グラフ」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__loops_multiple_edges_step2

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
	// 1 行目に、頂点の個数を表す整数 n が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	// 続く n 行では、隣接行列の上から i 行目の n 個の整数が左から順に半角スペース区切りで与えられます。(1 ≦ i ≦ n)
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	for i := 0; i < n; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		for j, v := range items {
			adjacencyMatrix[i][j], _ = strconv.Atoi(v)
		}
	}
	// 多重辺を求める
	var edges []Graph
	for y := 0; y < n; y++ {
		for x := y + 1; x < n; x++ {
			if adjacencyMatrix[y][x] > 1 {
				edges = append(edges, *NewGraph(y+1, x+1))
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
