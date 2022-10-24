using HorizonSideRobots
r = Robot(8, 8; animate=true)


function chess(r)
    field = 0
    putmarker!(r)
    while isborder(r, HorizonSide(3)) == false
        move!(r, HorizonSide(3))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)

    while isborder(r, HorizonSide(1)) == false
        move!(r, HorizonSide(1))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)
    while isborder(r, HorizonSide(3)) == false
        move!(r, HorizonSide(3))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)

    while isborder(r, HorizonSide(1)) == false
        move!(r, HorizonSide(1))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)
    while isborder(r, HorizonSide(3)) == false
        move!(r, HorizonSide(3))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)

    while isborder(r, HorizonSide(1)) == false
        move!(r, HorizonSide(1))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)
    while isborder(r, HorizonSide(3)) == false
        move!(r, HorizonSide(3))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    field = 0
    move!(r, HorizonSide(0))
    putmarker!(r)

    while isborder(r, HorizonSide(1)) == false
        move!(r, HorizonSide(1))
        field += 1
        if field % 2 == 0
            putmarker!(r)
        end
    end
    
    while isborder(r, HorizonSide(2)) == false
        move!(r, HorizonSide(2))
    end
end

chess(r)