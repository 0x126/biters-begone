function resetRichness(ent)
  if ent and ent.autoplace and ent.autoplace.force == "enemy" then
    ent.autoplace = nil
  end
end

function removeProbability(ent)
  if ent and ent.autoplace then
    ent.autoplace = nil
  end
end


for _, spawner in pairs(data.raw["unit-spawner"]) do
  removeProbability(spawner)
  resetRichness(spawner)
end

for _, turret in pairs(data.raw.turret) do
  if turret.subgroup == "enemies" then
    removeProbability(turret)
    resetRichness(turret)
  end
end
