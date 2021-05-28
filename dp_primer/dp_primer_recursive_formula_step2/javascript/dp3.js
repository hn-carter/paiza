"use strict";
/**
 * 特殊な２項間漸化式 1
 * エントリーポイント
 **/
main();

// 関数をfunction命令で定義した場合、巻き上げで定義前に使用することができる。
// エントリーポイントを先に持ってきたかったため。

/**
 * メイン関数
 */
function main() {

    try {
        // 入力
        const str = inputData();

        // 入力チェック
        const [x, d_1, d_2, k] = checkData(str);

        // 計算
        const result = runDpPrimerRecursiveFormula1(x, d_1, d_2, k);

        // 出力
        outputData(result);
    } catch(e) {
        // 標準エラー出力
        console.error(e.name);
        console.error(e.message);
    }
}

/**
 * 標準入力から読み込む
 * @return {String} 入力データ
 */
function inputData() {
    // 標準入力から
    const str = require("fs").readFileSync("/dev/stdin", "utf8");

    if (!str) {
        // 標準入力なし
        throw new Error("入力データがありません。");
    }
    
    return str;
}

/**
 * 入力文字列を項目に分割し、チェックを行う
 * @param {string} str 入力文字列データ
 * @return {number[4]} 項目毎に分割したデータ[x d_1 d_2 k]　エラーの場合はnullを返す
 */
function checkData(str) {
    const lines = str.split("\n");
    let result = [];
    if (lines && lines.length > 0) {
        const items = lines[0].split(" ");
        if (items.length != 4) {
            // 入力値の個数が誤っている
            throw new Error("入力された項目の数が4つではありません。");
        }
        for (let i = 0, len = items.length; i < len; i++) {
            const number = toInteger(items[i]);
            if (number === null) {
                // 整数ではない
                throw new Error("整数以外が入力されました:" + items[i]);
            }
            result.push(number);
        }
    } else {
        // 入力なし
        throw new Error("入力データが有効な文字列ではありません。" + lines);
    }

    // 範囲チェック
    if (result[0] < -1000 || 1000 < result[0]) {
        // x が範囲外
        throw new Error("入力 x:" + result[0] + "が範囲外です。");
    }
    if (result[1] < -1000 || 1000 < result[1]) {
        // d_1 が範囲外
        throw new Error("入力 d_1:" + result[1] + "が範囲外です。");
    }
    if (result[2] < -1000 || 1000 < result[2]) {
        // d_2 が範囲外
        throw new Error("入力x d_2" + result[2] + "が範囲外です。");
    }
    if (result[3] < 1 || 1000 < result[3]) {
        // k が範囲外
        throw new Error("入力 k:" + result[3] + "が範囲外です。");
    }

    return result;
}

/**
 * 特殊な２項間漸化式 1を求める
 * 次のように定められた数列の k 項目の値を出力してください。
 * ・ a_1 = x 
 * ・ a_n = a_{n-1} + d_1 (n が奇数のとき、n ≧ 3) 
 * ・ a_n = a_{n-1} + d_2 (n が偶数のとき)
 * @param {number} x 開始値
 * @param {number} d_1 奇数の場合の加算値
 * @param {number} d_2 偶数の場合の加算値
 * @param {number} k 最終値
 * @param {number} 処理結果 エラーの場合nullを返す
 */
function runDpPrimerRecursiveFormula1(x, d_1, d_2, k) {
    let a = [];
    a.push(x);
    for (let i = 2; i <= k; i++) {
        if (i % 2 === 1) {
            // 奇数
            // JavaScriptの配列は0始まりのため添字は-2する
            a.push(a[i-2] + d_1);
        } else {
            // 偶数
            a.push(a[i-2] + d_2);
        }
    }

    return a[k-1];
}

/**
 * 処理結果を標準出力へ出力する
 * @param {number} a_k 処理結果
 */
function outputData(a_k) {
    console.log(a_k.toString());
}

/**
 * 10進数文字列を数値に変換する
 * 数値型で渡された場合、整数部のみを返す
 * 10進数整数として変換できない場合はnullを返す
 * @param {string} str 10進数文字列
 * @return {number} 変換後数値
 */
function toInteger(str) {
    let result;
    if (typeof str === "string") {
        // 文字列型の場合、整数変換可能か判定
        if (isIntegerString(str)) {
            result = Number(str);
            if (isNaN(result)) {
                return null;
            }
        } else {
            return null;
        }
    } else if (typeof str === "number") {
        // 数値型の場合は小数点以下を切り捨てて返す
        result = Math.floor(str);
    } else {
        return null;
    }

    return result;
}

/**
 * 文字列が数値に変換可能か判定する
 * @param {string} str 判定対象の文字列 
 * @returns {boolean} true:数値文字列
 */
function isIntegerString(str) {
    // 正規表現で判定 RegExp
    // 正規表現リテラルは'/'スラッシュでくくる
    const p = /^[+|-]?[0-9]+$/;
    return p.test(str);
}
