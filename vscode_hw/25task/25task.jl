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
    move!(r, side)
    chess_along!(r, side)
end


function start_chess(r, side, is_painted_start_point=false)
    if is_painted_start_point
        chess_along!(r, side)
    else
        paint(r, side)
    end
end

start_chess(r, HorizonSide(0), true)
