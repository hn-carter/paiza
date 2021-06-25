# このプログラムはpaizaラーニングの「クエリメニュー」内の「先頭の要素の削除(query)」
# という問題を解きます
# https://paiza.jp/works/mondai/query_primer/query_primer__multi_pop
# ただし、Python3初心者が勉強用に作成したものなので余分な処理があります
# Pythonにはdoctestというテストを行う機能が標準であるというので使ってみます
import sys

# キュー例外クラス
class QueueError(Exception):
    # コンストラクタ
    def __init__(self, message):
        self.message = message

# キュークラス
# Python3 にはqueue.Queueやcollections.dequeといったキュー構造が標準でありますが、
# doctestのために自作してみました
# 実装を簡略化するためバッファには固定サイズのリングバッファを使用しています
class Queue:
    # コンストラクタ
    # mazsize : 確保するバッファのサイズ(実際に使いたいサイズよりも1大きくすること)
    def __init__(self, maxsize):
        # クラスのインスタンス変数定義
        # 数列の要素数
        self.max_size = maxsize
        # データの格納に使う配列を初期化　リングバッファとして使う
        self.array = [0] * self.max_size
        # 次にデキュー(pop)する配列の添え字 先頭位置
        self.head = 0
        # 次にエンキュー(push)する配列の添え字 末尾位置+1
        self.tail = 0

    # isEmpty はバッファが空か判定する true : 空
    def isEmpty(self):
        # 値を取り出す位置[head]と、値を入れる位置[tail]が同じになる時は空となる
        # キューに「11」というデータが1つある状態で取り出すと
        #                                            head
        #              tail
        # 配列の添え字|  0  |  1  |  2  |  3  |  4  |  5  |
        # 格納データ  |  -  |  -  |  -  |  -  |  -  |  11 |
        # 上記の状態でデータを取り出す
        #              head
        #              tail
        # 配列の添え字|  0  |  1  |  2  |  3  |  4  |  5  |
        # 格納データ  |  -  |  -  |  -  |  -  |  -  |  -  |
        # と言うようにheadとtailは同じ位置を示す
        return (self.head == self.tail)

    # isFull はバッファが満杯か判定する true : 満杯
    def isFull(self):
        # 満杯と言うことは、次の次に追加する位置が取り出し位置になるということ
        # self.max_sizeで割る余りを求めている理由は、
        # キューに「11, 22, 33, 44, 55」という順にデータが満杯に設定されている場合
        #              head
        #                                            tail
        # 配列の添え字|  0  |  1  |  2  |  3  |  4  |  5  |
        # 格納データ  |  11 |  22 |  33 |  44 |  55 |  -  |
        # と言う状態になっている
        # maz_sizeが6なので
        # (kead)0 == ((tail)5 + 1) % 6    %はあまりを求める (5+1)%6 = 6%6 = 0
        #    0    ==        0
        # ※処理を単純化するため、要素は配列サイズの1つ少ない数のみ使用する
        #   フルに使用すると空と満杯が同じ状態になる
        #   フラグや-1等の特殊な値を使うのは処理が複雑になるため行わない
        return (self.head == (self.tail + 1) % self.max_size)

    # push はバッファの末尾に値を追加する
    def push(self, value):
        # バッファが満杯か確認し、満杯なら例外を投げる
        if self.isFull():
            raise QueueError('キューにこれ以上追加できません。')
        self.array[self.tail] = value
        # 次の追加位置の添え字を求める
        # リングバッファなので末尾に来たら0に戻る
        self.tail = (self.tail + 1) % self.max_size

    # pop はバッファの先頭から値を取り出す
    def pop(self):
        # バッファが空か確認し、空なら例外を投げる
        if self.isEmpty():
            raise QueueError('キューは空なので取り出せません。')
        result = self.array[self.head]
        # 次の取り出し位置の添え字を求める
        # リングバッファなので末尾に来たら0に戻る
        self.head = (self.head + 1) % self.max_size
        return result

    # dump はキューの中身を文字列で返す 一応デバッグ用に作成
    def dump(self):
        result = 'head=' + str(self.head) + ' tail=' + str(self.tail) + ' ['
        max = 0
        if self.head <= self.tail:
            max = self.tail - self.head
        else:
            max = self.max_size - self.head + self.tail
        for i in range(max):
            index = (self.head + i) % self.max_size
            result += str(self.array[index])
            if i != (max - 1):
                result += ', '
        result += ']'
        if self.isEmpty():
            result += ' isEmpty'
        if self.isFull():
            result += ' isFull'
        
        return result

    # paiza問題形式でキューに残っている内容を出力する
    def printQueue(self):
        max = 0
        if self.head <= self.tail:
            max = self.tail - self.head
        else:
            max = self.max_size - self.head + self.tail
        for i in range(max):
            index = (self.head + i) % self.max_size
            print(str(self.array[index]))

