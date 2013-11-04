core.Require ("Five")

function Loop ()
	UpdateTimers ()

	Five ()
	--Dach ()
	--Cosmos ()

    if KeyDown (KEY.Escape) then core.Halt () end
end

function UpdateTimers ()
    local newTime = core.Time ()
    Dt = newTime - (Time or 0)
    Time = newTime
end

