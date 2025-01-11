# これはpaizaラーニングの「ハッシュメニュー応用編」-「ログイン認証をしてみよう」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__certification
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ハッシュ関数
# H(p) = (p の 1 文字目の文字コード * B^1 + p の 2 文字目の文字コード * B^2 + ...
#  + p の m 文字目の文字コード * B^m) % mod
# B = 10^8+7, mod = 10^9+7, 文字コードは ASCII
# parameters
#   text 文字列
# return ハッシュ値(数値)
def hashFunction(text):
    B = 10 ** 8 + 7
    mod = 10 ** 9 + 7
    total = 0
    for i in range(len(text)):
        total += ord(text[i]) * B ** (i + 1) % mod
    return total % mod

# ログイン認証をしてみる

# 1 行目に組の数を表す整数 N と M が与えられます。
N, M = map(int, input().split(' '))
# i + 1 行目にデータベースで保管しているアカウント名を表す文字列 A_i と
# それに対応するパスワードのハッシュ値を表す整数 h_i が与えられます。
# (1 ≦ i ≦ N)
data = {} # アカウント名をキーとしてハッシュ値を保存する辞書
for i in range(N):
    A, h = input().split(' ')
    data[A] = int(h) # 数値文字列を数値に変換
# print(data)
# j + N + 1 行目にログイン認証を行うアカウント名を表す文字列 B_j と
# パスワードを表す文字列 p_j が与えられます。(1 ≦ j ≦ M)
for j in range(M):
    B, p = input().split(' ')
    hp = hashFunction(p)
    # print(hp)
    # アカウントが辞書にあるかチェック
    if B in data and data[B] == hp:
        print('Yes')
    else:
        print('No')
