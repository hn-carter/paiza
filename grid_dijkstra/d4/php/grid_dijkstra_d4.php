<?php
/*
これはpaizaラーニングの「グリッド版ダイクストラ問題セット」から
「問題4: 拡張ダイクストラ - コストを0にできるチケット」
https://paiza.jp/works/mondai/grid_dijkstra/grid_dijkstra__d4
にphpでチャレンジした試行錯誤コードです。
問題文では最小コストの出力のみが求められていますが、確認のために通過経路を
表示する処理が含まれています。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )

関数のエラー処理は例外を使用せずに配列を使用しています
関数の戻り値を配列にして、最後の項目にエラー内容を設定して返し、呼び出し側は
最後の項目がnullでない場合はエラーと判断しエラーメッセージを出力するようにしています

position   位置・ベクトルクラス  盤面の位置や移動方向の定義に使用
route      通過経路  通過位置の管理と0チケットの使用状況を管理
                     マスがすでに通過したかどうかの判定も行う
pqRoute    優先度付きキュー  SplPriorityQueueを継承してルートの優先順位判定に使用
board      盤面              盤面のサイズ、マスごとのコスト、0チケットの枚数を管理
dijkstra   ダイクストラ法で問題を解く関数
toNumber   文字列を数値に変換
toIntArray スペース区切りの数値データ文字列を数値配列に変換
*/

// ●エントリーポイントはこのファイルの最後です

// 位置・ベクトルクラス
class position {
    // php7.4からプロパティ宣言に型指定ができるようになりました
    public int $x;
    public int $y;
    // コンストラクタ
    public function __construct(int $x = 0, int $y = 0) {
        $this->x = $x;
        $this->y = $y;
    }

    // 位置を加算した新しい位置を返す
    public function add(position $p) {
        $x = $this->x + $p->x;
        $y = $this->y + $p->y;
        return new position($x, $y);
    }

    // 位置が等しいか判定する
    public function equal(position $p) {
        return ($this->x == $p->x && $this->y == $p->y);
    }
}

// 通過経路
class route {
    // 現在位置
    public position $pos;
    // 現在地までのコスト
    public int $cost;
    // 残りチケット枚数
    public int $ticket;
    // 直前の通過経路 route か null
    public $route;
    // コンストラクタ
    // i $p : 現在位置
    //   $c : 現在地までのコスト
    //   $t : 残りチケット枚数
    //   $r : 直前の通過経路
    //        PHPはオブジェクト変数の値に含まれるのはオブジェクトIDのみで、
    //        オブジェクト自身は含まれません。
    //        オブジェクトIDを用いて実際のオブジェクトにアクセスします。
    public function __construct(position $p, int $c, int $t, $r) {
        $this->pos = $p;
        $this->cost = $c;
        $this->ticket = $t;
        $this->route = $r;
    }
    // 重複判定用のキーを返す
    public function getKey() {
        // 判定には位置他に、使った0チケット枚数を含める
        return ($this->pos->x * 2**16 + $this->pos->y * 2**8 + $this->ticket);
    }
}

// phpの優先度付きキュー
class pqRoute extends SplPriorityQueue{
    // キューの優先度を判定する関数
    public function compare($priority1, $priority2) {
        // コストが最小になる経路を優先する
        return $priority2 - $priority1;
    }
}

// 盤面クラス
class board {
    // 盤面の行数
    public int $height;
    // 盤面の列数
    public int $width;
    // マスごとのコスト 二次元配列[x][y]
    public array $cost;
    // チケットの枚数
    public int $ticket;
    // コンストラクタ
    public function __construct(int $h, int $w, int $t = 0) {
        $this->height = $h;
        $this->width = $w;
        $this->cost = array_fill(0, $w, array_fill(0, $h, 0));
        $this->ticket = $t;
    }

    // getCostは指定位置のコストを返す
    // i position $p : コストを求めたい位置
    // o int         : マスのコスト
    public function getCost(position $p) {
        if ($this->isWithinRange($p)) {
            return $this->cost[$p->x][$p->y];
        }
        return -1;
    }
    // isWithinRange は指定位置が範囲内か判定する
    // i position $p : 求めたい位置
    // o Booleand    : True 範囲内
    public function isWithinRange(position $p) {
        if ($p->x < 0 || $this->width <= $p->x ||
            $p->y < 0 || $this->height <= $p->y) {
            return False;
        }
        return True;
    }
}

