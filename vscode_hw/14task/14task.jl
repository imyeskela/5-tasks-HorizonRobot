using HorizonSideRobots

r = Robot("14task/14task.sit", animate=true)

# while !isborder(r, HorizonSide(3))
#     move!(r, HorizonSide(3))
# end

inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))


function try_move!(robot, direct)::Bool
    if isborder(robot, direct)
        return false
    end
    move!(robot, direct)
    return true
end

function along!(r, side)
    n=2
    putmarker!(r)
    while !isborder(r, side)
        n+=1
        move!(r, side)
        
        if n % 2 == 0
            putmarker!(r) end
        
    end
    return n
end

function snake!(stop_condition::Function, r, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Ost, Nord)) 
    # - это обобщенная функция
    
    along!(r, move_side)
    while try_move!(r, next_row_side)
        move_side = inverse(move_side)
        
        along!(r, move_side)
    end
end

snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Nord, Ost)) = snake!(() -> false, robot, (next_row_side, move_side))
snake!(r)
