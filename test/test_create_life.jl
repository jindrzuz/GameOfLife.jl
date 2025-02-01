@testset "test_create_life" begin
    @testset "error test" begin
        Asize = 50
        n = 5
        pattern_name = "pulsar"
        cx, cy = 10, 10
        scale_ = 2

        # Test chybových stavů
        @test_throws ErrorException create_life(Asize, n, pattern_name, 100, 100, scale_) 
        @test_throws ErrorException create_life(5, n, pattern_name, cx, cy, scale_)  
    end

    @testset "error free test" begin
        pattern_names = ["pulsar", "dying_block", "spiral"]
        Asize = 200
        n = 5
        cx = 80
        cy = 80
        scale_ = 1
        
        for name in pattern_names
            @test_nowarn create_life(Asize, n, name, cx, cy, scale_)
        end
    end
end
