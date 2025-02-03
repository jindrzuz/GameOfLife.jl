"""
    display_matrix(A::Matrix{Float64})

Display matrix A in a way that the origin is in the top left corner.

# Arguments
- `A::Matrix{Float64}`: Matrix to be displayed.

# Returns
- `Matrix{Float64}`: Displayed matrix.
"""
function display_matrix(A::Matrix{Float64})
    return reverse(transpose(A), dims = 2)
end


"""
    wrap_matrix(A::Matrix{Float64}, Ksize::Integer)

Wrap matrix A with zeros on the edges.

# Arguments
- `A::Matrix{Float64}`: Matrix to be wrapped.
- `Ksize::Integer`: Size of kernel.

# Returns
- `Matrix{Float64}`: Wrapped matrix.
"""
function wrap_matrix(A::Matrix{Float64}, Ksize::Integer)
    pad = div(Ksize, 2)
    padded = vcat(A[end-pad+1:end, :], A, A[1:pad, :])
    padded = hcat(padded[:, end-pad+1:end], padded, padded[:, 1:pad])
    return padded
end

"""
    growth(U::Matrix{Float64}, Asize::Integer, m::Real, s::Real)

Calculate growth of matrix A.

# Arguments
- `U::Matrix{Float64}`: Matrix.
- `Asize::Integer`: Size of matrix A.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

# Returns
- `Matrix{Float64}`: Growth of matrix A.
"""
function growth(U::Matrix{Float64}, Asize::Integer, m::Real, s::Real)
    return bell.(U, m, s)*2-ones(Asize, Asize)
end

"""
    update(A::Matrix{T}, K::Matrix{T}, ax, t::Real , m::Real, s::Real) where T

Update matrix A.

# Arguments
- `A::Matrix{T}`: Matrix to be updated.
- `K::Matrix{T}`: Kernel.
- `t::Real`: Parameter.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

# Returns
- `Matrix{T}`: Updated matrix.
"""
function update(A::Matrix{T}, K::Matrix{T}, t::Real , m::Real, s::Real) where T
    Asize = size(A)[1]
    Ksize = size(K)[1]

    A_padded = wrap_matrix(A, Ksize)
    U_padded = conv2(A_padded, K)
    padd = Int((size(U_padded)[1] - Asize)/2)
    U = U_padded[padd+1:end-padd, padd+1:end-padd]  

    A_new = clamp.(A + 1/t * growth(U, Asize, m, s), 0, 1)
    
    return A_new
end

"""
    conv2(A::Matrix{T}, B::Matrix{T}) where T

Convolution of two matrices.

# Arguments
- `A::Matrix{T}`: Matrix.
- `B::Matrix{T}`: Matrix.

# Returns
- `Matrix{T}`: Convolution of two matrices.
"""
function conv2(A::Matrix{T}, B::Matrix{T}) where T
    sa, sb = size(A), size(B)
    At = zeros(T, sa[1]+sb[1]-1, sa[2]+sb[2]-1)
    Bt = zeros(T, sa[1]+sb[1]-1, sa[2]+sb[2]-1)
    At[1:sa[1], 1:sa[2]] = A
    Bt[1:sb[1], 1:sb[2]] = B
    p = plan_fft(At)
    C = ifft((p*At).*(p*Bt))
    return real(C)
end

"""
    bell(x::Real, m::Real, s::Real)

Calculate bell function.

# Arguments
- `x::Real`: Parameter.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

# Returns
- `Real`: Bell function.
"""
bell(x, m, s) = exp(-((x-m)/s)^2 / 2)

"""
    _norm(x...)

Calculate norm of x.

# Arguments
- `x...`: Vector x.

# Returns
- `Real`: Norm of x.
"""
_norm(x...) = sqrt(sum(x.^2))


"""
    compute_kernel(R::Integer)

Compute kernel.

# Arguments
- `R::Integer`: Parameter.

# Returns
- `Matrix{Float64}`: Kernel.
"""
function compute_kernel(R::Integer)
    D = [_norm(x,y) for x in -R:R, y in -R:R] ./ R
    D = bell.(D, 0.5, 0.15)
    K = D / sum(D)
    return K
end

