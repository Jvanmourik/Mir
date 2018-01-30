bgMusic = la.newSource("assets/audio/background.mp3", "static")
bgMusic:play()

efMusic = {}
  efMusic["dash1"] = la.newSource("assets/audio/dash1.wav")
  efMusic["dash2"] = la.newSource("assets/audio/dash2.wav")
  efMusic["dash3"] = la.newSource("assets/audio/dash3.wav")
  efMusic["dash4"] = la.newSource("assets/audio/dash4.wav")
  efMusic["dash5"] = la.newSource("assets/audio/dash5.wav")
  efMusic["dash6"] = la.newSource("assets/audio/dash6.wav")
  efMusic["drop"] = la.newSource("assets/audio/drop.wav")
  efMusic["dud"] = la.newSource("assets/audio/dud.wav")
  efMusic["firebeam"] = la.newSource("assets/audio/firebeam.wav")
  efMusic["hit"] = la.newSource("assets/audio/hit.wav")
  efMusic["hitarrow1"] = la.newSource("assets/audio/hitarrow1.wav")
  efMusic["hitarrow2"] = la.newSource("assets/audio/hitarrow2.wav")
  efMusic["hitdie1"] = la.newSource("assets/audio/hitdie1.wav")
  efMusic["hitdie2"] = la.newSource("assets/audio/hitdie2.wav")
  efMusic["hitdie3"] = la.newSource("assets/audio/hitdie3.wav")
  efMusic["hitdie4"] = la.newSource("assets/audio/hitdie4.wav")
  efMusic["hurt-01"] = la.newSource("assets/audio/hurt-01.wav")
  efMusic["hurt-02"] = la.newSource("assets/audio/hurt-02.wav")
  efMusic["hurt-03"] = la.newSource("assets/audio/hurt-03.wav")
  efMusic["lose-01"] = la.newSource("assets/audio/lose-01.wav")
  efMusic["lose-02"] = la.newSource("assets/audio/lose-02.wav")
  efMusic["lose-03"] = la.newSource("assets/audio/lose-03.wav")
  efMusic["power-01"] = la.newSource("assets/audio/power-01.wav")
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