/*
これはpaizaラーニングの「グラフ構造の入力メニュー」-「しりとり」に
go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/graph_input_problems/graph_input_problems__degree_euler_graph_boss

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
	// 1 行目に、文字列の個数を表す整数 n が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(strings.TrimSpace(sc.Text()))
	// 続く n 行では、文字列 s_i が与えられます。(1 ≦ i ≦ n)
	var degree = make(map[string]*Degree)
	for i := 0; i < n; i++ {
		sc.Scan()
		var word string = strings.TrimSpace(sc.Text())
		// 文字列の先頭と末尾の文字をカウント
		var head string = word[0:1]
		var tail string = word[len(word)-1:]
		if deg, exists := degree[head]; exists {
			deg.indegree++
		} else {
			degree[head] = &Degree{indegree: 1, outdegree: 0}
		}
		if deg, exists := degree[tail]; exists {
			deg.outdegree++
		} else {
			degree[tail] = &Degree{indegree: 0, outdegree: 1}
		}
	}
	// 準オイラーグラフか判定する
	// ・すべての頂点において、入次数と出次数が一致する。
	// ・以下の条件をすべて満たす。
	// ・(入次数) = (出次数 + 1) となる頂点がちょうど 1 つ存在する。
	// ・(入次数 + 1) = (出次数) となる頂点がちょうど 1 つ存在する。
	// ・残りのすべての頂点について、入次数と出次数が一致する。
	var isSame bool = true
	var oneManyIn int = 0
	var oneManyOut int = 0
	for _, deg := range degree {
		if deg.indegree != deg.outdegree {
			isSame = false
			if deg.indegree-deg.outdegree == 1 {
				oneManyIn++
			} else if deg.outdegree-deg.indegree == 1 {
				oneManyOut++
			}
		}
	}
	// しりとりをすることができる場合は 1, そうでない場合は 0
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
