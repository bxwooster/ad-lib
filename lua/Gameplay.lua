function DoTurn ()
	local T = World.turn
    local duration = 2
    local left = T.endTime - Time
    if left > 0 then
        T.float = T.int - left / duration
    elseif KeyDown (KEY.Space) then
        T.int = T.int + 1
        T.endTime = Time + duration
    end
end
