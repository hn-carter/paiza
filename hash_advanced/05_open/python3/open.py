# これはpaizaラーニングの「ハッシュメニュー応用編」-「ハッシュテーブルを使おう（オープンアドレス法）」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__open
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュ関数で使用する定数
B = 997
mod = 1000
# ハッシュテーブル 配列
hashTable = [""] * mod

# ハッシュ値を求める
# H(p) = (d の 1 文字目の文字コード * B^1 + d の 2 文字目の文字コード * B^2 + ... +
# d の m 文字目の文字コード * B^m) % mod
# B = 997、mod = 1000、文字コード ASCII
# parameters
#   text 文字列
# return ハッシュ値
def hashFunction(text):
    total = 0
    for i in range(len(text)):
        total += ord(text[i]) * B ** (i + 1)
    return total % mod

# ハッシュテーブルにデータを追加する
# parameters
#   text 文字列
# return なし
def addData(text):
    global hashTable
    h = hashFunction(text)
    endPos = h
    while hashTable[h] != "":
        h += 1
        if h >= mod:
            h = 0
        if endPos == h:
            # ハッシュテーブルが満杯で追加できない
            return
    hashTable[h] = text

# ハッシュテーブルにデータがあるか検索する
# parameters
#   text 文字列
# return ハッシュテーブルの位置 1からmod ない場合は -1
def existsData(text):
    h = hashFunction(text)
    endPos = h
    while hashTable[h] != text:
        h += 1
        if h >= mod:
            h = 0
        if endPos == h:
            h = -1
            break
    return h + 1

# ハッシュテーブルをオープンアドレス法で操作する

# 1 行目にクエリの数を表す整数 Q が与えられます。
Q = int(input())
# 1 + i 行目に各クエリが与えられます。(1 ≦ i ≦ Q)
for i in range(Q):
    items = input().split(' ')
    if items[0] == '1':
        # ハッシュテーブルにデータ d を格納する
        addData(items[1])
    elif items[0] == '2':
        # ハッシュテーブルにデータ d が格納されているか調べ
        # 存在するなら先頭から何番目かを出力
        # ない場合は-1を出力する
        print(existsData(items[1]))
