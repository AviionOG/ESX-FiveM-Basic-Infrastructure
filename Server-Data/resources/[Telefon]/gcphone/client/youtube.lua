--
--  LEAKED BY S3NTEX -- 
--  https://discord.gg/aUDWCvM -- 
--  fivemleak.com -- 
--  fkn crew -- 
RegisterNUICallback('youtube_Play', function(data)
    exports['co_notify']:SendNotify('youtube', data, "true") --EKLENMESİ GEREKEN KOD!
end)

RegisterNUICallback('youtube_Pause', function()
    exports["xsound"]:Duraklat()
end)

RegisterNUICallback('youtube_Stop', function() 
    exports["xsound"]:Durdur()
end) 

RegisterNUICallback('youtube_Resume', function()
    exports["xsound"]:Devamet()
end)