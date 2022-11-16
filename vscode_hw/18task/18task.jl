using HorizonSideRobots
r = Robot(animate=true)

function recursive_along(r, side)
    isborder(r,side) && return
    move!(r, side)
    recursive_along(r, side)
end

recursive_along(r, HorizonSide(0))