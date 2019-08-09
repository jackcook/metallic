from ..array import MetallicArray
from ..connector import MetalOperation

from Foundation import NSArray

def _perform(arr, op, *args):
    op = MetalOperation.alloc().initWithOperation_(op)
    args = NSArray.alloc().initWithObjects_(arr.array, *args)
    return MetallicArray(op.computeWithArrays_(args))
