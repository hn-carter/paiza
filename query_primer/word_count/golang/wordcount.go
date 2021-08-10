/*
これはpaizaラーニングの「クエリメニュー」から「'I' の数」
https://paiza.jp/works/mondai/query_primer/query_primer__word_count
にGo言語でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
go version go1.16.4 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

// 区間
type Match struct {
	// プレイヤー A が掴んだページの両端のページ番号
	Al int
	Ar int
	//プレイヤー B が掴んだページの両端のページ番号
	Bl int
	Br int
}

// 試合を行って結果を返す
// i valid : 有効ページ数
//   a     : ページ毎の 'I' の数
// o       : 結果 A B DRAW
func (m *Match) PlayMatch(valid int, a []int) string {
	var aPages int = CountPageNumber(m.Al, m.Ar, valid, a)
	var bPages int = CountPageNumber(m.Bl, m.Br, valid, a)
	if aPages == bPages {
		return "DRAW"
	} else if aPages < bPages {
		return "B"
	}
	return "A"
}

// 選択したページに含まれる'I'を数える
// 無効の場合0を返す
func CountPageNumber(l int, r int, valid int, a []int) int {
	var count int = -1
	if (r - l + 1) < valid {
		count = 0
		for i := l - 1; i < r; i++ {
			count += a[i]
		}
	}
	return count
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、教科書のページ数 N とおこなわれる試合数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち、 i 行目では、教科書の i ページ目に含まれる 'I' の数が与えられます。
	var a = make([]int, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		a[i], _ = strconv.Atoi(sc.Text())
	}
	// 続く K 行のうち、 i 行目では、i 試合目のプレイヤー A が掴んだページの両端のページ番号 A_l_i ,
	// A_r_i とプレイヤー B が掴んだページの両端のページ番号 B_l_i , B_r_i が与えられます。
	var matchList = make([]Match, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		var itemsI []string = strings.Split(sc.Text(), " ")
		matchList[i].Al, _ = strconv.Atoi(itemsI[0])
		matchList[i].Ar, _ = strconv.Atoi(itemsI[1])
		matchList[i].Bl, _ = strconv.Atoi(itemsI[2])
		matchList[i].Br, _ = strconv.Atoi(itemsI[3])
	}
	// n / 3 以上のページでない場合は無効
	var valid int = int(math.Ceil(float64(n) / 3.0))
	// 試合結果出力
	for _, match := range matchList {
		fmt.Println(match.PlayMatch(valid, a))
	}

	return
}