# 処理データクラス
class Data:
    # コンストラクタ
    def __init__(self, n, k):
        # クラスのインスタンス変数定義
        # 数列の要素数
        self.n = n
        # 与えられる入力の数
        self.k = k
        # キューは実装の都合上「必要数+1」で確保する
        # 要素A
        self.a = Queue(n + 1)
        # 処理S
        self.s = Queue(k + 1)

    # pushA は要素を一つ追加する
    def pushA(self, a):
        self.a.push(a)

    # pushS は処理を一つ追加する
    def pushS(self, s):
        self.s.push(s)

# inputData は処理対象データを読み込む
# o Data : 入力データを処理しやすい型で返す
def inputData():
    d = None
    # 1 行目では、配列 A の要素数 N と与えられる入力の数 K が与えられる
    line1 = input()
    items = line1.rstrip().split(' ')
    # 文字列配列を"List Comprehension"を使って数値配列に変換する
    try:
        numbers = [int(s) for s in items]
    except ValueError:
        # 数値変換例外
        print('[err] 1行目で数値変換失敗。', sys.exc_info(), file=sys.stderr)
        return None

    if 2 != len(numbers):
        print('[err] 1行目の入力データが不正です。[', line1, ']', file=sys.stderr)
        return None
    elif numbers[0] < 1 or 100000 < numbers[0]:
        print('[err] 要素数Nが範囲外です。[', line1, ']', file=sys.stderr)
        return None
    elif numbers[1] < 1 or 100000 < numbers[1]:
        print('[err] 入力の数Kが範囲外です。[', line1, ']', file=sys.stderr)
        return None
    else:
        # データクラス作成
        d = Data(numbers[0], numbers[1])

    # 要素読み込み
    for i in range(d.n):
        try:
            a = input()
            num = int(a)
            if num < 0 or 10000 < num:
                print('[err] 要素Aが範囲外です。[', a, ']', file=sys.stderr)
                return None
            else:
                # 要素を追加
                d.pushA(num)
        except ValueError:
            # 数値変換例外
            msg = '[err] {0}行目で数値変換失敗。[{1}]'.format(i+1, a)
            print('msg', sys.exc_info(), file=sys.stderr)
            return None

    # 操作読み込み
    for i in range(d.k):
        s = input()
        if s != 'pop' and s != 'show':
            print('[err] 操作Sが無効な内容です。[', s, ']', file=sys.stderr)
            return None
        else:
            # 操作を追加
            d.pushS(s)
    # 入力データを返す
    return d

# computeData は処理を行う
def computeData(d):
    # キューに登録された操作を全て行う
    while not d.s.isEmpty():
        operand = d.s.pop()
        if operand == 'pop':
            if not d.a.isEmpty():
                d.a.pop()
        elif operand == 'show':
            d.a.printQueue()

# outputData は処理結果を出力する
def outputData(d):
    # 結果の出力処理は無いので何もしない
    pass

# メイン処理関数
# テスト用に入力データを引数で受け取れるようにした
def main():
    # 処理データを読み込む
    d = inputData()
    if d is None:
        # 入力データが読み込めなかったのでここで異常終了コードを返して終了
        sys.exit(1)
    # データを処理する
    computeData(d)
    # 結果を出力する
    outputData(d)

###############################################################################
# ここからテストコード
# doctestでキューのテスト
# キューが空の場合のテスト
def test_queue_empty1():
    # doctestは"""で囲まれたdocstringにある実行例通りに動作するか検証する
    # この関数を実行するとprint文で'q.isEmpty()'の結果'True'と表示される
    # なので、docstringにそのまま記述すれば良い
    """
    >>> test_queue_empty1()
    True
    """
    q = Queue(5)
    print(q.isEmpty())

def test_queue_empty2():
    # この関数はreturnで結果'True'を返していて、実行するとその結果'True'が
    # 表示される
    # 画面表示同様に結果を記述する
    """
    >>> test_queue_empty2()
    True
    """
    q = Queue(5)
    q.push(1)
    q.push(2)
    q.pop()
    q.pop()
    return q.isEmpty()


# キューが満杯の場合のテスト
def test_queue_full1():
    """
    >>> test_queue_full1()
    True
    """
    # キューのバッファサイズは登録したい要素の最大数+1
    q = Queue(5)
    q.push(1)
    q.push(2)
    q.push(3)
    q.push(4)
    print(q.isFull())

# キューが満杯の場合のテスト
def test_queue_full2():
    """
    >>> test_queue_full2()
    True
    """
    q = Queue(4)
    q.push(1)
    q.push(2)
    q.push(3)
    q.pop()
    q.pop()
    q.pop()
    q.push(4)
    q.push(5)
    q.push(6)
    print(q.isFull())

