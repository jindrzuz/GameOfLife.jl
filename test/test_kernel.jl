@testset "test_kenel" begin
    @testset "kernel_size" begin
        for R in 3:10
            K = compute_kernel(R)
            @test size(K) == (2R+1, 2R+1)
        end
    end

    @testset "kernel_cross" begin
        for R in 3:10
            K = compute_kernel(R)
            @test sum(K[R+1, :]) ≈ sum(K[:, R+1])
        end
    end
end