"""
    display_matrix(A::Matrix{T}) where T
    
Transpose matrix A and reverse it along the second dimension.

# Arguments
- `A::Matrix{T}`: Matrix to be displayed.

# Returns
- `Matrix{T}`: Transposed and reversed matrix.
"""
function display_matrix(A)
    return reverse(transpose(A), dims = 2)
end


"""
    wrap_matrix(A::Matrix{T}, Ksize::Integer) where T

Wrap matrix A with padding of size Ksize.

# Arguments
- `A::Matrix{T}`: Matrix to be wrapped.
- `Ksize::Integer`: Size of kernel.

# Returns
- `Matrix{T}`: Wrapped matrix.
"""
function wrap_matrix(A, Ksize::Integer)
    pad = div(Ksize, 2)
    padded = vcat(A[end-pad+1:end, :], A, A[1:pad, :])
    padded = hcat(padded[:, end-pad+1:end], padded, padded[:, 1:pad])
    return padded
end

"""
    growth(U::Matrix{T}, Asize::Integer) where T

Calculate growth of matrix U.

# Arguments
- `U::Matrix{T}`: Matrix to calculate growth from.
- `Asize::Integer`: Size of matrix.

# Returns
- `Matrix{T}`: Growth matrix.
"""
function growth(U  , Asize::Integer, m::Real, s::Real)
    # return zeros(Asize, Asize) + Float64.((U.>=0.12) .&& (U.<=0.15)) - Float64.((U.<=0.12) .|| (U.>=0.15))
    return bell.(U, m, s)*2-ones(Asize, Asize)
end

"""
    update(A::Matrix{T}, K::Matrix{T}, ax, t::Real , m::Real, s::Real) where T

Update matrix A.

# Arguments
- `A::Matrix{T}`: Matrix to be updated.
- `K::Matrix{T}`: Kernel matrix.
- `ax`: Axis.
- `t::Real`: Parameter.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

# Returns
- `Matrix{T}`: Updated matrix.
"""
function update(A::Matrix{T}, K::Matrix{T}, ax, t::Real , m::Real, s::Real) where T
    Asize = size(A)[1]
    Ksize = size(K)[1]

    A_padded = wrap_matrix(A, Ksize)
    U_padded = conv2(A_padded, K)
    padd = Int((size(U_padded)[1] - Asize)/2)
    U = U_padded[padd+1:end-padd, padd+1:end-padd]  

    A_new = clamp.(A + 1/t * growth(U, Asize, m, s), 0, 1)
    
    heatmap!(ax, display_matrix(A_new)) 
    return A_new
end

"""
    conv2(A::Matrix{T}, B::Matrix{T}) where T

Convolution of two matrices.

# Arguments
- `A::Matrix{T}`: Matrix A.
- `B::Matrix{T}`: Matrix B.

# Returns
- `Matrix{T}`: Convolution of A and B.
"""
function conv2(A::Matrix{T}, B::Matrix{T}) where T
    sa, sb = size(A), size(B)
    At = zeros(T, sa[1]+sb[1]-1, sa[2]+sb[2]-1)
    Bt = zeros(T, sa[1]+sb[1]-1, sa[2]+sb[2]-1)
    At[1:sa[1], 1:sa[2]] = A
    Bt[1:sb[1], 1:sb[2]] = B
    p = plan_fft(At)
    C = ifft((p*At).*(p*Bt))
    if T <: Real
        return real(C)
    end
    return C
end

"""
    bell(x, m, s)

Bell function.

# Arguments
- `x`: Parameter.
- `m`: Parameter.
- `s`: Parameter.

# Returns
- `Real`: Bell function.
"""
bell(x, m, s) = exp(-((x-m)/s)^2 / 2)
_norm(x...) = sqrt(sum(x.^2))
"""
    create_life(Asize::Integer, n::Integer)

Create life.

# Arguments
- `Asize::Integer`: Size of matrix.
- `n::Integer`: Number of iterations.
"""
function create_life(Asize::Integer, n::Integer)
    A = zeros(Asize, Asize)
    scale_ = 1
    cx = 20
    cy = 20
    pattern_name = "pulsar"
    C = pattern[pattern_name]["cells"]
    T = pattern[pattern_name]["T"]
    R = pattern[pattern_name]["R"]
    s = pattern[pattern_name]["s"]
    m = pattern[pattern_name]["m"]
    
    C_resized = imresize(C, ratio = scale_)  
    
    R = R*scale_  

    A[cx+1:cx+size(C_resized, 1), cy+1:cy+size(C_resized, 2)] = C_resized
    
    # R = 10
    # T = 10
    # m = 0.15
    # s = 0.015
    # A = rand(Asize, Asize)

    R = 10
    D = [_norm(x,y) for x in -R:R, y in -R:R] ./ R
    D = bell.(D, 0.5, 0.15)

    K = D / sum(D)

    fig = Figure(size = (600, 600))
    ax = Makie.Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for i in 1:n
        A = update(A, K, ax, T, m, s)
        sleep(0.1)
    end
end




