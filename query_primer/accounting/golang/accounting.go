/*
これはpaizaラーニングの「クエリメニュー」から「経理」
https://paiza.jp/works/mondai/query_primer/query_primer__accounting
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

// 取引
type Account struct {
	// 部署名
	Unit string
	// 注文番号(文字列)
	OrderS string
	// 注文番号(数値) 数値として解釈できない場合-1
	Order int64
	// 金額
	Amount int
}

func NewAccount(a string, p string, m string) *Account {
	var ret = new(Account)
	// 文字列 -> int64変換
	var o, e = strconv.ParseInt(p, 10, 64)
	var am, _ = strconv.Atoi(m)
	ret.Unit = a
	ret.OrderS = p
	if e == nil {
		ret.Order = o
	} else {
		ret.Order = -1
	}
	ret.Amount = am
	return ret
}

// エントリーポイント
func main() {
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)
	// 1 行目では、部署の数 N と与えられる領収書の枚数 K が与えられます。
	sc.Scan()
	var items []string = strings.Split(sc.Text(), " ")
	var n, _ = strconv.Atoi(items[0])
	var k, _ = strconv.Atoi(items[1])
	// 続く N 行のうち、 i 行目では、i 番目に登録されている部署名 S_i が与えられます。
	var unitList = make([]string, n)
	for i := 0; i < n; i++ {
		sc.Scan()
		unitList[i] = sc.Text()
	}
	// 続く K 行のうち、 i 行目では、 i 枚目の領収書に書かれていた
	// 部署名 A_i , 注文番号 P_i , その金額 M_i が半角スペース区切りで与えられます。
	var acList = make(map[string][]*Account)
	for i := 0; i < k; i++ {
		sc.Scan()
		var aItems []string = strings.Split(sc.Text(), " ")
		var ac = NewAccount(aItems[0], aItems[1], aItems[2])
		// 取引を部署ごとの配列へ追加
		acList[aItems[0]] = append(acList[aItems[0]], ac)
	}
	// 結果出力
	for _, i := range unitList {
		var list = acList[i]
		fmt.Println(i)
		for _, a := range list {
			fmt.Printf("%s %d\n", a.OrderS, a.Amount)
		}
		fmt.Println("-----")
	}

	return
}
