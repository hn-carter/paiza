/*
これはpaizaラーニングの「クエリメニュー」から「Vtuber」
https://paiza.jp/works/mondai/query_primer/query_primer__vtuber
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
	"sort"
	"strconv"
	"strings"
)

// スーパーチャット構造体
type ScType struct {
	// アカウント
	Account string
	// 金額
	Money int
}

// スーパーチャット構造体配列のソート用
type ScList []ScType

func (s ScList) Len() int {
	return len(s)
}
func (s ScList) Less(i, j int) bool {
	if s[i].Money == s[j].Money {
		return s[i].Account > s[j].Account
	} else {
		return s[i].Money > s[j].Money
	}
}
func (s ScList) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、superchat とメンバーシップ加入の回数の和 N が与えられます。
	sc.Scan()
	var n, _ = strconv.Atoi(sc.Text())
	// 続く N 行のうち、 i 行目では、i 番目のイベントの内容 E_i が以下のいずれかの形式で与えれられます。
	var superchat = make(map[string]int)
	var membership = make([]string, 0, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		var items []string = strings.Split(sc.Text(), " ")
		if items[1] == "give" {
			// name give money !
			// name さんが money 円の superchat を送ったことを表す。
			var money, _ = strconv.Atoi(items[2])
			if _, ok := superchat[items[0]]; !ok {
				superchat[items[0]] = 0 // 新規アカウント
			}
			superchat[items[0]] += money
		} else if items[1] == "join" {
			// name join membership!
			// name さんがメンバーシップに加入したことを表す。
			membership = append(membership, items[0])
		}
	}
	// 結果出力

	// スーパーチャットソート
	var scList = make([]ScType, 0, len(superchat))
	for k := range superchat {
		var sc = ScType{Account: k, Money: superchat[k]}
		scList = append(scList, sc)
	}
	sort.Sort(ScList(scList))
	for _, sc := range scList {
		//fmt.Printf("%s %d\n", sc.Account, sc.Money)
		fmt.Println(sc.Account)
	}
	// メンバーシップソート
	sort.Strings(membership)
	for _, ms := range membership {
		fmt.Println(ms)
	}

	return
}
