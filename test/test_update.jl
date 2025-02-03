@testset "test_update" begin
    @testset "update_computation_pattern" begin
        pattern_names = ["pulsar", "dying_block", "spiral"]
        Asize = 200
        Ksize = 21
        cx = 80
        cy = 80
        scale_ = 1
        
        for name in pattern_names
            R = pattern[name]["R"]
            R = R*scale_  
        
            K = compute_kernel(R)
    
            A_init = initial_A(Asize, name, cx, cy, scale_)
            @test size(A_init) == (Asize, Asize)

            A_new = update(A_init, rand(Ksize, Ksize), 10, 0.5, 0.15)

            @test all(0 .<= A_new .<= 1)
            @test all(0 .<= A_init .<= 1)
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