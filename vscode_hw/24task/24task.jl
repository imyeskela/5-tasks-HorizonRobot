using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function half_along!(r, side)
    if !isborder(r, side)
        move!(r, side)
        no_delayed_action!(r, side)
        move!(r, inverse(side))
    end
end

function no_delayed_action!(r,side)
    if !isborder(r, side)
        move!(r, side)
        half_along!(r, side)
    end
end
