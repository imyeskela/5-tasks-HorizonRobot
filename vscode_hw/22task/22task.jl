using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function recursive_along(r, side)
    isborder(r,side) && return
    move!(r, side)
    recursive_along(r, side)
end

function symemetric_along(r, side)
    if isborder(r, side)
        recursive_along(r, inverse(side))
    else
        move!(r, side)
        symemetric_along(r, side)
        move!(r, side)
    end
end


symemetric_along(r, HorizonSide(0))