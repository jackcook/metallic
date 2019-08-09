from .utils import _perform

def sin(arr):
    return _perform(arr, "sin_array")

def cos(arr):
    return _perform(arr, "cos_array")

def tan(arr):
    return _perform(arr, "tan_array")

def arcsin(arr):
    return _perform(arr, "arcsin_array")

def arccos(arr):
    return _perform(arr, "arccos_array")

def arctan(arr):
    return _perform(arr, "arctan_array")

def hypot(arr, other):
    return _perform(arr, "hypot_arrays", other)

def arctan2(arr, other):
    return _perform(arr, "arctan2_arrays", other)

def degrees(arr):
    return _perform(arr, "degrees_array")

def radians(arr):
    return _perform(arr, "radians_array")

def deg2rad(arr):
    return radians(arr)

def rad2deg(arr):
    return degrees(arr)
