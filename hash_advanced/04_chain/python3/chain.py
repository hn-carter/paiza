# これはpaizaラーニングの「ハッシュメニュー応用編」-「ハッシュテーブルを使おう（チェイン法）」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__chain
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュ値を求める
# H(p) = (d の 1 文字目の文字コード * B^1 + d の 2 文字目の文字コード * B^2 + ... +
# d の m 文字目の文字コード * B^m) % mod
# B = 7、mod = 100、文字コード ASCII
# parameters
#   text 文字列
# return ハッシュ値
def hashFunction(text):
    total = 0
    for i in range(len(text)):
        total += ord(text[i]) * 7 ** (i + 1)
    return total % 100

# ハッシュテーブルをチェイン法で操作する

# ハッシュテーブル 2次元配列
hashTable = [[] for i in range(100)]
# 1 行目にクエリの数を表す整数 Q が与えられます。
q = int(input())
# 1 + i 行目に各クエリが与えられます。(1 ≦ i ≦ Q)
for i in range(q):
    items = input().split(' ')
    if items[0] == '1':
        # ハッシュテーブルにデータ d を格納する
        h = hashFunction(items[1])
        hashTable[h].append(items[1])
    elif items[0] == '2':
        # ハッシュテーブルの先頭から x 番目のデータを全て出力する
        # データがない場合は-1を出力する
        x = int(items[1]) - 1
        if len(hashTable[x]) > 0:
            print(" ".join(hashTable[x]))
        else:
            print(-1)
    elif items[0] == '3':
        # ハッシュテーブルのデータ d を削除する
        h = hashFunction(items[1])
        hashTable[h].remove(items[1])
