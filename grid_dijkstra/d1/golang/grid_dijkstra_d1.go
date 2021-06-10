/*
これはpaizaラーニングの「グリッド版ダイクストラ問題セット」から「幅優先探索 - 迷路」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d1
にGo言語でチャレンジした試行錯誤コードです。
Go初心者が学習用に作ったコードなので本来は不要な処理があります。
*/

/*
問題の解き方はpaiza開発日誌「最短経路問題で頻出の「ダイクストラ法」とは？練習問題で徹底解説」
https://paiza.hatenablog.com/entry/2020/11/27/150000
の通りです。
盤面の位置は構造体で管理しています。
ただ構造体の使い方が不自然になっていますが、今はどうすれば良いのか分かりません。

構造体 Position　位置を表す
関数   func (p *Position) Equal(o *Position) bool　2つの位置が同一か判定する
       func (p *Position) Plus(o *Position) *Position　2つの位置を加算する

構造体 Board　盤面を表す
関数   func NewBoard(h int, w int) *Board　盤面を初期作成する
       func (b *Board) IsWall(p *Position) bool　位置が壁か判定する
	   func (b *Board) IsWithinRange(p *Position) bool　位置が盤面上か判定する
	   func (b *Board) BFS(s Position, g Position)　問題を解く　この問題のメイン
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

// 盤面の位置を表す構造体
type Position struct {
	// x は列 0〜W-1
	x int
	// y は行 0〜H-1
	y int
}

// Equal は盤面位置が同じか判定する
// Go言語は演算子オーバーロードできないのでEqual関数で代用する
// そもそもGo言語では構造体をこのように使うことが良くないのかもしれない
// わかりにくいがどうするのがGo言語で最善なのかわからない
func (p *Position) Equal(o *Position) bool {
	if o == nil {
		return false
	} else {
		return p.x == o.x && p.y == o.y
	}
}

// Plus は盤面位置を加算する　ただし、位置の範囲外チェックは行わない
// + のオーバーロードができないので関数定義した
func (p *Position) Plus(o *Position) *Position {
	if o == nil {
		return nil
	}
	// 加算した位置を生成し、返す
	// ここでは範囲外チェックは行わない
	var result Position = Position{x: p.x + o.x, y: p.y + o.y}
	return &result
}

// 盤面上の移動可能方向を定義する 右、上、左、下の4方向
// var定義だけど定数のように使うことにする
// 構造体配列の初期化方法はこれで良いのかな？
var MOVABLE_DIRECTION []Position = []Position{{x: 1, y: 0},
	{x: 0, y: -1},
	{x: -1, y: 0},
	{x: 0, y: 1}}

// Board は盤面を表す構造体
type Board struct {
	h    int     // h は盤面の行数
	w    int     // w は盤面の列数
	cell [][]int // cell はマス目の状態 0:通路 1:壁

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
	// 2次元sliceの初期化 [高さ][幅]
	result.cell = make([][]int, h)
	for i := range result.cell {
		result.cell[i] = make([]int, w)
	}
	// スタート時点のコスト初期化
	result.cost = 0

	return result
}

// IsWall は渡された位置が壁か判定する
// i p    : 盤面位置
// o bool : trueなら壁
func (b *Board) IsWall(p *Position) bool {
	if p == nil {
		return false
	}
	if 0 <= p.y && p.y < b.h &&
		0 <= p.x && p.x < b.w &&
		b.cell[p.y][p.x] == 1 {
		return true
	}
	return false
}

// IsWithinRange は渡された位置が盤面の範囲内か判定する
// i p    : 盤面位置
// o bool : trueなら範囲内
func (b *Board) IsWithinRange(p *Position) bool {
	if p == nil {
		return false
	}
	return 0 <= p.y && p.y < b.h && 0 <= p.x && p.x < b.w
}

// BFS は幅優先探索(Breadth First Search)
// i s     : スタート位置
//   g     : ゴール位置
func (b *Board) BFS(s Position, g Position) {
	// 未チェックの移動候補
	var open *list.List = list.New()
	// チェック済みのマス
	var closed map[*Position]bool = make(map[*Position]bool)
	// 処理開始位置にスタート地点を設定
	open.PushBack(&s)
	// 移動コスト
	var cost int = 1

	for true {
		// 移動先のマスを追加していくリスト
		var tmpQ *list.List = list.New()

		// 1つマスを移動する
		for open.Len() > 0 {
			// 未チェックの経路から先頭位置を取得(移動先マスを取得)
			var st *Position = open.Remove(open.Front()).(*Position)
			// ゴールに到着
			if st.Equal(&g) {
				b.cost = cost
				return
			}
			// 移動先が壁なら処理スキップ
			if b.IsWall(st) {
				continue
			}
			// 移動先がすでにチェック済みのマスなら処理スキップ
			// mapはキーのデータがなければ0を返す　0はbool値ではfalseを表す
			if closed[st] {
				continue
			}
			// ここの処理に来るということは移動先マスに移動することができるということ
			// 移動先マスを移動済みとして保存
			closed[st] = true
			// 次に移動するマスを追加する
			// 移動可能方向数分ループし、盤面の範囲外でなければ次の移動先としてリストに追加
			for _, p := range MOVABLE_DIRECTION {
				var destination *Position = st.Plus(&p)
				if b.IsWithinRange(destination) {
					tmpQ.PushBack(destination)
				}
			}
		}
		// 未チェックの移動候補を更新
		open = tmpQ
		// 1マス進んだ
		cost++
	}
}

// main はエントリーポイント
func main() {
	// データ入力
	var board, err1 = inputData()
	if err1 != nil {
		fmt.Fprintln(os.Stderr, err1)
		return
	}
	// 処理実行
	var err2 = computeData(board)
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

// inputData は処理に必要なデータを入力する処理
// 0 *Board : 盤面情報
//   error  : 処理続行不可なエラーが発生した場合に設定される
func inputData() (*Board, error) {
	// 標準入力のScanner
	var sc *bufio.Scanner = bufio.NewScanner(os.Stdin)

	// 1行目には盤面の行数を表す h , 盤面の列数を表す w が与えらる
	var ret bool = sc.Scan()
	if ret == false {
		return nil, errors.New("1行目が読み込めませんでした。")
	}
	var numbers1, err1 = convertNumArray(sc.Text())
	if err1 != nil || len(numbers1) != 2 {
		return nil, errors.New("1行目は不正な内容です。")
	}
	if numbers1[0] < 1 || 20 < numbers1[0] {
		return nil, errors.New(
			fmt.Sprintf("盤面の行数[%d]が範囲外です。", numbers1[0]))
	}
	if numbers1[1] < 1 || 20 < numbers1[1] {
		return nil, errors.New(
			fmt.Sprintf("盤面の列数[%d]が範囲外です。", numbers1[1]))
	}
	// 盤面の返却値を作成
	var board = NewBoard(numbers1[0], numbers1[1])

	// 2行目からのh行に盤面情報が与えられる
	// 盤面情報はスペース区切りの数字文字列になっている
	for i := 0; i < board.h; i++ {
		var ret bool = sc.Scan()
		if ret == false {
			return nil, errors.New(fmt.Sprintf(
				"[%d]行目が読み込めませんでした。", (i + 2)))
		}
		var line string = sc.Text()
		var numbers2, err2 = convertNumArray(line)
		if err2 != nil || len(numbers2) != board.w {
			return nil, errors.New(fmt.Sprintf(
				"[%d]行目は不正な内容です。[%s]", (i + 2), line))
		}
		for j := 0; j < board.w; j++ {
			if numbers2[j] < 0 || 1 < numbers2[j] {
				return nil, errors.New(fmt.Sprintf(
					"[%d]行目のマス情報が範囲外です。[%d]", (i + 2), numbers2[j]))
			}
			board.cell[i][j] = numbers2[j]
		}
	}

	return board, nil
}

// computeData は問題を解く
// i b     : 盤面情報
// o error : 処理続行不可なエラー発生時のみ返す
func computeData(b *Board) error {
	if b == nil {
		return errors.New("入力データがありません。")
	}

	// スタート位置
	var start Position = Position{x: 0, y: 0}
	//ゴール位置
	var goal Position = Position{x: b.w - 1, y: b.h - 1}
	b.BFS(start, goal)

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
