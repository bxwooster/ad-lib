function Selection (hovered)
    local selected = {}
    if hovered then
        local sector = hovered
        selected[sector] = colour.yellow
        if KeyDown (KEY.P1) then
            if not Start then
                Start = sector
            elseif not End then
                End = sector
            else
                Start = nil
                End = nil
                Path = nil
            end
        end
        for link, f in pairs (sector.links) do
            if f == true or f (World.turn.int) then
                selected[link] = colour.magenta
            end
        end
    end
    if Start and End and not Path then
        Path = AStar (Start, End)
    end
    if Path then
        local N = #Path
        for i, C in ipairs (Path) do
            local k = (i - 1) / (N - 1)
            selected[C] = colour.black * (1 - k) + colour.white * (k)
        end
    end
    if Start then selected[Start] = colour.black end
    if End then selected[End] = colour.white end
	return selected
end
