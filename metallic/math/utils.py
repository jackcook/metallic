from ..array import MetallicArray
from ..connector import MetalOperation

from Foundation import NSArray

def _perform(arr, op, *args):
    op = MetalOperation.alloc().initWithOperation_(op)
    args = NSArray.alloc().initWithObjects_(arr.array, *[x.array for x in args])
    return MetallicArray(op.computeWithArrays_(args))