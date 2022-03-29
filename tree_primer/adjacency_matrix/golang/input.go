/*
これはpaizaラーニングの「木のメニュー」-「木の入力の受け取り（隣接行列）」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/tree_primer/tree_primer__adjacency_matrix_input

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

type Degree struct {
	indegree  int
	outdegree int
}

// main はエントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目には、頂点の数 N が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	// 続く N-1 行では、各辺の両端の頂点 a_i , b_i が与えられます。(1 ≦ i ≦ N-1)
	var adjacencyMatrix = make([][]int, n)
	for i := 0; i < n; i++ {
		adjacencyMatrix[i] = make([]int, n)
	}
	for i := 1; i < n; i++ {
		sc.Scan()
		var items []string = strings.Split(strings.TrimSpace(sc.Text()), " ")
		var a, _ = strconv.Atoi(items[0])
		var b, _ = strconv.Atoi(items[1])
		adjacencyMatrix[a-1][b-1]++
		adjacencyMatrix[b-1][a-1]++
	}
	// 結果出力
	for _, line := range adjacencyMatrix {
		for x, v := range line {
			if x > 0 {
				fmt.Print(" ")
			}
			fmt.Print(v)
		}
		fmt.Println("")
	}
	return
}
