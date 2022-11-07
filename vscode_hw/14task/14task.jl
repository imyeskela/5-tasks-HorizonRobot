using HorizonSideRobots
include("../main_funcs.jl")

r = Robot("14task/14task.sit", animate=true)

mutable struct ChessRobot <: SampleRobot
    robo :: Robot
    n :: Int
end
chessrobot = ChessRobot(r, 2)

function HorizonSideRobots.move!(r :: ChessRobot, side :: HorizonSide)
    if mod(r.n, 2) == 0
        putmarker!(get_robot(r))
    end
    move!(get_robot(r),side)
    r.n += 1    
end

allrows_snake!(chessrobot)
