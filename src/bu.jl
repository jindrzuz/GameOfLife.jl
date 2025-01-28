function display_matrix(A)
    return reverse(transpose(A), dims = 2)
end

function wrap_matrix(A, Ksize)
    pad = div(Ksize, 2)
    padded = vcat(A[end-pad+1:end, :], A, A[1:pad, :])
    padded = hcat(padded[:, end-pad+1:end], padded, padded[:, 1:pad])
    return padded
end

function growth(U, Asize)
  return zeros(Asize, Asize) + Float64.((U.>=0.12) .&& (U.<=0.15)) - Float64.((U.<=0.12) .|| (U.>=0.15))
end

function update(A, K, ax, T)
    Asize = size(A)[1]
    Ksize = size(K)[1]

    A_padded = wrap_matrix(A, Ksize)
    U_padded = conv2(A_padded, K)
    padd = Int((size(U_padded)[1] - Asize)/2)
    U = U_padded[padd+1:end-padd, padd+1:end-padd]  # Oříznutí na původní velikost

    A_new = clamp.(A + 1/T * growth(U, Asize), 0, 1)
    
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


function life(A, n)
    T = 10

    # # Funkce bell
    # bell(x, m, s) = exp.(-((x .- m) ./ s).^2 ./ 2)
    
    # # Rozsah pro mřížku
    # R = 10  # Poloměr kernelu
    # x = -R:R-1
    # y = -R:R-1
    
    # # Vytvoření mřížky (ekvivalent np.ogrid)
    # X, Y = [repeat(i, 1, length(y)) for i in x], [repeat(j, length(x), 1) for j in y]
    
    # # Výpočet vzdáleností
    # D = sqrt.(X.^2 .+ Y.^2) / R
    
    # # Výpočet kernelu K
    # K = (D .< 1) .* bell(D, 0.5, 0.15)
    
    K = [
        0 0 0 0 1 1 1 0 0 0 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 1 1 1 1 1 1 1 1 1 0;
        0 1 1 1 1 1 1 1 1 1 0;
        1 1 1 1 0 0 0 1 1 1 1;
        1 1 1 1 0 0 0 1 1 1 1;
        1 1 1 1 0 0 0 1 1 1 1;
        0 1 1 1 1 1 1 1 1 1 0;
        0 1 1 1 1 1 1 1 1 1 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 0 0 0 1 1 1 0 0 0 0
    ]
    K = K / sum(K)

    fig = Figure(size = (1000, 1000))
    ax = Axis(fig[1, 1])
    heatmap!(ax, display_matrix(A))
    display(fig) 
    
    for i in 1:n
        A = update(A, K, ax, T)
        sleep(0.1)
    end
end

function create_life(Asize, n)
    A = rand(Asize, Asize)

    life(Float64.(A), n)
end




