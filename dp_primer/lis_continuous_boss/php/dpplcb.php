<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「【連続列】最長減少連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_boss
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 問題データ
class data {
    public int $n;    // 人数
    public array $a;  // 身長
    // コンストラクタ
    public function __construct(int $n, array $a) {
        $this->n = $n;
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
    // 1行目に、横一列に並んでいる人の人数 n が与えられます。
    $line1 = trim(fgets(STDIN));
    list($n, $e) = toNumber($line1);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "1行目が不正です : ".$e;
        return [null, $err];
    }
    if ($n < 1 || 200000 < $n) {
        $err = "人数が範囲外です。[".$n."]\n";
        return [null, $err];
    }
    // 続く n 行のうち i 行目では、人 i の身長 a_i が与えられます。
    $a = array();
    for ($i = 0; $i < $n; $i++) {
        $line2 = trim(fgets(STDIN));
        list($num, $e2) = toNumber($line2);
        if (!is_null($e2)) {
            // 数値変換に失敗
            $err = ($i + 2)."行目が不正です : ".$e;
            return [null, $err];
        }
        if ($num < 100 || 200 < $num) {
            $err = ($i + 2)."行目の身長が範囲外です。[".$num."]\n";
            return [null, $err];
        }
        $a[] = $num;
    }
    // 取り込みデータインスタンス作成
    $result = new data($n, $a);

    return [$result, null];
}

// 問題を解く
// i $dt         : 入力データ
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($dt) {
    $dp = array();
    $dp[0] = 1;
    for ($i = 1; $i < $dt->n; $i++) {
        if ($dt->a[$i-1] >= $dt->a[$i]) {
            $dp[$i] = $dp[$i-1] + 1;
        } else {
            $dp[$i] = 1;
        }
    }
    return [max($dp), null];
}

// 結果を出力
function outputData($answer) {
    echo $answer."\n";
    return;
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