function display_matrix(A)
    return reverse(transpose(A), dims = 2)
end

function wrap_matrix(A, Ksize)
    pad = div(Ksize, 2)
    padded = vcat(A[end-pad+1:end, :], A, A[1:pad, :])
    padded = hcat(padded[:, end-pad+1:end], padded, padded[:, 1:pad])
    return padded
end

function growth(U, Asize, m, s)
#   return zeros(Asize, Asize) + Float64.((U.>=0.12) .&& (U.<=0.15)) - Float64.((U.<=0.12) .|| (U.>=0.15))
  return bell(U, m, s)*2-ones(Asize, Asize)
end

function update(A, K, ax, T, m, s)
    Asize = size(A)[1]
    Ksize = size(K)[1]

    A_padded = wrap_matrix(A, Ksize)
    U_padded = conv2(A_padded, K)
    padd = Int((size(U_padded)[1] - Asize)/2)
    U = U_padded[padd+1:end-padd, padd+1:end-padd]  # Oříznutí na původní velikost

    A_new = clamp.(A + 1/T * growth(U, Asize, m, s), 0, 1)
    
    heatmap!(ax, display_matrix(A_new)) 
    return A_new
end

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

conv2(A::Matrix{T}, B::Matrix{T}) where {T<:Integer} =
    round.(Int, conv2(float(A), float(B)))
conv2(u::StridedVector{T}, v::StridedVector{T}, A::StridedMatrix{T}) where {T<:Integer} =
    round.(Int, conv2(float(u), float(v), float(A)))

bell(x, m, s) = exp.(-((x .- m) ./ s).^2 ./ 2)


function create_life(Asize, n)
    A = zeros(Asize, Asize)
    scale_ = 1

    #pocatecni poloha
    cx = 20
    cy = 20
    C = pattern["orbium"]["cells"]
    T = pattern["orbium"]["T"]
    R = pattern["orbium"]["R"]
    s = pattern["orbium"]["s"]
    m = pattern["orbium"]["m"]
    
    C_resized = imresize(C, ratio = scale_)  # Pro interpolaci s parametrem order=0 (nejbližší soused)
    
    R = R*scale_  

    A[cx+1:cx+size(C_resized, 1), cy+1:cy+size(C_resized, 2)] = C_resized
    
    x = -R:R
    y = -R:R
    X = repeat(x, 1)
    X = X*X'
    D = abs.(X)/R
    
    K = (D .< 1) .* bell(D, 0.5, 0.15)
    
    # K = [
    #     0 0 0 0 1 1 1 0 0 0 0;
    #     0 0 1 1 1 1 1 1 1 0 0;
    #     0 1 1 1 1 1 1 1 1 1 0;
    #     0 1 1 1 1 1 1 1 1 1 0;
    #     1 1 1 1 0 0 0 1 1 1 1;
    #     1 1 1 1 0 0 0 1 1 1 1;
    #     1 1 1 1 0 0 0 1 1 1 1;
    #     0 1 1 1 1 1 1 1 1 1 0;
    #     0 1 1 1 1 1 1 1 1 1 0;
    #     0 0 1 1 1 1 1 1 1 0 0;
    #     0 0 0 0 1 1 1 0 0 0 0
    # ]

    K = K / sum(K)

    fig = Figure(size = (600, 600))
    ax = Makie.Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for i in 1:n
        A = update(A, K, ax, T, m, s)
        sleep(0.1)
    end
end




