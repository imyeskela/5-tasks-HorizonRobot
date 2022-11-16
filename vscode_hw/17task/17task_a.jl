using HorizonSideRobots
include("../main_funcs.jl")
r = Robot(animate=true)

mutable struct ShuttleRobot <: SampleRobot
    robo :: Robot
end
shuttle_robot = ShuttleRobot(r)