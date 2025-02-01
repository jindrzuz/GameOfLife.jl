@testset "test_visualization" begin
    @testset "example_dying_block" begin
        Asize = 200
        n = 140
        cx = 40
        cy = 40
        scale_ = 13

        R = pattern["dying_block"]["R"]
        T = pattern["dying_block"]["T"]
        m = pattern["dying_block"]["m"]
        s = pattern["dying_block"]["s"]
    
        A = initial_A(Asize, "dying_block", cx, cy, scale_)
        K = compute_kernel(R)

        for _ in 1:n
            A = update(A, K, T, m, s)
        end

        @test A == zeros(Asize, Asize)
    end

    @testset "display_matrix" begin
        for Asize in 100:200
            A_init = rand(Asize, Asize)
            A = display_matrix(A_init)
            A = display_matrix(A)
            A = display_matrix(A)
            A = display_matrix(A)

            @test A == A_init
        end
    end
end