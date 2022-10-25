using HorizonSideRobots
r = Robot(8, 8; animate=true)

inverse(side :: HorizonSide) = HorizonSide(mod(Int(side)+2,4))
clockwise(side :: HorizonSide) = HorizonSide(mod(Int(side)+1,4))

function collect_in_arr(r :: Robot; count=true, side=Nord)
    arr=Array{HorizonSide}(undef,0)
    while !isborder(r,side) || !isborder(r,clockwise(side))
        if !isborder(r,side)  
            move!(r,side); arr=(inverse(side), arr...) end
        if !isborder(r,clockwise(side))  
            move!(r,clockwise(side)); arr=(inverse(clockwise(side)),arr...) end
    end
    if count 
        return arr end
end

function home!(r :: Robot, arr :: NTuple)
    for side in arr
        move!(r,side)
    end
end

function define_coordinates(r :: Robot, arr :: NTuple)
    x, y=0 ,0
    for side in arr
        if side==Ost x+=1 end
        if side==Sud y+=1 end
    end
    return x,y
end

function chess(r :: Robot)
    arr=collect_in_arr(r)
    x,y=define_coordinates(r,arr)
    critertia=mod(x+y,2)
    x,y =1 ,1
    side=Ost
    while true
        while !isborder(r,side)
            if mod(x+y,2)==critertia putmarker!(r) end
            move!(r,side)
            x+=1
        end
        if mod(x+y,2)==critertia putmarker!(r) end
        side=inverse(side)
        if isborder(r,Sud) break end
        move!(r,Sud)
        y+=1
    end
    collect_in_arr(r; count=false)
    home!(r,arr)
    
end

chess(r)