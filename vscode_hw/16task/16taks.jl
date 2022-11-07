using HorizonSideRobots

r = Robot("16task/16task.sit", animate=true)

left(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)-1, 4))

function along!(r, side, max_steps)
    num_steps = 0
    while num_steps != max_steps
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end



function spiral!(r, side = Nord)

    n=2
    while !ismarker(r)       
        side = left(side)
        along!(r, side, n ÷ 2) # ÷ - это операция деления нацело
        n += 1
    end
end

spiral!(r)