def test_queue1():
    # doctestでテスト
    """
    >>> test_queue1()
    1
    2
    """
    q = Queue(4)
    q.push(1)
    q.push(2)
    print(q.pop())
    q.printQueue()

# リングバッファが1周
def test_queue2():
    """
    >>> test_queue2()
    5
    """
    q = Queue(4)
    q.push(1)
    q.push(2)
    q.pop()
    q.push(3)
    q.push(4)
    q.pop()
    q.push(5)
    q.pop()
    q.pop()
    q.printQueue()

# リングバッファが1周
def test_queue3():
    """
    >>> test_queue3()
    4
    5
    """
    q = Queue(4)
    q.push(1)
    q.push(2)
    q.pop()
    q.push(3)
    q.push(4)
    q.pop()
    q.push(5)
    q.pop()
    q.printQueue()

def test_pop1():
    """
    >>> test_pop1()
    1
    2
    3
    4
    5
    """
    q = Queue(4)
    q.push(1)
    print(q.pop())
    q.push(2)
    print(q.pop())
    q.push(3)
    print(q.pop())
    q.push(4)
    print(q.pop())
    q.push(5)
    print(q.pop())

def test_pop2():
    """
    >>> test_pop2()
    1
    2
    3
    4
    5
    6
    """
    q = Queue(4)
    q.push(1)
    q.push(2)
    q.push(3)
    print(q.pop())
    print(q.pop())
    print(q.pop())
    q.push(4)
    q.push(5)
    q.push(6)
    print(q.pop())
    print(q.pop())
    print(q.pop())

# 例外のテスト
def test_exception1():
    # 例外のテストをする場合も、正常ケースと同様に出力される結果をそのまま記述できる
    # ↓[ここから]
    # Traceback (most recent call last):
    #   File "C:\\Users\\Ohishi\\AppData\\Local\\Programs\\Python\\Python38\\lib\\doctest.py", line 1336, in __run
    #     exec(compile(example.source, filename, "single",
    #   File "<doctest __main__.test_exception1[0]>", line 1, in <module>
    #     test_exception1()
    #   File "multipop.py", line 307, in test_exception1
    #     print(q.pop())
    #   File "multipop.py", line 76, in pop
    #     raise QueueError('キューは空なので取り出せません。')
    # QueueError: キューは空なので取り出せません。
    # ↑[ここまで]
    # ファイルパスや行番号など変更されがちな情報が含まれるが、doctestは
    # トレースバックヘッダの後ろのトレースバックスタックを無視するのでソースを変更しても修正はいらない
    # ただ、実際に参照している先頭行と最後にある例外の詳細情報を残して省略した方が良い
    """
    >>> test_exception1()
    Traceback (most recent call last):
        ...
    QueueError: キューは空なので取り出せません。
    """
    q = Queue(4)
    print(q.pop())

def test_exception2():
    """
    >>> test_exception2()
    Traceback (most recent call last):
        ...
    QueueError: キューにこれ以上追加できません。
    """
    q = Queue(3)
    q.push(1)
    q.push(2)
    q.push(3)
    print(q.pop())
# キューのdoctestここまで

# ここからpaiza問題のテスト
def test_main1():
    """
    >>> test_main1()
    2410
    9178
    7252
    """
    # 入力例1
    d = Data(5, 3)
    d.pushA(7564)
    d.pushA(4860)
    d.pushA(2410)
    d.pushA(9178)
    d.pushA(7252)
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('show')
    # データを処理する
    computeData(d)
    # 結果を出力する
    outputData(d)

def test_main2():
    """
    >>> test_main2()
    1339
    4960
    3926
    9816
    3018
    4213
    9816
    3018
    4213
    """
    # 入力例2
    d = Data(10, 10)
    d.pushA(1005)
    d.pushA(2716)
    d.pushA(7856)
    d.pushA(8546)
    d.pushA(1339)
    d.pushA(4960)
    d.pushA(3926)
    d.pushA(9816)
    d.pushA(3018)
    d.pushA(4213)
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('show')
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('pop')
    d.pushS('show')
    d.pushS('pop')
    # データを処理する
    computeData(d)
    # 結果を出力する
    outputData(d)
    
# ここまでテストコード
###############################################################################

# エントリーポイント
# コマンドラインからスクリプトとして実行された場合に処理する
if __name__ == '__main__':
    # 以下の2行でテストを実行する
    # デフォルトではテスト結果が正常の場合、なにも出力されいなのでpaizaのジャッジも通過できる
    import doctest
    doctest.testmod()
    # これが本当の処理
    main()
