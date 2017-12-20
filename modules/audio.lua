bgMusic = la.newSource("assets/audio/background.mp3", "static")
bgMusic:play()

efMusic = {}
  efMusic["slash"] = la.newSource("assets/audio/slash.mp3")
  efMusic["step"] = la.newSource("assets/audio/step.wav")
  
  
----------------------------------------------
-- methods
----------------------------------------------
  
function bgVolume(volume)
  bgMusic:setVolume(volume)
end

function efVolume(volume)
  for i in pairs(efMusic) do
    efMusic[i]:setVolume(volume)
  end
end