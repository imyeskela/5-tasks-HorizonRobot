using HorizonSideRobots
# r = Robot("mainfuncs_test1.sit", animate=true)

abstract type SampleRobot end
get_robot(r :: SampleRobot) = r.robo

HorizonSideRobots.move!(robot::SampleRobot, side :: HorizonSide) = move!(get_robot(robot), side)
HorizonSideRobots.isborder(robot::SampleRobot, side :: HorizonSide) = isborder(get_robot(robot), side)
HorizonSideRobots.putmarker!(robot::SampleRobot) = putmarker!(get_robot(robot))
HorizonSideRobots.ismarker(robot::SampleRobot) = ismarker(get_robot(robot))
HorizonSideRobots.temperature(robot::SampleRobot) = temperature(get_robot(robot))
HorizonSideRobots.ismarker(robot :: SampleRobot) = ismarker(get_robot(robot))

struct BaseRobot <: SampleRobot
    robo :: Robot
end

inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))
clockwise(side :: HorizonSide) = HorizonSide(mod(Int(side)+1,4))

try_move!(r::SampleRobot, side) = (!isborder(r, side) && (move!(r, side); return true); false)

just_along!(r::SampleRobot, side::HorizonSide) = while !isborder(r, side) move!(r, side) end
stop_along!(stop_condition::Function, r::SampleRobot, side::HorizonSide) = while stop_condition(r,side) && !isborder(r,side) move!(r,side) end 

function countsteps_along!(stop_condition::Function, r::SampleRobot, side::HorizonSide)
    steps=0
    while stop_condition(r,side) 
        move!(r,side)
        steps+=1 
    end
    return steps
end

function maxsteps_along!(r::SampleRobot, side::HorizonSide, max_steps::Int)
    while max_steps>0
        move!(r,side)
        max_steps-=1
    end
    return max_steps
end

function maxsteps_or_stop_along!(stop_condition::Function, r::SampleRobot, side::HorizonSide, max_steps::Int)
    while stop_condition(r,side) && max_num>0
        move!(r,side)
        max_steps-=1 
    end
    return max_steps
end
 

# function snake!(stop_condition::Function, r, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) 
#     # - это обобщенная функция
    
#     along!(stop_condition, r, move_side)
#     while try_move!(r, next_row_side)
#         move_side = inverse(move_side)
#         along!(stop_condition, r, move_side)
#     end
# end

function snake!(stop_condition::Function, r::SampleRobot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) # - это обобщенная функция
    # Робот - в (inverse(next_row_side), inverse(move_side))-углу поля
    stop_along!(stop_condition, r, move_side)
    while !stop_condition(move_side) && try_move!(r, next_row_side)
        move_side = inverse(move_side)
        stop_along!(stop_condition, robot, move_side)
    end
end

function allrows_snake!(r::SampleRobot, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Ost, Nord)) 
    just_along!(r, move_side)
    while try_move!(r, next_row_side)
        move_side = inverse(move_side)
        
        just_along!(r, move_side)
    end
end

# allrows_snake!(r, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Ost, Nord)) = snake!(() -> false, r, (next_row_side, move_side))

# snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Ost, Nord)) = snake!(() -> false, robot, (next_row_side, move_side))
# snake!(stop_condition, r)

function  shuttle!(stop_condition::Function, r::SampleRobot, side)
    n=0 # число шагов от начального положения
    while !stop_condition()
        n += 1
        maxsteps_along!(r, side, n)
        side = inverse(side)
    end
end

function spiral!(stop_condition::Function, r::SampleRobot, side = Nord)

    n=2
    while !stop_condition(side)        
        side = left(side)
        along!(r, side, n ÷ 2) # ÷ - это операция деления нацело
        n += 1
    end
end
