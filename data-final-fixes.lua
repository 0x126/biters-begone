for _, type in pairs(data.raw) do
  for _, prototype in pairs(type) do
    if prototype.autoplace and prototype.autoplace.force == "enemy" then
      prototype.autoplace.peaks = {}
    end
  end
end

