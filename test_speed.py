import metallic as mtl
import numpy as np
import time

# Number of times to run each test
ITERATIONS = 7

# Range of array sizes to test with
START_POW = 4
END_POW = 8

for pow in range(START_POW, END_POW + 1):
    array_size = 10 ** pow
    t1 = time.time()

    for _ in range(ITERATIONS):
        x = mtl.random.randn(array_size)
        y = mtl.random.randn(array_size)
        r1 = x + y
        r2 = mtl.sin(x)
        r3 = mtl.arctan2(x, y)

    t2 = time.time()

    for _ in range(ITERATIONS):
        x = np.random.randn(array_size)
        y = np.random.randn(array_size)
        r1 = x + y
        r2 = np.sin(x)
        r3 = np.arctan2(x, y)

    t3 = time.time()

    if pow > START_POW:
        print("===")

    print(f"Array size: 10 ** {pow}")
    print(f"metallic: {t2-t1:.4f}s")
    print(f"numpy: {t3-t2:.4f}s")