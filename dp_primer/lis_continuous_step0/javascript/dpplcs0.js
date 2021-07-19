/*
これはpaizaラーニングの問題集にある「DPメニュー」-「最長増加連続部分列」
https://paiza.jp/works/mondai/dp_primer/dp_primer_lis_continuous_step0
にJavaScriptでチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
Node.js v14.17.2
*/

process.stdin.resume();
process.stdin.setEncoding('utf8');

var lines = [];
var reader = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});

reader.on('line', (line) => {
    lines.push(line);
});

reader.on('close', () => {
    // 人数 n
    let n = lines[0];
    // 身長 a_n
    var a = new Array(n);
    for (var i = 0; i < n; i++) {
        a[i] = lines[i+1];
    }
    // 動的計画法で問題を解く
    var dp = new Array(n);
    dp[0] = 1;
    for (var i = 1; i < n; i++) {
        if (a[i-1] <= a[i]) {
            dp[i] = dp[i-1] + 1;
        } else {
            dp[i] = 1;
        }
    }
    // 結果出力
    console.log(Math.max(...dp));
});