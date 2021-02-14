local function clear_biters(area, silent)
  local num = 0
  local expanded_area=nil
  
  -- For chunks far from home, RSO has a very large area, so
  -- some created spawners and turrets escape unless we expand
  -- the area around the new chunk.
  if area then
    expanded_area = {}
    
    expanded_area["left_top"] = {}
    expanded_area["left_top"]["x"] = area.left_top.x - 32
    expanded_area["left_top"]["y"] = area.left_top.y - 32
    
    expanded_area["right_bottom"] = {}
    expanded_area["right_bottom"]["x"] = area.right_bottom.x + 32
    expanded_area["right_bottom"]["y"] = area.right_bottom.y + 32
  end
  
  for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered({force="enemy", type={"turret", "unit-spawner", "unit"}, area=expanded_area})) do
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
  -- an alternate approach would be to redefine the autoplace settings
  -- https://wiki.factorio.com/Console#Prevent_biters_being_on_newly_generated_chunks
  -- but that did not seem to work with RSO enabled
  --
  -- RSO creates entities without looking at the entity creation
  -- values.  This means that our data-final-fixes changes don't
  -- turn off biter spawning when RSO biter spawning is active.
  -- Therefore, we try to clear out any created entities in the
  -- RSO affected region.
  clear_biters(event.area, true)
end)

script.on_event(defines.events.on_chunk_charted, function(event)
  clear_biters(event.area, true)
end)

script.on_event(defines.events.on_entity_spawned, function(event)
  -- Of course, if a chunk is generated before it gets charted,
  -- that means the spawner might produce a biter.  As soon as
  -- that happens, we destroy both the spawner and the biter.
  event.spawner.destroy()
  event.entity.destroy()
end)

