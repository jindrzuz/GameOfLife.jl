module Lenia

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

# @btime wrap_matrix($A, 3)
# @btime conv2($A, $K)
# @btime growth($A, $Asize)