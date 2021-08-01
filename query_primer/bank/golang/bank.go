/*
これはpaizaラーニングの「クエリメニュー」から「銀行」
https://paiza.jp/works/mondai/query_primer/query_primer__bank
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

// 会社情報
type Company struct {
	// 会社名
	Name string
	// 暗証番号
	Pass int
}

// エントリーポイント
func main() {

	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、銀行に登録されている会社の数 N と行った取引の数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち、i 行目では、i 番目に登録されている
	// 会社名 C_i とその口座の暗証番号 P_i と残高 D_i が与えられます。
	// 口座情報
	var companyList = make([]Company, n)
	var account = make(map[Company]int)
	for i := 0; i < n; i++ {
		sc.Scan()
		var cItems []string = strings.Split(sc.Text(), " ")
		var p, _ = strconv.Atoi(cItems[1])
		var d, _ = strconv.Atoi(cItems[2])
		var key Company = Company{Name: cItems[0], Pass: p}
		companyList[i] = key // 出力順を確保
		account[key] = d     // 会社名、暗証番号をキーに残高を設定
	}
	// 続く K 行のうち、i 行目では、i 回目の取引を行おうとした会社の名前 G_i と、
	// その人が言った暗証番号 M_i , 引出そうとした金額 W_i が与えられます。
	for i := 0; i < k; i++ {
		sc.Scan()
		var gItems []string = strings.Split(sc.Text(), " ")
		var m, _ = strconv.Atoi(gItems[1])
		var w, _ = strconv.Atoi(gItems[2])
		var key Company = Company{Name: gItems[0], Pass: m}
		// 一致する口座があれば引き下ろす
		if d, ok := account[key]; ok {
			d -= w
			account[key] = d
		}
	}

	// 結果出力
	for _, i := range companyList {
		fmt.Printf("%s %d\n", i.Name, account[i])
	}

	return
}
