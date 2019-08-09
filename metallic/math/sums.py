from ..connector import AccelerateOperation

def sum(arr):
   op = AccelerateOperation.alloc().init()
   return op.computeSumWithArray_(arr.array)
