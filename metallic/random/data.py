from ..array import MetallicArray
from ..connector import RandomOperation

import os

op = RandomOperation.alloc().init()

def rand(size=1):
    arr = MetallicArray(op.generateRandom_(size))
    return arr[0] if size == 1 else arr

def randn(size=1):
    arr = MetallicArray(op.generateRandomNormal_(size))
    return arr[0] if size == 1 else arr

def randint(low, high=None, size=1):
    if high is None:
        high = low
        low = 0

    if high < low:
        raise ValueError("high must be greater than low")

    arr = MetallicArray(op.generateRandomIntegers_high_size_(low, high, size))
    return arr[0] if size == 1 else arr

def random_integers(low, high=None, size=1):
    return randint(low, high, size)

def random_sample(size=1):
    return rand(size)

def random(size=1):
    return rand(size)

def ranf(size=1):
    return rand(size)

def sample(size=1):
    return rand(size)

def choice(arr, size=1, replace=True, p=None):
    result = op.generateRandomIntegers_high_size_replacement_(0, len(arr),
            size, replace)
    indices = MetallicArray(result)
    return [arr[int(i)] for i in indices]

def bytes(size):
    return os.urandom(size)
