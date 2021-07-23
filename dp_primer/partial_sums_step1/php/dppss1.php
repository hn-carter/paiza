<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「部分和問題 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_partial_sums_step1
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 問題データ
class data {
    public int $n;    // 重りの個数
    public int $x;    // 重さの和
    public array $a;  // 重り
    // コンストラクタ
    public function __construct(int $n, int $x, array $a) {
        $this->n = $n;
        $this->x = $x;
        $this->a = $a;
    }
}

// toNumber は文字列を数値に変換する
// i $str    : 処理文字列
// o 配列[0] : 変換後数値
//   配列[1] : エラー内容文字列、正常ならnull
function toNumber($str) {
    $num = 0;
    $err = null;
    // 文字列が9桁までの整数で構成されているか正規表現でチェック
    if (preg_match("/^[0-9]{1,9}$/", $str)) {
        // 数値に変換
        $num = intval($str);
    } else {
        $err = "数字ではありません:[".$str."]\n";
    }
    return [$num, $err];
}

// データ入力
// o 配列[0] data : 取り込みデータ
//   配列[1]      : エラー内容文字列、正常ならnull
function inputData() {
    // 1行目に、おもりの個数 n と目標とする重さの和 x が半角スペース区切りで与えられます。
    $line1 = trim(fgets(STDIN));
    $items = explode(" ", $line1);
    if (count($items) != 2) {
        // データの個数が不正
        $err = "1行目が不正です。[".$line1."]";
        return [null, $err];
    }
    // 重りの個数
    list($n, $e) = toNumber($items[0]);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "重りの個数が不正です : ".$e;
        return [null, $err];
    }
    if ($n < 1 || 100 < $n) {
        $err = "重りの個数が範囲外です。[".$n."]\n";
        return [null, $err];
    }
    // 目標重量
    list($x, $e) = toNumber($items[1]);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "目標重量が不正です : ".$e;
        return [null, $err];
    }
    if ($x < 1 || 1000 < $x) {
        $err = "目標重量が範囲外です。[".$x."]\n";
        return [null, $err];
    }
    // 続く n 行のうち i 行目では、おもり i の重さ a_i が与えられます。
    $a = array();
    for ($i = 0; $i < $n; $i++) {
        $line2 = trim(fgets(STDIN));
        list($num, $e2) = toNumber($line2);
        if (!is_null($e2)) {
            // 数値変換に失敗
            $err = ($i + 2)."行目が不正です : ".$e;
            return [null, $err];
        }
        if ($num < 1 || 100 < $num) {
            $err = ($i + 2)."行目の重りの重さが範囲外です。[".$num."]\n";
            return [null, $err];
        }
        $a[] = $num;
    }
    // 取り込みデータインスタンス作成
    $result = new data($n, $x, $a);

    return [$result, null];
}

// 問題を解く
// i $dt         : 入力データ
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($dt) {
    // 答えとなる組み合わせ数
    $counter = 0;
    // 重さを添字とした配列$dpを初期化する
    $dp = array_fill(0, $dt->x + 1, 0);
    // おもりを選ばなければ、重さの和を0とすることができる
    $dp[0] = 1;
    // おもり i までのおもりを使って
    for ($i = 0; $i < $dt->n; $i++) {
        // 重さの和を j とすることができるか？
        // 大きい方から逆にループしないと複数の重りを組み合わせたときに正しく計算できない
        for ($j = $dt->x; $j >= $dt->a[$i]; $j--) {
            // 配列が求めたい重さ j から 追加する重さ a_i を引いたときに
            // 作れる重さならカウント
            if ($dp[$j - $dt->a[$i]] > 0) {
                $dp[$j] = ($dp[$j] + $dp[$j - $dt->a[$i]]) % 1000000007;
            }
        }
    }
    return [$dp[$dt->x], null];
}

// 結果を出力
function outputData($answer) {
    echo $answer."\n";
}

// メイン処理
function main() {
    try {
        list($dt, $err1) = inputData();
        if (!is_null($err1)) {
            echo $err1;
            exit(1);
        }
        list($answer, $err2) = computeData($dt);
        if (!is_null($err2)) {
            echo $err2;
            exit(1);
        }
        outputData($answer);
    } catch(Exception $e) {
        echo $e->getMessage()."\n";
    }
}

// エントリーポイント
main();