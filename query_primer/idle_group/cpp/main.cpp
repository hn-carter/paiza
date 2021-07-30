/*
これはpaizaラーニングの「クエリメニュー」から「アイドルグループ」
https://paiza.jp/works/mondai/query_primer/query_primer__idle_group
にC++でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
*/
#include <iostream>
#include <set>
#include <string>
#include <vector>
using namespace std;

// 文字列をスペースで分割する
vector<string> splitString(string str) {
    // 結果
    vector<string> result = vector<string>();
    size_t offset = string::size_type(0);
    while (true) {
        // 区切り文字の位置を検索
        size_t pos = str.find(" ", offset);
        if (pos == string::npos) {
            result.push_back(str.substr(offset));
            break;
        }
        // 検索開始位置から区切り文字の位置まで切り取り
        result.push_back(str.substr(offset, pos - offset));
        offset += pos + 1;
    }
    return result;
}

// エントリーポイント
int main(void) {
    // 1 行目では、アイドルグループの初期メンバー数 N とイベントの回数 K が与えられます。
    int n, k;
    cin >> n >> k;
    // 続く N 行では、N 人の初期メンバーの名前が与えられます。
    set<string> nameList;
    string name;
    for (int i = 0; i < n; i++) {
        cin >> name;
        nameList.insert(name);
    }
    // 続く K 行では、起こったイベントを表す文字列が時系列順に与えられます。
    cin.clear();
    cin.ignore(1000, '\n'); // getlineを使うため現在までの入力状態をクリア
    vector<string> event(k, "");
    for (int i = 0; i < k; i++) {
        getline(cin, event[i]);
    }

	// イベントを実施
	for (string e : event) {
        vector<string> eItems = splitString(e);
        if (eItems[0] == "join") {
            // "join name" name という名前のアイドルが加入することを表す。
            nameList.insert(eItems[1]);
        } else if (eItems[0] == "leave") {
            // "leave name" name という名前のアイドルが脱退することを表す。
            nameList.erase(eItems[1]);
        } else if (eItems[0] == "handshake") {
            // "handshake" 握手会が行われることを表す。
            for (string nameItr : nameList) {
                cout << nameItr << endl;
            }
        }
    }

    return 0;
}