using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function double_along!(r, side)
    if !isborder(r, side)
        move!(r, side)
        double_along!(r, side)
    else
        move!(r, inverse(side))
        move!(r, inverse(side))
    end
end

double_along!(r, HorizonSide(0))