/*
これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
Go言語でチャレンジしたコードです。
https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate

作成環境
Ubuntu 22.04.5 LTS
go version go1.22.0 linux/amd64
*/
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

// ナンバープレート情報
type NumberPlate struct {
	// 地域名
	s_1 string
	// 分類番号
	i_1 int
	// ひらがな
	s_2 string
	// 一連指定番号
	i_2 int
}

// ハッシュ値を返します
// Return: ハッシュ値
func (numberPlate NumberPlate) hashValue() int {
	// (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
	var is1 int = sumString(numberPlate.s_1)
	var is2 int = sumString(numberPlate.s_2)
	var result int = (is1*numberPlate.i_1 + is2*numberPlate.i_2) % 1000
	return result
}

// 文字コード(ASCII)の和を返します
// Parameters:
//
//	str: 文字列
//
// Return: ASCIIコードの和
func sumString(str string) int {
	var result int = 0
	for _, c := range str {
		result += int(c)
	}
	return result
}

// ナンバープレート情報を読み込みます
// Return: 読み込んだナンバープレート
func readNumberPlate() NumberPlate {
	sc := bufio.NewScanner(os.Stdin)
	// 1 行目に地域名を表す文字列 s_1 が与えられます。
	sc.Scan()
	var s_1 string = sc.Text()
	// 2 行目に分類番号を表す整数 i_1 が与えられます。
	sc.Scan()
	var i_1, _ = strconv.Atoi(sc.Text())
	// 3 行目にひらがなを表す文字列 s_2 が与えられます。
	sc.Scan()
	var s_2 string = sc.Text()
	// 4 行目に一連指定番号を表す整数 i_2 が与えられます。
	sc.Scan()
	var i_2, _ = strconv.Atoi(sc.Text())

	return NumberPlate{s_1, i_1, s_2, i_2}
}

func main() {
	// 入力
	var numberPlate NumberPlate = readNumberPlate()
	// ハッシュ値を求める
	var hashValue int = numberPlate.hashValue()
	// 結果出力
	fmt.Println(hashValue)
	return
}
