module Lenia

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
using Test

export create_life, life, wrap_matrix, conv2, growth, compute_kernel, update, initial_A, display_matrix, load_pattern
export pattern


end
