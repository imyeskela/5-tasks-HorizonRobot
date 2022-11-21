using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function sum_elements(r, side)
    isborder(r,side) && return
     n = 0
end