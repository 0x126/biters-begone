local function clear_biters(area, silent)
  local num = 0
  local expanded_area=nil
  
  if area then
    expanded_area = {}
    
    expanded_area["left_top"] = {}
    expanded_area["left_top"]["x"] = area.left_top.x - 64
    expanded_area["left_top"]["y"] = area.left_top.y - 64
    
    expanded_area["right_bottom"] = {}
    expanded_area["right_bottom"]["x"] = area.right_bottom.x + 64
    expanded_area["right_bottom"]["y"] = area.right_bottom.y + 64
  end
  
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered({force="enemy", area=expanded_area})) do
      if entity.destroy() then num = num + 1 end
    end
  end

  if not silent then
    game.print({"command-output.biters_begone-init", num, {"command-output.biters_begone-wink-"..math.random(13)}})

    for _, force in pairs(game.forces) do
      force.rechart()
    end
  end
end

script.on_init(function()
  clear_biters()
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  clear_biters(event.area, true)
end)
