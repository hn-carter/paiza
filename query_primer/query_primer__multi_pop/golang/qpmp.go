/*
これはpaizaラーニングの「クエリメニュー」から「先頭の要素の削除(query)」
https://paiza.jp/works/mondai/query_primer/query_primer__multi_pop
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

////////////////////////////////////////
// ここからGo言語にキューが無いので実装
type Queue struct {
	data []int
	size int
}

// キューのコンストラクタ
// i s : キャパシティ　メモリ確保するサイズ
func NewQueue(s int) *Queue {
	var ret = new(Queue)
	ret.data = make([]int, 0, s)
	ret.size = 0
	return ret
}

// キューに追加
func (q *Queue) Push(v int) {
	q.data = append(q.data, v)
	q.size++
}

// キューから取り出し
// o int  : 先頭の値
//   bool : false 空のため取り出し失敗
func (q *Queue) Pop() (int, bool) {
	if q.IsEmpty() {
		return 0, false
	}
	var ret = q.data[0]
	// q.data[0]=nil 値型は不要だが参照型の場合メモリリークの原因になる
	q.data = q.data[1:]
	q.size--
	return ret, true
}

// 内容出力
func (q *Queue) Show() {
	for i := 0; i < q.size; i++ {
		fmt.Println(q.data[i])
	}
}

// キューが空か判定
func (q *Queue) IsEmpty() bool {
	return q.size == 0
}

// ここまでキューの実装
////////////////////////////////////////

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、配列 A の要素数 N と与えられる入力の数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行では、配列 A の要素が先頭から順に与えられます。
	var a = NewQueue(n)
	for i := 0; i < n; i++ {
		sc.Scan()
		var num, _ = strconv.Atoi(sc.Text())
		a.Push(num)
	}
	// 続く K 行では、"pop" または "show" が与えられます。
	var o = make([]string, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		o[i] = sc.Text()
	}
	// 配列oの操作を行う
	for _, op := range o {
		switch op {
		case "pop":
			a.Pop()
		case "show":
			a.Show()
		}
	}

	return
}
