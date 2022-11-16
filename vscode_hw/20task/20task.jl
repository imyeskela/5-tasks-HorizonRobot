using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function step!(r, side)
    if !isborder(r, side)
        move!(r, side)
    else
        move!(r, clockwise(side))
        step!(r, side)
        move!(r, anticlockwise(side))
    end
end

step!(r, HorizonSide(0))