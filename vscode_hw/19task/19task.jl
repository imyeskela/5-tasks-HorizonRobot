using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)


function recurcive_putmarker_along(r, side)
    if isborder(r, side)
        putmarker!(r)
    else
        move!(r, side)
        recurcive_putmarker_along(r, side)
        move!(r, inverse(side))
    end
end
recurcive_putmarker_along(r, HorizonSide(0))