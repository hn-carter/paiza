/*
これはpaizaラーニングの「クエリメニュー」から「歴史を作る時間」
https://paiza.jp/works/mondai/query_primer/query_primer__history
にC++でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
*/
#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// エントリーポイント
int main(void) {
    // 1 行目では、グループの人数 N と歴史年表に載せる出来事の数 K が与えられます。
    int n, k;
    cin >> n >> k;
    // 続く N 行のうち i 行目では、 i 人目のメンバーの名前 S_i が与えられます。
    // ※この名前のリストは使わなくても解答できる
    vector<string> nameList(n);
    for (int i = 0; i < n; ++i) {
        cin >> nameList[i];
    }
    // 続く K 行のうち i 行目では、 i 個目の出来事の起こった年 Y_i と、
    // その記事を担当する生徒の名前 C_i が先頭から順に与えられます。
    vector<pair<long, string>> history(k);
    for (int i = 0; i < k; ++i) {
        cin >> history[i].first >> history[i].second;
    }
    // 年、名前をキーにソートする
    // pair のoperator< は1番目と2番目の項目をキーに比較する
    sort(history.begin(), history.end());

    // 結果出力
    for (pair<long, string> i : history) {
        cout << i.second << endl;
    }

    return 0;
}