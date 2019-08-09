from .connector import MetalArray, MetalOperation
from Foundation import NSArray

class MetallicArray(list):

    def __init__(self, items):
        if type(items) is MetalArray:
            self.array = items
        else:
            self.array = MetalArray.alloc().initWithArray_(items)

    def __len__(self):
        return self.array.length()

    def __getitem__(self, index):
        if isinstance(index, slice):
            return MetallicArray([self[i] for i in range(*index.indices(len(self)))])
        elif isinstance(index, int):
            if index < 0:
                index += len(self)

            if index < 0 or index >= len(self):
                raise IndexError("The index ({}) is out of range.".format(index))

            return self.array.itemAtIndex_(index)
        else:
            raise TypeError("Invalid argument type.")

    def __iter__(self):
        for i in range(len(self)):
            yield self[i]

    def __str__(self):
        items = []

        for i in range(len(self)):
            items.append("{:.4f}".format(self[i]))

        return "[{}]".format(", ".join(items))

    def __repr__(self):
        return "array({})".format(str(self))

    def __add__(self, other):
        return self.perform("add_arrays", other.array)

    def __sub__(self, other):
        return self.perform("sub_arrays", other.array)

    def exp(self):
        return self.perform("exp_array")

    def square(self):
        return self.perform("square_array")

    def perform(self, operation, *args):
        op = MetalOperation.alloc().initWithOperation_(operation)
        arrays = NSArray.alloc().initWithObjects_(self.array, *args)
        return MetallicArray(op.computeWithArrays_(arrays))

def array(items):
    return MetallicArray(items)
