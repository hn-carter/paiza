/*
これはpaizaラーニングの「グリッド版ダイクストラ問題セット」から「グリッド上の移動」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d0
にGo言語でチャレンジした試行錯誤コードです。
Go初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

/*
問題の解き方はpaiza開発日誌「最短経路問題で頻出の「ダイクストラ法」とは？練習問題で徹底解説」
https://paiza.hatenablog.com/entry/2020/11/27/150000
の通りです。
Go言語の学習も兼ねているので、盤面情報を二次元配列に格納しているのはそのままですが
移動量はベクトル構造体を作成し、定数のように使っています。
移動経路は"container/list"をキューのように使用し盤面の移動処理を行っています。
*/

// プログラムはmainパッケージが初期化されmain関数から実行される
package main

// このプログラムで使用するパッケージ（ライブラリ）
// "bufio"          バッファリングされたI/Oを提供する
// "container/list" 双方向リスト(doubly linked list)を提供する
// "errors"         エラーを操作する関数を提供する
// "fmt"            Cのprintfやscanfに類似するフォーマットされたI/Oを提供する
// "os"             OSの機能をプラットフォームに依存しないインターフェースで提供する
// "strconv"        文字列を基本的なデータ型へ変換する
// "strings"        UTF-8文字列を操作する関数を提供する
import (
	"bufio"
	"container/list"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// ベクトルを表す構造体
type Vector struct {
	// x は列方向の移動量
	x int
	// y は行方向の移動量
	y int
}

// 2次元配列上の移動方向を定義する 右、上、左、下 var定義だけど定数のように使うことにします
// 構造体の定数などというものは無いみたいだ
// V_RIGHT は右へ移動するベクトル
var V_RIGHT Vector = Vector{x: 1, y: 0}

// V_UP は上へ移動するベクトル
var V_UP Vector = Vector{x: 0, y: -1}

// V_LEFT は左へ移動するベクトル
var V_LEFT Vector = Vector{x: -1, y: 0}

// V_DOWN は下へ移動するベクトル
var V_DOWN Vector = Vector{x: 0, y: 1}

// Board は盤面を表す構造体
type Board struct {
	h    int     // h は盤面の行数
	w    int     // w は盤面の列数
	cell [][]int // cell はマス目のコスト

	posY int // posY は現在の行位置
	posX int // posX は現在の列位置
	cost int // cost は現在まで移動したコスト
}

// NewBoard はBoard(盤面)のコンストラクタ
// i h      : 盤面の行数
//   w      : 盤面の列数
// o *Board : 初期化した盤面
func NewBoard(h int, w int) *Board {
	var result *Board = new(Board)
	result.h = h
	result.w = w
	// 2次元sliceの初期化
	result.cell = make([][]int, h)
	for i := range result.cell {
		result.cell[i] = make([]int, w)
	}
	// 初期位置は左上
	result.posX = 0
	result.posY = 0
	// スタート時点のコスト初期化
	result.cost = 0

	return result
}

// Move は盤面を移動し、コストを加算する
// 移動先が盤面の外になる場合は何も処理しません
func (b *Board) Move(v Vector) {
	var destinationY = b.posY + v.y
	var destinationX = b.posX + v.x
	// 盤面の外へは移動できない
	if 0 <= destinationY && destinationY < b.h &&
		0 <= destinationX && destinationX < b.w {
		b.cost += b.cell[destinationY][destinationX]
		// 現在位置を更新
		b.posY = destinationY
		b.posX = destinationX
	}
}

// main はエントリーポイント
func main() {
	// データ入力
	var board, travel, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var err2 = computeData(board, travel)
	if err2 != nil {
		fmt.Fprintln(os.Stderr, err2)
		return
	}
	// 結果出力
	var err3 = outputData(board)
	if err3 != nil {
		fmt.Fprintln(os.Stderr, err3)
		return
	}
	return
}

func inputData() (*Board, *list.List, error) {
	// 標準入力のScanner
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)

	// 1行目には盤面の行数を表す h , 盤面の列数を表す w が与えらる
	var ret bool = sc.Scan()
	if ret == false {
		return nil, nil, errors.New("1行目が読み込めませんでした。")
	}
	var numbers1, err1 = convertNumArray(sc.Text())
	if err1 != nil || len(numbers1) != 2 {
		return nil, nil, errors.New("1行目は不正な内容です。")
	}
	if numbers1[0] < 1 || 20 < numbers1[0] {
		return nil, nil, errors.New(
			fmt.Sprintf("盤面の行数[%d]が範囲外です。", numbers1[0]))
	}
	if numbers1[1] < 1 || 20 < numbers1[1] {
		return nil, nil, errors.New(
			fmt.Sprintf("盤面の列数[%d]が範囲外です。", numbers1[1]))
	}
	// 盤面の返却値を作成
	var board = NewBoard(numbers1[0], numbers1[1])

	// マス目のコストを読み込む
	for i := 0; i < board.h; i++ {
		var ret bool = sc.Scan()
		if ret == false {
			return nil, nil, errors.New(fmt.Sprintf(
				"[%d]行目が読み込めませんでした。", (i + 2)))
		}
		var line string = sc.Text()
		var numbers2, err2 = convertNumArray(line)
		if err2 != nil || len(numbers2) != board.w {
			return nil, nil, errors.New(fmt.Sprintf(
				"[%d]行目は不正な内容です。[%s]", (i + 2), line))
		}
		for j := 0; j < board.w; j++ {
			if numbers2[j] < 0 || 100 < numbers2[j] {
				return nil, nil, errors.New(fmt.Sprintf(
					"[%d]行目のコストが範囲外です。[%d]", (i + 2), numbers2[j]))
			}
			board.cell[i][j] = numbers2[j]
		}
	}

	// 移動経路を作成、listをキューのように使用する
	var travel *list.List = list.New()
	// 右、下、右、上、左　の順に移動する
	travel.PushBack(V_RIGHT)
	travel.PushBack(V_DOWN)
	travel.PushBack(V_RIGHT)
	travel.PushBack(V_UP)
	travel.PushBack(V_LEFT)

	return board, travel, nil
}

