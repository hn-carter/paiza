/*
これはpaizaラーニングの「クエリメニュー」から「銀行」
https://paiza.jp/works/mondai/query_primer/query_primer__bank
にC++でチャレンジしたコードです。

作成環境
Ubuntu 20.04.2 LTS
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
*/
#include <iostream>
#include <map>
#include <string>
#include <vector>
using namespace std;

struct Company {
    // 会社名
    string Name;
    // 暗証番号
    int Pass;

    bool operator==(const Company& rhs) const {
        return Name == rhs.Name && Pass == rhs.Pass;        
    }
    bool operator<(const Company& rhs) const {
        return Name < rhs.Name || (Name == rhs.Name && Pass < rhs.Pass);
    }
};

// エントリーポイント
int main(void) {
    // 1 行目では、銀行に登録されている会社の数 N と行った取引の数 K が与えられます。
    int n, k;
    cin >> n >> k;
    // 続く N 行のうち、i 行目では、i 番目に登録されている会社名 C_i と
    // その口座の暗証番号 P_i と残高 D_i が与えられます。
    vector<Company> companyList(n);
    map<Company, long> account;
    string name;
    int pass;
    long value;
    for (int i = 0; i < n; ++i) {
        cin >> name >> pass >> value;
        Company key = {name, pass};
        companyList[i] = key;
        account[key] = value;
    }
    // 続く K 行のうち、i 行目では、i 回目の取引を行おうとした会社の名前 G_i と、
    // その人が言った暗証番号 M_i , 引出そうとした金額 W_i が与えられます。
    string g;
    int m;
    long w;
    for (int i = 0; i < k; ++i) {
        cin >> g >> m >> w;
        Company key = {g, m};
        if (account.count(key) > 0) {
            // 口座が存在したので残高計算
            account[key] -= w;
        }
    }
    // 結果出力
    for (Company i : companyList) {
        cout << i.Name << " " << account[i] << endl;
    }

    return 0;
}