var documenterSearchIndex = {"docs":
[{"location":"reference/#reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/#Contents","page":"Reference","title":"Contents","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Pages = [\"reference.md\"]","category":"page"},{"location":"reference/#Index","page":"Reference","title":"Index","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Pages = [\"reference.md\"]","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [Lenia]","category":"page"},{"location":"reference/#Lenia._norm-Tuple","page":"Reference","title":"Lenia._norm","text":"_norm(x...)\n\nCalculate norm of x.\n\nArguments\n\nx...: Vector x.\n\nReturns\n\nReal: Norm of x.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.bell-Tuple{Any, Any, Any}","page":"Reference","title":"Lenia.bell","text":"bell(x::Real, m::Real, s::Real)\n\nCalculate bell function.\n\nArguments\n\nx::Real: Parameter.\nm::Real: Parameter.\ns::Real: Parameter.\n\nReturns\n\nReal: Bell function.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.compute_kernel-Tuple{Integer}","page":"Reference","title":"Lenia.compute_kernel","text":"compute_kernel(R::Integer)\n\nCompute kernel.\n\nArguments\n\nR::Integer: Parameter.\n\nReturns\n\nMatrix{Float64}: Kernel.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.conv2-Union{Tuple{T}, Tuple{Matrix{T}, Matrix{T}}} where T","page":"Reference","title":"Lenia.conv2","text":"conv2(A::Matrix{T}, B::Matrix{T}) where T\n\nConvolution of two matrices.\n\nArguments\n\nA::Matrix{T}: Matrix.\nB::Matrix{T}: Matrix.\n\nReturns\n\nMatrix{T}: Convolution of two matrices.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.create_life-Tuple{Integer, Integer, String, Integer, Integer, Integer}","page":"Reference","title":"Lenia.create_life","text":"create_life(Asize::Integer, n::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)\n\nCreate life.\n\nArguments\n\nAsize::Integer: Size of matrix A.\nn::Integer: Number of iterations.\npattern_name::String: Name of pattern.\ncx::Integer: Parameter.\ncy::Integer: Parameter.\nscale_::Integer: Parameter.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.display_matrix-Tuple{Matrix{Float64}}","page":"Reference","title":"Lenia.display_matrix","text":"display_matrix(A::Matrix{Float64})\n\nDisplay matrix A in a way that the origin is in the top left corner.\n\nArguments\n\nA::Matrix{Float64}: Matrix to be displayed.\n\nReturns\n\nMatrix{Float64}: Displayed matrix.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.growth-Tuple{Matrix{Float64}, Integer, Real, Real}","page":"Reference","title":"Lenia.growth","text":"growth(U::Matrix{Float64}, Asize::Integer, m::Real, s::Real)\n\nCalculate growth of matrix A.\n\nArguments\n\nU::Matrix{Float64}: Matrix.\nAsize::Integer: Size of matrix A.\nm::Real: Parameter.\ns::Real: Parameter.\n\nReturns\n\nMatrix{Float64}: Growth of matrix A.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.initial_A-Tuple{Integer, String, Integer, Integer, Integer}","page":"Reference","title":"Lenia.initial_A","text":"initial_A(Asize::Integer, pattern_name::String, cx::Integer, cy::Integer, scale_::Integer)\n\nInitialize matrix A.\n\nArguments\n\nAsize::Integer: Size of matrix A.\npattern_name::String: Name of pattern.\ncx::Integer: Position of pattern.\ncy::Integer: Position od pattern.\nscale_::Integer: Parameter.\n\nReturns\n\nMatrix{Float64}: Initialized matrix.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.load_pattern-Tuple{Any}","page":"Reference","title":"Lenia.load_pattern","text":"load_pattern(name::String)\n\nLoad pattern.\n\nArguments\n\nname::String: Name of pattern.\n\nReturns\n\nTuple{Integer, Integer, Real, Real}: Pattern.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.update-Union{Tuple{T}, Tuple{Matrix{T}, Matrix{T}, Real, Real, Real}} where T","page":"Reference","title":"Lenia.update","text":"update(A::Matrix{T}, K::Matrix{T}, ax, t::Real , m::Real, s::Real) where T\n\nUpdate matrix A.\n\nArguments\n\nA::Matrix{T}: Matrix to be updated.\nK::Matrix{T}: Kernel.\nt::Real: Parameter.\nm::Real: Parameter.\ns::Real: Parameter.\n\nReturns\n\nMatrix{T}: Updated matrix.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Lenia.wrap_matrix-Tuple{Matrix{Float64}, Integer}","page":"Reference","title":"Lenia.wrap_matrix","text":"wrap_matrix(A::Matrix{Float64}, Ksize::Integer)\n\nWrap matrix A with zeros on the edges.\n\nArguments\n\nA::Matrix{Float64}: Matrix to be wrapped.\nKsize::Integer: Size of kernel.\n\nReturns\n\nMatrix{Float64}: Wrapped matrix.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Lenia","category":"page"},{"location":"#Lenia:-Continuous-Cellular-Automaton-in-Julia","page":"Home","title":"Lenia: Continuous Cellular Automaton in Julia","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package provides a simulation of a continuous version of the Game of Life, named Lenia, in Julia. Unlike the traditional Game of Life, which is based on a discrete grid, Lenia uses continuous space and time to simulate evolving \"organisms\". It allows for the creation of more dynamic, smooth, and realistic simulations of life-like structures. ","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Lenia is inspired by the concept of cellular automata but takes a continuous approach. In this package, the cells are replaced by evolving entities that can smoothly transition between states. These entities can grow, move, and interact with their surroundings, mimicking natural phenomena.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This Julia package implements basic functionality for simulating the growth of cells and applying kernel-based transformations to model the behavior of such organisms. It also provides tools for visualizing the evolution of the system over time.","category":"page"},{"location":"#Algorithm","page":"Home","title":"Algorithm","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Matrix Representation:\nThe environment is represented by a matrix (A), where each element represents the state of a cell at that point in space.\nThe matrix is updated over time using specific rules of growth and interaction.\nPatterns:\nPredefined patterns, like the \"pulsar\", are used as starting configurations for the simulation.\nThese patterns are resized and placed in the matrix.\nKernel Convolution:\nA convolution kernel (K) is used to model interactions between cells and their neighbors.\nThis kernel is applied to the matrix to simulate the effect of surrounding cells on the growth of a particular cell.\n<img src=\"GameOfLife/images/kernel.png\" alt=\"Kernel\" width=\"600\">","category":"page"},{"location":"","page":"Home","title":"Home","text":"Growth Function:\nThe growth of cells is calculated using a bell function, which models the influence of neighboring cells on a given cell.\nThe growth is continuous, meaning the state of each cell evolves smoothly, and this effect is influenced by parameters like m and s.\nSimulation:\nThe matrix is updated at each iteration based on the interactions calculated through the kernel.\nThe simulation runs for a specified number of iterations, and at each step, the matrix is updated, showing the evolution of the life-like entities.\nVisualization\nThe state of the matrix is visualized using heatmaps to show the density and evolution of cells over time. The matrix is updated and displayed at each iteration.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install the package, simply run the following command in Julia's REPL:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Pkg\n\nPkg.add(url = \"https://github.com/jindrzuz/Lenia.jl\")","category":"page"},{"location":"#Examples","page":"Home","title":"Examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Examples of use available in the folder scripts.","category":"page"},{"location":"","page":"Home","title":"Home","text":"<table>   <tr>     <td>       <img src=\"GameOfLife/images/examplepulsar.gif\" width=\"400\">     </td>     <td>       <p><b>Example 1: Pulsar</b><br>       This example shows a stable pulsating structure that continually changes shape over time until it reaches a steady state.</p>     </td>   </tr>   <tr>     <td>       <img src=\"GameOfLife/images/exampledyingblock.gif\" width=\"400\">     </td>     <td>       <p><b>Example 2: Dying block</b><br>       Here, we observe an unstable configuration that eventually fades away due to lack of growth support.</p>     </td>   </tr>   <tr>     <td>       <img src=\"GameOfLife/images/examplespiral.gif\" width=\"400\">     </td>     <td>       <p><b>Example 3: Spiral</b><br>       A self-sustaining spiral structure that continuously expands as the simulation progresses.</p>     </td>   </tr> </table>","category":"page"},{"location":"#Benchmark","page":"Home","title":"Benchmark","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Comparison of execution times between Python and Julia implementations. The function tested is the update function , which updates the matrix A during the lifetime. ","category":"page"},{"location":"#Random-matrix-A-and-kernel-K-(20x20):","page":"Home","title":"Random matrix A and kernel K (20x20):","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Resolution of A Time Python [ms] Time Julia -median [ms]\n100x100 13.598 2.298\n500x500 1 401.755 72.718\n1000x1000 21 103.500 280.456","category":"page"},{"location":"#Examples:","page":"Home","title":"Examples:","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Example name Time Python [ms] Time Julia -median [ms]\nPulsar 311.087 25.453\nSpiral 395.791 32.870\nDying block 164.123 8.603","category":"page"}]
}