// computeData は問題を解く
// i b     : 盤面情報
//   t     : 移動情報
// o error : 処理続行不可なエラー発生時のみ返す
func computeData(b *Board, t *list.List) error {
	if b == nil || t == nil {
		return errors.New("入力データがありません。")
	}

	// リストの中身分移動処理を呼び出す
	for t.Len() > 0 {
		// キューのように先頭から取り出していく

		// Removeは削除した値を返す
		// 返却値は "interface{}" なので "変数.(型)" で型情報をつける
		// ※キャスト(型変換)ではないみたい
		b.Move(t.Remove(t.Front()).(Vector))
	}

	return nil
}

// outputData は処理結果を出力する
// i b     : 盤面情報
// o error : 処理続行不可なエラー発生時のみ返す
func outputData(b *Board) error {
	if b == nil {
		return errors.New("入力データがありません。")
	}
	fmt.Println(b.cost)
	return nil
}

// convertNumArray はスペース区切り文字列を数値配列に変換する
// i str     : 処理対象文字列
// o []int   : 結果数値配列 変換にできない場合は0がセットされる
//   []error : 変換に失敗した場合に返す
func convertNumArray(str string) ([]int, []error) {
	var items []string = strings.Split(str, " ")
	// Goは配列のサイズに変数を指定できない
	// なのでsliceに大きさを指定して作る
	var length int = len(items)
	var result []int = make([]int, length)
	// エラーをsliceで定義
	var err []error
	// 配列の個数分繰り返す iに0開始のループ回数、sに要素が入る
	for i, s := range items {
		// intに変換
		if num, e := strconv.Atoi(s); e == nil {
			// 変換成功
			result[i] = num
		} else {
			// sliceに追加
			err = append(err, errors.New(fmt.Sprintf(
				"[%d]番目 : [%s] 数値への変換に失敗しました。", (i+1), s)))
			result[i] = 0
		}
	}
	// エラー値はエラーがない場合はnilを返す
	if len(err) == 0 {
		return result, nil
	} else {
		return result, err
	}
}
