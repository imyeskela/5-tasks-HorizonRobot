using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

function chess_along!(r, side)
    isborder(r, side) && return 
    move!(r, side)
    paint(r, side)
end

function paint(r, side)
    putmarker!(r)
    isborder(r, side) && return
    chess_along!(r, side)
end

chess_along!(r, HorizonSide(0))