"""
    initial_A(Asize::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)

Initialize matrix A.

# Arguments
- `Asize::Integer`: Size of matrix A.
- `pattern_name::String`: Name of pattern ['pulsar', 'dying_block', 'spiral'].
- `cx::Integer`: Position of pattern.
- `cy::Integer`: Position od pattern.
- `scale_::Integer`: Scale parameter.

# Returns
- `Matrix{Float64}`: Initialized matrix.
"""
function initial_A(Asize::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)
    A = zeros(Asize, Asize)
    C = pattern[pattern_name]["cells"]
    
    C_resized = imresize(C, ratio = scale_)  

    if size(C_resized, 1) > Asize || size(C_resized, 2) > Asize
        error("Pattern is too big for the matrix")
    end
    if cx + size(C_resized, 1) > Asize || cy + size(C_resized, 2) > Asize
        error("Pattern is out of bounds")
    end

    A[cx+1:cx+size(C_resized, 1), cy+1:cy+size(C_resized, 2)] = C_resized
    
    return A
end


"""
    load_pattern(name::String)

Load pattern.

# Arguments
- `name::String`: Name of pattern ['pulsar', 'dying_block', 'spiral'].

# Returns
- `Tuple{Integer, Integer, Real, Real}`: Pattern.
"""
function load_pattern(name)
    R = pattern[name]["R"]
    T = pattern[name]["T"]
    m = pattern[name]["m"]
    s = pattern[name]["s"]
    return R, T, m, s
end

"""
    create_life(Asize::Integer, n::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)

Create life.

# Arguments
- `Asize::Integer`: Size of matrix A.
- `n::Integer`: Number of iterations.
- `pattern_name::String`: Name of pattern ['pulsar', 'dying_block', 'spiral'].
- `cx::Integer`: Position of pattern.
- `cy::Integer`: Position of pattern.
- `scale_::Integer`: Scale parameter.

"""
function create_life(Asize::Integer, n::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)
    R, T, m, s = load_pattern(pattern_name)

    if cx <= 0 || cy <= 0 || scale_ <= 0 || Asize <= 0 || n <= 0
        error("Parameters have to be positive")
    end

    A = initial_A(Asize, pattern_name, cx, cy, scale_)
    K = compute_kernel(R)

    fig = Figure(size = (600, 600))
    ax = Makie.Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for _ in 1:n
        A = update(A, K, T, m, s)
        heatmap!(ax, display_matrix(A)) 
        sleep(0.1)
    end
end

"""
    create_life(A::Matrix{V}, K::Matrix{V}, n::Integer, m=0.5, s=0.15, T = 10) where V

Create life.

# Arguments
- `A::Matrix{V}`: Matrix A.
- `K::Matrix{V}`: Kernel K.
- `n::Integer`: Number of iterations.
- `T::Real`: Parameter.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

"""
function create_life(A::Matrix{V}, K::Matrix{V}, n::Integer, T = 10, m=0.5, s=0.15) where V
    if size(K)[1] > size(A)[1]
        error("Kernel K is too big for the matrix")
    end

    if !all(0 .<= A .<= 1)
        error("Matrix A has to be in range (0, 1)")
    end

    if !all(0 .<= K .<= 1)
        error("Kernel K has to be in range (0, 1)")
    end

    if size(K)[1] != size(K)[2]
        error("Kernel K has to be square")
    end
    
    if size(K)[1]%2 == 0
        error("Kernel K has to have odd size")
    end

    if size(A)[1] != size(A)[2]
        error("Matrix A has to be square")
    end

    if (T <= 0 || m <= 0 || s <= 0 || n <= 0)
        error("Parameters have to be positive")
    end

    fig = Figure(size = (600, 600))
    ax = Makie.Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for _ in 1:n
        A = update(A, K, T, m, s)
        heatmap!(ax, display_matrix(A)) 
        sleep(0.1)
    end
end

"""
    create_life(Asize::Integer, n::Integer, R=20, T=10, m=0.5, s=0.15)

Create life.

# Arguments
- `Asize::Integer`: Size of matrix A.
- `n::Integer`: Number of iterations.
- `R::Integer`: Parameter.
- `T::Integer`: Parameter.
- `m::Real`: Parameter.
- `s::Real`: Parameter.

"""
function create_life(Asize::Integer, n::Integer, R=20, T=10, m=0.5, s=0.15)
    if 2*R+1 > Asize
        error("R is too big for the matrix")
    end

    if T <= 0 || m <= 0 || s <= 0 || R <= 0 || Asize <= 0 || n <= 0
        error("Arguments have to be positive")
    end

    A = rand(Asize, Asize)
    K = compute_kernel(R)

    fig = Figure(size = (600, 600))
    ax = Makie.Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for _ in 1:n
        A = update(A, K, T, m, s)
        heatmap!(ax, display_matrix(A)) 
        sleep(0.1)
    end
end

