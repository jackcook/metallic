from ..array import MetallicArray
from ..connector import RandomOperation

def rand(size=1):
    op = RandomOperation.alloc().init()
    arr = MetallicArray(op.generateRandom_(size))

    if size == 1:
        return arr[0]
    else:
        return arr
