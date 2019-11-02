local function clear_biters(area, silent)
  local num = 0
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered({force="enemy", area=area})) do
      if entity.destroy() then num = num + 1 end
    end
  end

  if not silent then
    for _, force in pairs(game.forces) do force.rechart() end
    game.print({"command-output.biters_begone-init", num, {"command-output.biters_begone-wink-"..math.random(13)}})
  end
end

script.on_init(function()
  clear_biters()
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  if settings.global["rso-biter-generation"] and settings.global["rso-biter-generation"] then
    clear_biters(event.area, true)
  end
end)
