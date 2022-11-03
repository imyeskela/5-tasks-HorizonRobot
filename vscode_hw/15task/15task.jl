using HorizonSideRobots
r = Robot("15task/15task.sit", animate=true)

inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))


function along!(r, side, max_steps)
    num_steps = 0
    while num_steps != max_steps
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function  shuttle!(r, side)
    n=0 # число шагов от начального положения
    while isborder(r, HorizonSide(0)) 
        n += 1
        along!(r, side, n)
        side = inverse(side)
    end
end

function find_border(r)
    while !isborder(r, HorizonSide(0))
        move!(r, HorizonSide(0))
    end
    shuttle!(r, HorizonSide(3))
end


find_border(r)