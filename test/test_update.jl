@testset "test_update" begin
    @testset "update_computation_pattern" begin
        pattern_name = ["pulsar", "dying_block", "spiral"]
        Asize = 200
        Ksize = 21
        for name in pattern_name
            pattern_name = nameof

            A_new = update(rand(Asize, Asize), rand(Ksize, Ksize), 10, 0.5, 0.15)

            for _ in Asize*Asize/4
                i = rand(1:Asize)
                j = rand(1:Asize)
                @test A_new[i, j] <= 1 && A_new[i, j] >= 0
            end

        end
    end

    @testset "update_size" begin
        for Asize in 100:200
            for Ksize in 3:2:20
                A_new  = update(rand(Asize, Asize), rand(Ksize, Ksize), 10, 0.5, 0.15)

                @test size(A_new) == (Asize, Asize)
            end
        end
    end

end 