// ダイクストラ法で問題を解く
// i position $s : スタート位置
//   position $g : ゴール位置
//   board $b    : 盤面情報
// 0 route       : 経路 ゴールへたどり着けない場合nullを返す
function dijkstra(position $s, position $g, board $b) {
    // 盤面上の移動可能方向を定義する 右、上、左、下の4方向
    $MOVABLE_DIRECTION = [
        new position(1, 0),
        new position(0, -1),
        new position(-1, 0),
        new position(0, 1)];

    // これからチェックするマス
    $open = new pqRoute();
    // チェック済みのマス
    $closed = array();
    // スタート
    $startRoute = new route($s, $b->getCost($s), $b->ticket, null);
    $open->insert($startRoute, $b->getCost($s));
    $now = null;    // 処理中の経路
    while (!$open->isEmpty()) {
        $now = $open->extract();
        // ゴールに到達終了
        if ($g->equal($now->pos)) {
            return $now;
        }
        // すでにチェック済みなら処理をパス
        if (array_key_exists($now->getKey(), $closed)) {
            continue;
        }
        // 現在位置をチェック済みに追加
        $closed[$now->getKey()] = True;
        // 次に移動するマスを追加する
        foreach($MOVABLE_DIRECTION as $move) {
            $nextPos = $move->add($now->pos);
            if ($b->isWithinRange($nextPos)) {
               // 0チケットを使わないで進む
               $nextCost = $now->cost + $b->getCost($nextPos);
               $nextRoute = new route($nextPos, $nextCost, $now->ticket, $now);
               $open->insert($nextRoute, $nextCost);
               if ($now->ticket > 0) {
                   // 0チケットを使用して進む
                   $nextRouteTicket = new route($nextPos, $now->cost, $now->ticket-1, $now);
                   $open->insert($nextRouteTicket, $now->cost);
               }
            }
        }
    }
    // ここに来るということはゴールできなかったということ
    return null;
}

// toNumber は文字列を数値に変換する
// i $str    : 処理文字列
// o 配列[0] : 変換後数値
//   配列[1] : エラー内容文字列、正常ならnull
function toNumber($str) {
    $num = 0;
    $err = null;
    // 文字列が整数で構成されているか正規表現でチェック
    if (preg_match("/^[0-9]+$/", $str)) {
        // 数値に変換
        $num = intval($str);
    } else {
        $err = "数字ではありません:[".$str."]\n";
    }
    return [$num, $err];
}

// toIntArray スペース区切りの文字列を数値配列に変換する
// i $str          : 処理文字列
// o 配列[0] int[] : 数値配列
//   配列[1]       : エラー内容文字列、正常ならnull
function toIntArray($str) {
    // スペースで分割
    $items = explode(" ", $str);
    $result = array();
    $err = null;
    foreach ($items as $s) {
        // 数値変換 2つ返ってくる
        list($num, $e) = toNumber($s);
        if (is_null($e)) {
            $result[] = $num;
        } else {
            // 数値変換に失敗
            $err = $e;
            break;
        }
    }
    return [$result, $err];
}

