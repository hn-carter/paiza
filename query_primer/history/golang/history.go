/*
これはpaizaラーニングの「クエリメニュー」から「歴史を作る時間」
https://paiza.jp/works/mondai/query_primer/query_primer__history
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

// データ
type Assignment struct {
	// 出来事の起こった年
	Year int
	// 担当する生徒の名前
	Name string
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、グループの人数 N と歴史年表に載せる出来事の数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち i 行目では、 i 人目のメンバーの名前 S_i が与えられます。
	var names = make([]string, k)
	for i := 0; i < n; i++ {
		sc.Scan()
		names[i] = sc.Text()
	}
	// 続く K 行のうち i 行目では、 i 個目の出来事の起こった年 Y_i と、
	// その記事を担当する生徒の名前 C_i が先頭から順に与えられます。
	var history []Assignment = make([]Assignment, k)
	for i := 0; i < k; i++ {
		sc.Scan()
		var assignmentItems []string = strings.Split(sc.Text(), " ")
		var y, _ = strconv.Atoi(assignmentItems[0])
		history[i] = Assignment{Year: y, Name: assignmentItems[1]}
	}
	// 年、名前の順にソートする
	sort.Slice(history[:], func(i, j int) bool {
		if history[i].Year == history[j].Year {
			return history[i].Name < history[j].Name
		} else {
			return history[i].Year < history[j].Year
		}
	})
	// 結果出力
	for _, i := range history {
		fmt.Println(i.Name)
	}

	return
}
