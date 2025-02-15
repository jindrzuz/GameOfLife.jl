```@meta
CurrentModule = Lenia
```

# Lenia: Continuous Cellular Automaton in Julia

This package provides a simulation of a continuous version of the Game of Life, named **Lenia**, in Julia. Unlike the traditional Game of Life, which is based on a discrete grid, Lenia uses continuous space and time to simulate evolving "organisms". It allows for the creation of more dynamic, smooth, and realistic simulations of life-like structures. 

## Overview

Lenia is inspired by the concept of cellular automata but takes a continuous approach. In this package, the cells are replaced by evolving entities that can smoothly transition between states. These entities can grow, move, and interact with their surroundings, mimicking natural phenomena.

This Julia package implements basic functionality for simulating the growth of cells and applying kernel-based transformations to model the behavior of such organisms. It also provides tools for visualizing the evolution of the system over time.

## Installation

To install the package, simply run the following command in Julia's REPL:

```
using Pkg

Pkg.add(url = "https://github.com/jindrzuz/Lenia.jl")
```

## Algorithm

1. **Matrix Representation**:
   - The environment is represented by a matrix (`A`), where each element represents the state of a cell at that point in space.
   - The matrix is updated over time using specific rules of growth and interaction.

2. **Patterns**:
   - Predefined patterns, like the "pulsar", are used as starting configurations for the simulation.
   - These patterns are resized and placed in the matrix.

3. **Kernel Convolution**:
   - A convolution kernel (`K`) is used to model interactions between cells and their neighbors.
   - This kernel is applied to the matrix to simulate the effect of surrounding cells on the growth of a particular cell.

  ![kernel](./images/kernel.png)

4. **Growth Function**:
   - The growth of cells is calculated using a **bell function**, which models the influence of neighboring cells on a given cell.
   - The growth is continuous, meaning the state of each cell evolves smoothly, and this effect is influenced by parameters like `m` and `s`.

5. **Simulation**:
   - The matrix is updated at each iteration based on the interactions calculated through the kernel.
   - The simulation runs for a specified number of iterations, and at each step, the matrix is updated, showing the evolution of the life-like entities.

6. **Visualization**
    - The state of the matrix is visualized using **heatmaps** to show the density and evolution of cells over time. The matrix is updated and displayed at each iteration.

## Usage
There are one main function in packege `create_life` which creates a new life with given parameters and start visualization. The function can be use as follows:
```julia
using Lenia
create_life(300, 200, "pulsar", 100, 100, 2)
```
or for random life:
```julia
using Lenia
create_life(200, 100)
```
For more information about the parameters, please refer to the Reference.


## Benchmark
Comparison of execution times between Python and Julia implementations. The function tested is the update function , which updates the matrix A during the lifetime. The compared implementations can be found in the scripts folder (julia_benchmark.jl, Lenia.py)

#### Random matrix A and kernel K (20x20):
| Resolution of A | Time Python [ms] | Time Julia -median [ms] |
|-----------------|:----------------:|:-----------------------:|
| 100x100         |       13.598     |           2.298         |
| 500x500         |    1 401.755     |          72.718         |
| 1000x1000       |   21 103.500     |         280.456         |

#### Examples:
| Example name    | Time Python [ms] | Time Julia -median [ms] |
|-----------------|:----------------:|:-----------------------:|
| Pulsar          |      311.087     |         25.453          |
| Spiral          |      395.791     |         32.870          |
| Dying block     |      164.123     |          8.603          |


## Examples
Examples of use available in the folder **scripts**.

|               |             |
|:-------------:|:-----------:|
|![example_pulsar](./images/example_pulsar.gif)| **Example 1 : Pulsar** This example shows a stable pulsating structure that continually changes shape over time until it reaches a steady state.|
|![example_dying_block](./images/example_dying_block.gif)| **Example 2: Dying block** Here, we observe an unstable configuration that eventually fades away due to lack of growth support.| 
|![example_spiral](./images/example_spiral.gif)| **Example 3: Spiral** A self-sustaining spiral structure that continuously expands as the simulation progresses.|


