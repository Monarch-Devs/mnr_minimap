local function setupMapZooms()
    for _, lvl in ipairs(config.zoomLevels) do
        print(lvl.index, lvl.zoomScale, lvl.zoomSpeed, lvl.scrollSpeed, lvl.tilesX, lvl.tilesY)
        SetMapZoomDataLevel(lvl.index, lvl.zoomScale, lvl.zoomSpeed, lvl.scrollSpeed, lvl.tilesX, lvl.tilesY)
    end
end

local function radarLoop()
    SetRadarZoom(1000)
    DontTiltMinimapThisFrame()
end

CreateThread(function()
    setupMapZooms()
    while true do
        radarLoop()
        Wait(0)
    end
end)

if not config.removeBlur then return end

---@diagnostic disable-next-line: missing-parameter
RequestStreamedTextureDict('radar_masks')

while not HasStreamedTextureDictLoaded('radar_masks') do
    Wait(0)
end

AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', 'radar_masks', 'radarmasksm')
AddReplaceTexture('platform:/textures/graphics', 'radarmasklg', 'radar_masks', 'radarmasklg')
Wait(500)

SetBigmapActive(true, false)
Wait(0)
SetBigmapActive(false, false)
DisplayRadar(true)

if HasStreamedTextureDictLoaded('radar_masks') then
    SetStreamedTextureDictAsNoLongerNeeded('radar_masks')
end