using HorizonSideRobots
include("../main_funcs.jl")
r = Robot("15task/15task.sit", animate=true)

mutable struct ShuttleRobot <: SampleRobot
    robo :: Robot
end
shuttle_robot = ShuttleRobot(r)


stop_condition() = if isborder(shuttle_robot, HorizonSide(0)) return false else return true end


function find_border(shuttle_robot)
    while !isborder(shuttle_robot, HorizonSide(0))
        move!(shuttle_robot, HorizonSide(0))
    end
    shuttle!(stop_condition, shuttle_robot, HorizonSide(3))
end

find_border(shuttle_robot)
