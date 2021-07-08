<?php
/*
これはpaizaラーニングの問題集にある「DPメニュー」-「特殊な2項間漸化式 2」
https://paiza.jp/works/mondai/dp_primer/dp_primer_recursive_formula_step3
にphpでチャレンジした試行錯誤コードです。
*/

// ●エントリーポイントはこのファイルの最後です

// phpには構造体は無いのでクラスを使用する
// 処理対象データ
class data {
    public $x = 0;          // 数列の初項
    public $d_1 = 0;        // 公差1
    public $d_2 = 0;        // 公差2
    public $q = 0;          // 入力の行数
    public $k_n = array();  // 入力
}

// convertArray は半角スペース区切りの文字列を配列に変換する
// i $str : 処理対象文字列
// o      : 結果配列
function convertArray($str) {
    $line = str_replace(array("\r\n", "\r", "\n"), '', $str);
    // 文字列をスペースで区切り配列で返す
    $result = explode(" ", $line);
    return $result;
}

// inputData は標準入力から読み込む
// o data : 取り込みデータをdataクラスで返す
function inputData() {
    $result = new data();
    // 1行目では、数列の初項 x と公差 d_1, d_2 が与えられます。
    $items1 = convertArray(trim(fgets(STDIN)));
    $result->x = $items1[0];
    $result->d_1 = $items1[1];
    $result->d_2 = $items1[2];
    // 2行目では、3行目以降で与えられる入力の行数 Q が与えられます。
    $result->q = trim(fgets(STDIN));
    // 続く Q 行のうち i 行目では、k_i が与えられます。
    for ($i = 0; $i < $result->q; $i++) {
        // PHPでは[]で配列に追加できる
        $result->k_n[] = trim(fgets(STDIN));
    }
    return $result;
}

// getNumber は指定位置の数値を返す
// i   $d     : 入力データ
//     $i     : 取り出したい位置
// i/o &$nums : 数列[0-]　※過去の計算データを使い回す
// o          : 数列から取り出した値
function getNumber($d, $i, &$nums) {
    // 不足していたら計算
    if ($i > count($nums)) {
        for ($j = count($nums); $j < $i; $j++) {
            if (($j+1) % 2 == 1) {
                // 奇数
                $nums[] = $nums[$j - 1] + $d->d_1;
            } else {
                // 偶数
                $nums[] = $nums[$j - 1] + $d->d_2;
            }
        }
    }
    return $nums[$i - 1];
}

// computeData は問題を解く
// i $d : 処理データ
function computeData($d) {
    $numbers = array(); // 計算した数列
    $numbers[] = $d->x;
    for ($i = 0; $i < $d->q; $i++) {
        $num = getNumber($d, $d->k_n[$i], $numbers);
        print "$num\n";
    }
}

// メイン
function main()
{
    // データを読み込む
    $data = inputData();

    // 処理を行う
    computeData($data);

    // 処理完了
    // 問題文で結果の出力は求められていないためコメントアウト
    // outputData($sorted);
}

// エントリーポイント
main();