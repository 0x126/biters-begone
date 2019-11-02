local zeroExpression = {
    expression_id = "literal-number:1",
    literal_value = 0,
    type = "literal-number"
  }

function resetRichness(ent)
  if ent and ent.autoplace then
    ent.autoplace.richness_multiplier = null
    ent.autoplace.richness_expression = zeroExpression
    ent.autoplace.probability_expression = zeroExpression
  end
end

function removeProbability(ent)
  if ent and ent.autoplace then
    ent.autoplace.probability_expression = zeroExpression
  end
end

for _, spawner in pairs(data.raw["unit-spawner"]) do
  removeProbability(spawner)
end

for _, turret in pairs(data.raw.turret) do
  if turret.subgroup == "enemies" then
    removeProbability(turret)
  end
end
        
for _, type in pairs(data.raw) do
  for _, prototype in pairs(type) do
    if prototype.autoplace and prototype.autoplace.force == "enemy" then
      resetRichness(prototype)
      removeProbability(prototype)
    end
  end
end

