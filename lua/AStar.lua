local function Reconstruct (cameFrom, current)
    if not cameFrom[current] then return {current} end
    local list = Reconstruct (cameFrom, cameFrom[current])
    table.insert (list, current)
    return list
end

-- not really A*, lacks the heuristic function H
function AStar (start, end_)
    local closed = {}
    local open = {[start]=true}
    local cameFrom = {}
    local gScore = {[start]=0}

    while next (open) do
        local g = 777
        local C
        for v in pairs (open) do
            if gScore [v] < g then
                g = gScore [v]
                C = v
            end
        end
        if C == end_ then return Reconstruct (cameFrom, end_) end
        open[C] = nil
        closed[C] = true

        for N, F in pairs (C.links) do
            if F == true or F (World.turn.int + gScore[C]) then
                local tentative = gScore[C] + 1
                if not closed[N] or tentative < gScore[N] then
                    if not open[N] or tentative < gScore[N] then
                        cameFrom[N] = C
                        gScore[N] = tentative
                        open[N]=true
                    end
                end
            end
        end
    end

    return {}
end