// inputData は入力データを取り込む
// o 配列[0] board : 盤面情報
//   配列[1]       : エラー情報、正常の場合null
function inputData() {
    // 戻り値の定義
    $board = null;  // 盤面
    $err = null;    // エラー情報
    /////////////////////////////////////////////////////////////////////
    // 1 行目には盤面の行数を表す h , 盤面の列数を表す w が与えられます。
    $line1 = trim(fgets(STDIN));
    // 文字列を数値配列に変換 配列の最後にはエラー内容が返ってくる
    list($numbers1, $e) = toIntArray($line1);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "1行目が不正です : ".$e;
        return [null, $err];
    }
    // 項目数チェック
    if (count($numbers1) != 2) {
        $err = "1行目が不正です[".$line1."]\n";
        return [null, $err];
    }
    // 範囲チェック
    if ($numbers1[0] < 1 || 20 < $numbers1[0]) {
        $err = "盤面の行数が範囲外です。[".$numbers1[0]."]\n";
        return [null, $err];
    }
    if ($numbers1[1] < 1 || 20 < $numbers1[1]) {
        $err = "盤面の列数が範囲外です。[".$numbers1[1]."]\n";
        return [null, $err];
    }
    // 盤面インスタンス作成
    $board = new board($numbers1[0], $numbers1[1]);
    /////////////////////////////////////////////////////////////////////
    // 続く h 行の各行では i 行目 (0 ≦ i < h) には、盤面が与えられます。
    // t_{i,j} は i 行目の j 列目のコストです。
    for ($i = 0; $i < $board->height; $i++) {
        $line2 = trim(fgets(STDIN));
        // 文字列を数値配列に変換
        list($numbers2, $e) = toIntArray($line2);
        if (!is_null($e)) {
            // 数値変換に失敗
            $err = ($i+1)."行目が不正です : ".$e;
            return [null, $err];
        }
        // 項目数チェック
        if (count($numbers2) != $board->width) {
            $err = ($i+1)."行目が不正です[".$line2."]\n";
            return [null, $err];
        }
        // 範囲チェック
        for ($j = 0; $j < $board->width; $j++) {
            if ($numbers2[$j] < 0 || 100 < $numbers2[$j]) {
                $err = ($i+1)."行目のコストが範囲外です。[".$numbers2[$j]."]\n";
                return [null, $err];
            }
            // 盤面データにコストを設定
            $board->cost[$j][$i] = $numbers2[$j];
        }
    }
    ////////////////////////////////////////////////
    // 最後の行ではチケットの枚数 n が与えられます。
    $line3 = trim(fgets(STDIN));
    list($t, $e) = toNumber($line3);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "チケット枚数が不正です : ".$e;
        return [null, $err];
    }
    // 範囲チェック
    if ($t < 0 || 20 < $t) {
        $err = "チケット枚数が範囲外です[".$t."]\n";
        return [null, $err];
    }
    // 盤面データに設定
    $board->ticket = $t;

    return [$board, null];
}

// computeData は問題を解く
// i $b : 盤面情報
// o 配列[0] route : 答え
//   配列[1]       : エラー情報、正常の場合null
function computeData(board $b) {
    $start = new position(0, 0);
    $goal = new position($b->width - 1, $b->height - 1);
    $result = dijkstra($start, $goal, $b);
    return $result;
}

// outputData は結果を出力する
// i $r : 経路
function outputData(route $r) {
    echo $r->cost."\n";
}

// outputRoute は今まで通ってきたルートを出力する
// paiza問題では要求されていないが、確認用に作成した
function outputRoute(route $r, board $b) {
    $here = $r;
    // 0チケット使用確認用
    $prevTicket = $here->ticket;
    // 通過経路表示用変数
    $track = array_fill(0, $b->width, array_fill(0, $b->height, " "));
    while (!is_null($here)) {
        $footprint = "*";
        if (!is_null($here->route) && $here->route->ticket != $prevTicket) {
            // 0チケット使用
            $prevTicket = $here->route->ticket;
            $footprint = "T";
        }
        $track[$here->pos->x][$here->pos->y] = $footprint;
        $here = $here->route;
    }
    // 通過経路出力
    for ($y = 0; $y < $b->height; $y++) {
        for ($x = 0; $x < $b->width; $x++) {
            echo $track[$x][$y];
            echo $b->cost[$x][$y];
        }
        echo "\n";
    }
}

// メイン関数
function main() {
    // 入力データ取り込み
    list($board, $err) = inputData();
    if (!is_null($err)) {
        echo $err;
        exit(1);
    }
    // 問題を解く
    $route = computeData($board);
    if (is_null($route)) {
        echo "ゴールにたどり着けませんでした。\n";
        exit(1);
    }
    // 結果出力
    outputData($route);
    // たどった道筋を出力する
    // paiza問題では不要なためコメントアウトしている
    // 必要に応じてコメントを外す
    //outputRoute($route, $board);

    return;
}

// エントリポイント
main();