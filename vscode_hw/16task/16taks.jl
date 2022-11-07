using HorizonSideRobots
include("../main_funcs.jl")

r = Robot("16task/16task.sit", animate=true)

mutable struct SpiralRobot <: SampleRobot
    robo :: Robot
end
spiral_robot = SpiralRobot(r)



stop_condition() = if ismarker(spiral_robot) return true else return false end

spiral!(stop_condition, spiral_robot)
