
import numpy as np
import scipy.ndimage
import time

def load_pattern(name):
    R = pattern[name]["R"]
    T = pattern[name]["T"]
    m = pattern[name]["m"]
    s = pattern[name]["s"]
    return R, T, m, s


pattern = {
    "pulsar": {
        "name": "Pulsar",
        "R": 20,
        "T": 8,
        "m": 0.12,
        "s": 0.02,
        "b": [1],
        "cells": [
            [0, 0, 0, 0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1, 0, 0, 0, 0, 0],
            [0, 0, 0.1, 0.3, 0.5, 0.7, 0.9, 0.7, 0.5, 0.3, 0.1, 0, 0, 0, 0],
            [0, 0.1, 0.3, 0.6, 0.8, 1, 1, 1, 0.8, 0.6, 0.3, 0.1, 0, 0, 0],
            [0.1, 0.3, 0.6, 0.9, 1, 1, 1, 1, 1, 0.9, 0.6, 0.3, 0.1, 0, 0],
            [0.2, 0.5, 0.8, 1, 1, 0.9, 0.8, 0.9, 1, 1, 0.8, 0.5, 0.2, 0.1, 0],
            [0.3, 0.7, 1, 1, 0.9, 0.7, 0.6, 0.7, 0.9, 1, 1, 0.7, 0.3, 0.2, 0],
            [0.4, 0.9, 1, 1, 0.8, 0.6, 0.5, 0.6, 0.8, 1, 1, 0.9, 0.4, 0.3, 0.1],
            [0.3, 0.7, 1, 1, 0.9, 0.7, 0.6, 0.7, 0.9, 1, 1, 0.7, 0.3, 0.2, 0],
            [0.2, 0.5, 0.8, 1, 1, 0.9, 0.8, 0.9, 1, 1, 0.8, 0.5, 0.2, 0.1, 0],
            [0.1, 0.3, 0.6, 0.9, 1, 1, 1, 1, 1, 0.9, 0.6, 0.3, 0.1, 0, 0],
            [0, 0.1, 0.3, 0.6, 0.8, 1, 1, 1, 0.8, 0.6, 0.3, 0.1, 0, 0, 0],
            [0, 0, 0.1, 0.3, 0.5, 0.7, 0.9, 0.7, 0.5, 0.3, 0.1, 0, 0, 0, 0],
            [0, 0, 0, 0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1, 0, 0, 0, 0, 0]
        ]
    },
    "dying_block": {
        "name": "Dying Block",
        "R": 20,
        "T": 50,
        "m": 0.4,
        "s": 0.05,
        "b": [1],
        "cells": [
            [0] * 10,
            [0] * 10,
            [0] * 10,
            [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
            [0] * 10,
            [0] * 10,
            [0] * 10
        ]
    },
    "spiral": {
        "name": "Spiral",
        "R": 20,
        "T": 12,
        "m": 0.1,
        "s": 0.03,
        "b": [1],
        "cells": [[0.05 * (i + j) for j in range(15)] for i in range(12)]
    }
}

def bell(x, m, s):
    return np.exp(-((x - m) / s) ** 2 / 2)

def norm(*x):
    return np.sqrt(sum(np.array(x) ** 2))

def growth(U, m, s):
  return bell(U, m, s)*2-1

def update(A, K, T, m, s):
  U = scipy.signal.convolve2d(A, K, mode='same', boundary='wrap')
  A = np.clip(A + 1/T * growth(U, m, s), 0, 1)
  return A

def initial_A(size, name, cx, cy, scale):
    A = np.zeros([size, size])
    C = pattern[name]["cells"]
    C = scipy.ndimage.zoom(C, scale, order=0)
    A[cx:cx+C.shape[0], cy:cy+C.shape[1]] = C
    return A

def compute_kernel(R):
    D = np.array([[norm(x, y) for x in range(-R, R+1)] for y in range(-R, R+1)]) / R
    D = bell(D, 0.5, 0.15)
    K = D / np.sum(D)
    return K

def update_time(A, K, T, m, s, n):
    t0 = time.time()
    for _ in range(n):
        update(A, K, T, m, s)
    return (time.time() - t0)/n
    

#random matrix A(100x100) and K(21x21)
print("Random A(100x100) and K(21x21)")
print(update_time(np.random.rand(100, 100), np.random.rand(21, 21), 10, 0.5, 0.15, 2000))

#random matrix A(500x500) and K(51x51)
print("Random A(500x500) and K(51x51)")
print(update_time(np.random.rand(500, 500), np.random.rand(51, 51), 10, 0.5, 0.15, 60))

#random matrix A(1000x1000) and K(101x101)
print("Random matrix A(1000x1000) and K(101x101)")
print(update_time(np.random.rand(1000, 1000), np.random.rand(101, 101), 10, 0.5, 0.15, 10))

#matrix matrix A with pattern "pulsar" and K(21x21)
print("matrix matrix A with pattern 'pulsar' and K(21x21)")
A = initial_A(300, "pulsar", 100, 100, 2)
R, T, m, s = load_pattern("pulsar")
K = compute_kernel(R)
print(update_time(A, K, T, m, s, 150))

#matrix A with pattern "spiral" and K(21x21)
print("matrix A with pattern 'spiral' and K(21x21)")
A = initial_A(300, "spiral", 130, 130, 3)
R, T, m, s = load_pattern("spiral")
K = compute_kernel(R)
print(update_time(A, K, T, m, s, 200))

#matrix A with pattern "dying block" and K(21x21)
print("matrix A with pattern 'dying block' and K(21x21)")
A = initial_A(200, "dying_block", 40, 40, 13)
R, T, m, s = load_pattern("dying_block")
K = compute_kernel(R)
print(update_time(A, K, T, m, s, 470))




