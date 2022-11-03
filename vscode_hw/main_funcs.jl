using HorizonSideRobots
# r = Robot("mainfuncs_test1.sit", animate=true)

inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))
clockwise(side :: HorizonSide) = HorizonSide(mod(Int(side)+1,4))

function stop_condition(move_side)::Bool
    if isborder(r, move_side)
        return true
    else
        return false
    end 
end

function try_move!(robot, direct)::Bool
    if isborder(robot, direct)
        return false
    end
    move!(robot, direct)
    return true
end

function along!(condition, r, side)
    n=0
    while !condition(r, side)
        move!(r, side)
        n+=1
    end
    return n
end


function stop_along!(stop_condition, r, side)
    while !stop_condition
        move!(r, side)
    end
end

function numsteps_stop_along!(stop_condition, r, side)
    num_steps = 0
    while stop_condition == false
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function maxsteps_or_stop_along!(stop_condition, r, side, max_steps)
    num_steps = 0
    while stop_condition == false | num_steps == max_steps
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function isborder_along!(r, side)
    while isborder(r, side) == false
        move!(r, side)
    end
end

function numsteps_isborder_along!(r, side)
    num_steps = 0
    while isborder(r, side) == false
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function by_steps_along!(r, side, steps)
    for _ in 1:steps
        move!(r, side)       
    end
end    


function snake!(stop_condition::Function, r, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) 
    # - это обобщенная функция
    
    along!(stop_condition, r, move_side)
    while try_move!(r, next_row_side)
        move_side = inverse(move_side)
        along!(stop_condition, r, move_side)
    end
end

# snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Ost, Nord)) = snake!(() -> false, robot, (next_row_side, move_side))
# snake!(stop_condition, r)

function  shuttle!(stop_condition::Function, robot, side)
    n=0 # число шагов от начального положения
    while !stop_condition() 
        n += 1
        along!(robot, side, n)
        side = inverse(side)
    end
end
