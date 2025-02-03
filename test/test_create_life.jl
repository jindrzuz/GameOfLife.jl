@testset "test_create_life" begin
    @testset "error test" begin
        # Test for error handling
        @test_throws ErrorException create_life(100, 2, "pulsar", 100, 100, 2) # Pattern is out of bounds
        @test_throws ErrorException create_life(100, 2, "pulsar", -10, -10, 2) # Pattern is out of bounds
        @test_throws ErrorException create_life(100, -2, "pulsar", 10, 10, 2)  # Negative number of iterations
        @test_throws ErrorException create_life(100, 2, "pulsar", 10, 10, -2)  # Negative scale
        @test_throws ErrorException create_life(-100, 2, "pulsar", 10, 10, 2)  # Negative matrix size
        @test_throws ErrorException create_life(5, 2, "pulsar", 10, 10, 2)     # Pattern is too big for the matrix
        @test_throws ErrorException create_life(rand(200, 200), rand(60, 60), 2) # Size of kernel is not odd
        @test_throws ErrorException create_life(rand(10, 10), rand(51, 51), 2)   # Kernel is too big for the matrix A
        @test_throws ErrorException create_life(rand(100, 100), rand(21, 20), 2) # Kernel is not square
        @test_throws ErrorException create_life(rand(100, 60), rand(21, 21), 2)  # Matrix is not square
        @test_throws ErrorException create_life(rand(100, 60), rand(21, 21), -2) # Negative number of iterations
        @test_throws ErrorException create_life(rand(100, 100), rand(21, 21), 2, -10) # Negative parameter T
        @test_throws ErrorException create_life(rand(100, 100), rand(21, 21), 2, 10, -0.5, 0.15) # Negative parameter s
        @test_throws ErrorException create_life(rand(100, 100), rand(21, 21), 2, 10, 0.5, -0.15) # Negative parameter m
        @test_throws ErrorException create_life(float(rand(0:100, 100, 100)), rand(21, 21), 2) # Matrix A has to be in range 0-1
        @test_throws ErrorException create_life(rand(100, 100), float(rand(0:100, 21, 21)), 2) # Kernel K has to be in range 0-2
        @test_throws ErrorException create_life(-100, 2) # Negative matrix size
        @test_throws ErrorException create_life(100, -2) # Negative number of iterations
        @test_throws ErrorException create_life(100, 2, -20) # Negative parameter R
        @test_throws ErrorException create_life(100, 2, 20, -10) # Negative parameter T
        @test_throws ErrorException create_life(100, 2, 20, 10, -0.5) # Negative parameter m
        @test_throws ErrorException create_life(100, 2, 20, 10, 0.5, -0.15) # Negative parameter s
        @test_throws ErrorException create_life(10, 2, 20) # R is too big for the matrix A
    end

    @testset "error free test" begin
        pattern_names = ["pulsar", "dying_block", "spiral"]
        
        for name in pattern_names
            @test_nowarn create_life(200, 5, name, 20, 20, 2)
            @test_nowarn create_life(200, 5)
            @test_nowarn create_life(200, 5, 10, 10, 0.5, 0.15)
            @test_nowarn create_life(rand(100, 100), rand(21, 21), 5)
            @test_nowarn create_life(rand(100, 100), rand(21, 21), 5, 10, 0.5, 0.15)
        end
    end
end
