module GameOfLife

# Write your package code here.
include("life.jl")
include("patterns.jl")

using Makie
using GLMakie
using DSP
using LinearAlgebra
using OffsetArrays
using AbstractFFTs
using BenchmarkTools
using Images
using Interpolations

export create_life, life, wrap_matrix, conv2, growth
export pattern


end



# vytvaren funce v jednotlivych souborech 
# v souboru GameOfLife.jl je definovana exportem jake funkce jsou viditelné globalne a nemusi se po jejich volani psat GameOfLife.f()

# pri spusteni terminalu, julia, ] activate ., using Revise, using GameOfLife, volání funkcí
#  pro pridani pkg musim v ] add NazevBalicku a pak v souboru GameOfLife.jl musim pridat using NazevBalicku


# @btime wrap_matrix($A, 3)
# @btime conv2($A, $K)
# @btime growth($A, $Asize)