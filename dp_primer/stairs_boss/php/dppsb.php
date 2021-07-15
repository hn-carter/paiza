<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「階段の上り方 3」
https://paiza.jp/works/mondai/dp_primer/dp_primer_stairs_boss
にphpでチャレンジした試行錯誤コードです。

作成環境
Ubuntu 20.04.2 LTS
PHP 7.4.3 (cli) (built: Jul  5 2021 15:13:35) ( NTS )
*/

// ●エントリーポイントはこのファイルの最後です

// 問題データ
class data {
    public int $n;  // 登る階段の段数
    public int $a;  // 1歩で登る段数
    public int $b;  // 1歩で登る段数
    public int $c;  // 1歩で登る段数
    // コンストラクタ
    public function __construct(int $n, int $a, int $b, int $c) {
        $this->n = $n;
        $this->a = $a;
        $this->b = $b;
        $this->c = $c;
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

// データ入力
// o 配列[0] data : 入力整数
//   配列[1]      : エラー内容文字列、正常ならnull
function inputData() {
    // 1 行で階段の段数n、1歩で登る段数a,bが与えられる
    $line1 = trim(fgets(STDIN));
    // 文字列を数値配列に変換 配列の最後にはエラー内容が返ってくる
    list($numbers1, $e) = toIntArray($line1);
    if (!is_null($e)) {
        // 数値変換に失敗
        $err = "1行目が不正です : ".$e;
        return [null, $err];
    }
    // 項目数チェック
    if (count($numbers1) != 4) {
        $err = "1行目が不正です[".$line1."]\n";
        return [null, $err];
    }
    // 同一チェック
    // ※array_unique は重複した値を取り除いた配列を返す
    //   元の配列と同一でない場合は重複データがあったと解釈できる
    $arr = array();
    for ($i = 1; $i < 4; $i++) {
        $arr[] = $numbers1[$i];
    }
    if ($arr !== array_unique($arr)) {
        $err = "1歩で登る段数に重複があります。[".substr($line1, strpos($line1, " ")+1)."]\n";
        return [null, $err];
    }
    // 範囲チェック
    if ($numbers1[0] < 1 || 30 < $numbers1[0]) {
        $err = "階段の段数が範囲外です。[".$numbers1[0]."]\n";
        return [null, $err];
    }
    $names = ["a", "b", "c"];
    for ($i = 0; $i < 3; $i++) {
        if ($numbers1[$i + 1] < 1 || 7 < $numbers1[$i + 1]) {
            $err = "1歩で登る段数".$names[$i]."が範囲外です。[".$numbers1[$i + 1]."]\n";
            return [null, $err];
        }
    }
    // データインスタンス作成
    $result = new data($numbers1[0], $numbers1[1], $numbers1[2], $numbers1[3]);

    return [$result, null];
}

// 問題を解く
// i $dt         : 入力データ
// o 配列[0] int : 処理結果
//   配列[1]     : エラー内容文字列、正常ならnull
function computeData($dt) {
    // 階段の段数毎に方法の数を保存する配列
    $dp = array();
    // 0 は 1
    $dp[] = 1;
    $steps = array();
    $steps[] = $dt->a;
    $steps[] = $dt->b;
    $steps[] = $dt->c;
    // 1から$nまでの答えを求める
    for ($i = 1; $i <= $dt->n; $i++) {
        // 配列の要素数追加
        $dp[] = 0;
        foreach ($steps as $val) {
            if ($i >= $val) {
                // a段下から1段上がる
                $dp[$i] += $dp[$i-$val];
            }
        }
    }
    return [$dp[$dt->n], null];
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