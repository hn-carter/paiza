# これはpaizaラーニングの「ハッシュメニュー応用編」-「ナンバープレートのハッシュ値」に
# Python3でチャレンジしたコードです。
# https://paiza.jp/works/mondai/hash_advanced/hash_advanced__number_plate
# 
# 作成環境
# Ubuntu 22.04.5 LTS
# Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]

# ナンバープレート情報を読み込みます
# Return: 読み込んだナンバープレート
def readNumberPlate():
    # 1 行目に地域名を表す文字列 s_1 が与えられます。
    s_1 = input().strip()
    # 2 行目に分類番号を表す整数 i_1 が与えられます。
    i_1 = int(input())
    # 3 行目にひらがなを表す文字列 s_2 が与えられます。
    s_2 = input().strip()
    # 4 行目に一連指定番号を表す整数 i_2 が与えられます。
    i_2 = int(input())

    return NumberPlate(s_1, i_1, s_2, i_2)

# 文字コード(ASCII)の和を返します
# Parameters:
#   str: 文字列
# Return: ASCIIコードの和
def sumString(str):
    result = sum([ord(i) for i in str])
    return result

# ナンバープレート
class NumberPlate:
    def __init__(self, s_1, i_1, s_2, i_2):
        # 地域名
        self.s_1 = s_1
        # 分類番号
        self.i_1 = i_1
        # ひらがな
        self.s_2 = s_2
        # 一連指定番号
        self.i_2 = i_2

    # ハッシュ値を返します
    # Return: ハッシュ値
    def hashValue(self):
        # (地域名の各文字の文字コードの和 * 分類番号 + ひらがなの各文字の文字コードの和 * 一連指定番号) % 1000
        is1 = sumString(self.s_1)
        is2 = sumString(self.s_2)
        result = (is1 * self.i_1 + is2 * self.i_2) % 1000
        return result    

# 入力
numberPlate = readNumberPlate()
# ハッシュ値を求める
hashValue = numberPlate.hashValue()
# 結果出力
print(hashValue)
