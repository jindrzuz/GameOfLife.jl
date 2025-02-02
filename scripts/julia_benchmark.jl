using Lenia
using BenchmarkTools

#random matrix A(100x100) and K(21x21)
println("Random A(100x100) and K(21x21)")
display(@benchmark update(rand(100, 100), rand(21, 21), 10, 0.5, 0.15))

#random matrix A(500x500) and K(51x51)
println("Random A(500x500) and K(51x51)")
display(@benchmark update(rand(500, 500), rand(51, 51), 10, 0.5, 0.15))

#random matrix A(1000x1000) and K(101x101)
println("Random matrix A(1000x1000) and K(101x101)")
display(@benchmark update(rand(1000, 1000), rand(101, 101), 10, 0.5, 0.15))

#matrix matrix A with pattern "pulsar" and K(21x21)
println("Matrix A with pattern 'pulsar' and K(21x21)")
A = initial_A(300, "pulsar", 100, 100, 2)
R, T, m, s = load_pattern("pulsar")
K = compute_kernel(R)
display(@benchmark update(A, K, T, m, s))

#matrix A with pattern "spiral" and K(21x21)
println("Matrix A with pattern 'spiral' and K(21x21)")
A = initial_A(300, "spiral", 130, 130, 3)
R, T, m, s = load_pattern("spiral")
K = compute_kernel(R)
display(@benchmark update(A, K, T, m, s))

#matrix A with pattern "dying block" and K(21x21)
println("Matrix A with pattern 'dying block' and K(21x21)")
A = initial_A(200, "dying_block", 40, 40, 13)
R, T, m, s = load_pattern("dying_block")
K = compute_kernel(R)
display(@benchmark update(A, K, T, m, s))
