using HorizonSideRobots
r = Robot("11task/11task_right.sit", animate=true)


inverse( side :: HorizonSide) = HorizonSide(mod(Int(side)+2,4))

function collect_in_arr( r :: Robot; track=false )
    arr=()
    while !isborder(r,Sud) || !isborder(r,West)
        if !isborder(r,Sud) 
            move!(r,Sud) 
            arr=(Nord,arr...) 
        end
        if !isborder(r,West) 
            move!(r,West)
            arr=(Ost,arr...) 
        end
    end
    if track 
        return arr end
end

home!(r :: Robot, arr :: NTuple)=for side in arr move!(r,side) end

function count!( r :: Robot, side :: HorizonSide)
    flag=false; c=0
    while !isborder(r,side)
        if isborder(r,Nord)
            if !flag flag=true; c+=1 end
        else
            flag=false
        end
        move!(r,side)
    end
    return c
end

function countbords!(r :: Robot)
    wayhome=collect_in_arr(r; track=true); side=Ost; c=0
    while !isborder(r,Nord) && !isborder(r,side)
        c+=count!(r,side)
        side=inverse(side)
        move!(r,Nord)
    end
    collect_in_arr(r)
    home!(r,wayhome)
    println(c)
end

countbords!(r)