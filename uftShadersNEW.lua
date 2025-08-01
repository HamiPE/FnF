local useOnGame = true
local useOnHUD = true

local floatMirrorActive = false
local floatMirrorStrength = 0
local floatMirrorTime = 0
local floatMirrorTweenZoom = true

local floatMirrorHUDActive = false
local floatMirrorHUDStrength = 0
local floatMirrorHUDTime = 0
local floatMirrorHUDTweenZoom = true

local function chaos(t)
    return math.sin(t*0.77 + math.cos(t*1.31)) + math.sin(t*1.83 + 2) * 0.5
end

local defaultX = 0                  -- 0 default
local defaultY = 0                  -- 0 default
local defaultAngle = 0              -- 0 default
local defaultZoom = 1               -- 1 default

local strength = 50                  -- 0 default
local size = 50                      -- 0 default
local red = 0                       -- 0 default
local green = 0                     -- 0 default
local blue = 0                      -- 0 default

local effect = 0                    -- 0 default
local strength = 1                  -- 1 default 
local contrast = 1                  -- 1 default
local brightness = 0                -- 0 default

local scale = 0                     -- 0 default

local amt = 0
local speed = 0

local chromatic = 0                 -- 0 default

local pixel = 1                     -- 0 default 

local intensity = 0                 -- 0 default
local gradient = 0                  -- 0 default

local xcoords = 0                   -- 0 default
local ycoords = 0                   -- 0 default    
local barrel = 0                    -- 0 default
local zoom = 1                      -- 1 default
local angle = 90                     -- 0 default
local doChroma = true               -- true default

local red = 0                       -- 0 default
local green = 0                     -- 0 default
local blue = 0                      -- 0 default         

local blur = 0                      -- 0 default
local blurY = 0                     -- 0 default
local vertical = true               -- true default

local iTime = 0                     -- 0 default

local smoke = 0                     -- 0 default
local wave = 0                      -- 0 default

function onCreatePost()
    initLuaShader('mirrorRepeat')
    makeLuaSprite('mirror', '', defaultX,defaultY)
    setSpriteShader('mirror', 'mirrorRepeat')
    setProperty('mirror.angle', defaultAngle)
    makeLuaSprite('mirrorZoom', '', defaultZoom,0)
    makeLuaSprite('mirrorHUD', '', 0, 0)
    setSpriteShader('mirrorHUD', 'mirrorRepeat')
    makeLuaSprite('mirrorHUDZoom', '', 1, 0)
    setProperty('mirrorHUD.x', 0)
    setProperty('mirrorHUD.y', 0)
    setProperty('mirrorHUD.angle', 0)
    setProperty('mirrorHUDZoom.x', 1)

    makeLuaSprite('bloomEffect', '', effect,0)
    makeLuaSprite('bloomStrength', '', strength,0)
    makeLuaSprite('bloomContrast', '', contrast,0)
    makeLuaSprite('bloomBrightness', '', brightness,0)

    makeLuaSprite('BlurEffect', '', blur,0)
    makeLuaSprite('BlurEffectY', '', blurY,0)
    makeLuaSprite('BlurVertical', '', vertical,true)

    makeLuaSprite('BarrelBlurEffect', '', barrel,0)
    makeLuaSprite('BarrelBlurZoom', '', zoom,1)
    makeLuaSprite('BarrelBlurChroma', '', doChroma,true)
    makeLuaSprite('BarrelBlur', '', angle,0)
    makeLuaSprite('BarrelBlurY', '', ycoords,0)
    makeLuaSprite('BarrelBlurX', '', xcoords,0)
	
	makeLuaSprite('ChromAbEffect', '', chromatic,0)

    makeLuaSprite('MosaicEffect', '', pixel,0)

    makeLuaSprite('greyScale', '', scale,0)

    makeLuaSprite('SobelIntensity', '', intensity,0)
    makeLuaSprite('SobelEffect', '', gradient,0)

    makeLuaSprite('ColorOverrideRed', '', red,0)
    makeLuaSprite('ColorOverrideGreen', '', green,0)
    makeLuaSprite('ColorOverrideBlue', '', blue,0)

    makeLuaSprite('PerlinSmokeSmoke', '', smoke,7)
    makeLuaSprite('PerlinSmokeWave', '', wave,0.004)

    makeLuaSprite('Vignette', '', strength,0)
    makeLuaSprite('VignetteSize', '', size,0)
    makeLuaSprite('VignetteRed', '', red,0)
    makeLuaSprite('VignetteGreen', '', green,0)
    makeLuaSprite('VignetteBlue', '', blue,0)

    makeLuaSprite('gtime', '', os.clock(),0)
    makeLuaSprite('gamt', '', amt,0)
    makeLuaSprite('gspeed', '', speed,0)

    -- shader
    makeLuaSprite('chessBG','chessBG',0,0)
    setProperty('chessBG.alpha', 0.00001)
    setProperty('chessBG.scale.x', 2)
    setProperty('chessBG.scale.y', 2)
    setScrollFactor('chessBG', 0, 0)
    addLuaSprite('chessBG', false)

    -- Lua Shader scroll2 (анимация фона)
    initLuaShader("scroll2")
    setSpriteShader('chessBG', 'scroll2')
    setShaderFloat("chessBG", "timeMulti", 0.02)
    setShaderFloat("chessBG", "xSpeed", 15)
    setShaderFloat("chessBG", "ySpeed", 0)

    runHaxeCode('game.variables["mirrorRepeat"] = game.modchartSprites.get("mirror").shader;')
    runHaxeCode('game.variables["mirrorRepeatHUD"] = game.modchartSprites.get("mirrorHUD").shader;')
    runHaxeCode('game.variables["bloomEffect"] = game.createRuntimeShader("bloom");')
    runHaxeCode('game.variables["greyScale"] = game.createRuntimeShader("greyScale");')
    runHaxeCode('game.variables["ChromAbEffect"] = game.createRuntimeShader("ChromAbEffect");')
    runHaxeCode('game.variables["MosaicEffect"] = game.createRuntimeShader("MosaicEffect");')
    runHaxeCode('game.variables["SobelEffect"] = game.createRuntimeShader("SobelEffect");')
    runHaxeCode('game.variables["BlurEffect"] = game.createRuntimeShader("BlurEffect");')
    runHaxeCode('game.variables["ColorOverrideEffect"] = game.createRuntimeShader("ColorOverrideEffect");')
    runHaxeCode('game.variables["BarrelBlurEffect"] = game.createRuntimeShader("BarrelBlurEffect");')
    runHaxeCode('game.variables["PerlinSmokeEffect"] = game.createRuntimeShader("PerlinSmokeEffect");')
    runHaxeCode('game.variables["weird"] = game.createRuntimeShader("weird");')
    runHaxeCode('game.variables["vcrshader"] = game.createRuntimeShader("vcrshader");')
    runHaxeCode('game.variables["VignetteEffect"] = game.createRuntimeShader("VignetteEffect");')
    runHaxeCode('game.variables["glitchy"] = game.createRuntimeShader("Glitchy");')
    runHaxeCode('game.variables["chess"] = game.createRuntimeShader("chess");')
    runHaxeCode('game.variables["heat"] = game.createRuntimeShader("heat");')
    if useOnGame then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
    end
    if useOnHUD then
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
    end
    updateShader()
end

function updateShader()
    setShaderFloat('mirror', 'x', getProperty('mirror.x'))
    setShaderFloat('mirror', 'y', getProperty('mirror.y'))
    setShaderFloat('mirror', 'angle', getProperty('mirror.angle'))
    setShaderFloat('mirror', 'zoom', getProperty('mirrorZoom.x'))

setShaderFloat('mirrorHUD', 'x', getProperty('mirrorHUD.x'))
setShaderFloat('mirrorHUD', 'y', getProperty('mirrorHUD.y'))
setShaderFloat('mirrorHUD', 'angle', getProperty('mirrorHUD.angle'))
setShaderFloat('mirrorHUD', 'zoom', getProperty('mirrorHUDZoom.x'))

    setShaderFloat('mirrorHUD', 'mirrorDensity', 1.5)

    runHaxeCode('game.variables["VignetteEffect"].setFloat("strength", '..(getProperty('Vignette.x'))..');')
    runHaxeCode('game.variables["VignetteEffect"].setFloat("size", '..(getProperty('VignetteSize.x'))..');')
    runHaxeCode('game.variables["VignetteEffect"].setFloat("red", '..(getProperty('VignetteRed.x'))..');')
    runHaxeCode('game.variables["VignetteEffect"].setFloat("green", '..(getProperty('VignetteGreen.x'))..');')
    runHaxeCode('game.variables["VignetteEffect"].setFloat("blue", '..(getProperty('VignetteBlue.x'))..');')

    runHaxeCode('game.variables["bloomEffect"].setFloat("effect", '..(getProperty('bloomEffect.x'))..');')
    runHaxeCode('game.variables["bloomEffect"].setFloat("strength", '..(getProperty('bloomStrength.x'))..');')
    runHaxeCode('game.variables["bloomEffect"].setFloat("contrast", '..(getProperty('bloomContrast.x'))..');')
    runHaxeCode('game.variables["bloomEffect"].setFloat("brightness", '..(getProperty('bloomBrightness.x'))..');')

    runHaxeCode('game.variables["greyScale"].setFloat("strength", '..(getProperty('greyScale.x'))..');')

    runHaxeCode('game.variables["BarrelBlurEffect"].setFloat("barrel", '..(getProperty('BarrelBlurEffect.x'))..');')
    runHaxeCode('game.variables["BarrelBlurEffect"].setFloat("zoom", '..(getProperty('BarrelBlurZoom.x'))..');')
    runHaxeCode('game.variables["BarrelBlurEffect"].setBool("doChroma", '..(getProperty('BarrelBlurChroma.x'))..');')
    runHaxeCode('game.variables["BarrelBlurEffect"].setFloat("angle", '..(getProperty('BarrelBlur.angle'))..');')
    runHaxeCode('game.variables["BarrelBlurEffect"].setFloat("x", '..(getProperty('BarrelBlurX.x'))..');')
    runHaxeCode('game.variables["BarrelBlurEffect"].setFloat("y", '..(getProperty('BarrelBlurY.y'))..');')
	
	runHaxeCode('game.variables["ChromAbEffect"].setFloat("strength", '..(getProperty('ChromAbEffect.x'))..');')

    runHaxeCode('game.variables["MosaicEffect"].setFloat("strength", '..(getProperty('MosaicEffect.x'))..');')

    runHaxeCode('game.variables["SobelEffect"].setFloat("strength", '..(getProperty('SobelEffect.x'))..');')
    runHaxeCode('game.variables["SobelEffect"].setFloat("intensity", '..(getProperty('SobelIntensity.x'))..');')

    runHaxeCode('game.variables["ColorOverrideEffect"].setFloat("red", '..(getProperty('ColorOverrideRed.x'))..');')
    runHaxeCode('game.variables["ColorOverrideEffect"].setFloat("green", '..(getProperty('ColorOverrideGreen.x'))..');')
    runHaxeCode('game.variables["ColorOverrideEffect"].setFloat("blue", '..(getProperty('ColorOverrideBlue.x'))..');')

    runHaxeCode('game.variables["BlurEffect"].setFloat("strengthX", '..(getProperty('BlurEffect.x'))..');')
    runHaxeCode('game.variables["BlurEffect"].setFloat("strengthY", '..(getProperty('BlurEffectY.y'))..');')
    runHaxeCode('game.variables["BlurEffect"].setBool("vertical", '..(getProperty('BlurVertical.x'))..');')

    runHaxeCode('game.variables["PerlinSmokeEffect"].setFloat("waveStrength", '..(getProperty('PerlinSmokeWave.x'))..');')
    runHaxeCode('game.variables["PerlinSmokeEffect"].setFloat("smokeStrength", '..(getProperty('PerlinSmokeSmoke.x'))..');')
    runHaxeCode('game.variables["PerlinSmokeEffect"].setFloat("iTime", '..iTime..');')

    runHaxeCode('game.variables["glitchy"].setFloat("iTime", '..(getProperty('gtime.x'))..');')
    runHaxeCode('game.variables["glitchy"].setFloat("AMT", '..(getProperty('gamt.x'))..');')
    runHaxeCode('game.variables["glitchy"].setFloat("SPEED", '..(getProperty('gspeed.x'))..');')

    runHaxeCode('game.variables["heat"].setFloat("iTime", ' .. os.clock() .. ');')
end

function onUpdate(elapsed)
    setProperty("gtime.x", os.clock())
    updateShader()

    if floatMirrorActive then
        floatMirrorTime = floatMirrorTime + elapsed
        local s = floatMirrorStrength

        local x = chaos(floatMirrorTime * 0.6) * 0.08 * s
        local y = math.sin(floatMirrorTime * 0.5) * 0.08 * s
        local a = chaos(floatMirrorTime) * 3 * s

        setProperty('mirror.x', x)
        setProperty('mirror.y', y)
        setProperty('mirror.angle', a)

        if floatMirrorTweenZoom then
            setProperty('mirrorZoom.x', 1 + math.sin(floatMirrorTime * 0.7) * 0.03 * s)
        end
    end

    if floatMirrorHUDActive then
        floatMirrorHUDTime = floatMirrorHUDTime + elapsed
        local s = floatMirrorHUDStrength

        local x = chaos(floatMirrorHUDTime * 0.7) * 0.07 * s
        local y = math.sin(floatMirrorHUDTime * 0.4) * 0.07 * s
        local a = chaos(floatMirrorHUDTime) * 3 * s

        setProperty('mirrorHUD.x', x)
        setProperty('mirrorHUD.y', y)
        setProperty('mirrorHUD.angle', a)

        if floatMirrorHUDTweenZoom then
            setProperty('mirrorHUDZoom.x', 1 + math.sin(floatMirrorHUDTime * 0.9) * 0.03 * s)
        end
    end

    setShaderFloat("chessBG", "iTime", os.clock())
    setShaderFloat("chessBG", "alpha", targetAlpha)

    iTime = iTime + 0.01
    runHaxeCode('game.variables["vcrshader"].setFloat("iTime", '..os.clock()..');')
end

function onEvent(eventName, value1, value2)
    if eventName == 'mirrorBeat' then
        setProperty('mirrorZoom.x', 0.85)
        doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.4, 'cubeOut')
    end

    if eventName == 'BLASTOUTMirrorJump' then
        doTweenX('mirrorZoom', 'mirrorZoom', 1.4, 0.1, 'cubeOut')

            runTimer('wamBam', 0.1)
            function onTimerCompleted(tag, loops, loopsLeft)
            if tag == 'wamBam' then
                doTweenAngle('mirrorAngle', 'mirror', 20, 0.19, 'cubeIn')
                doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.19, 'cubeIn')
                runTimer('schwamNam', 0.19)
            end
            if tag == 'schwamNam' then
                setProperty('mirrorZoom.x', 0.9)
                doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.19, 'cubeOut')
                doTweenAngle('mirrorAngle', 'mirror', 0, 0.19, 'cubeOut')
            end
        end
    end

    if eventName == 'BLASTOUTMirrorJumpReversed' then
        doTweenX('mirrorZoom', 'mirrorZoom', 1.4, 0.1, 'cubeOut')

            runTimer('wamBam', 0.1)
            function onTimerCompleted(tag, loops, loopsLeft)
            if tag == 'wamBam' then
                doTweenAngle('mirrorAngle', 'mirror', -20, 0.19, 'cubeIn')
                doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.19, 'cubeIn')
                runTimer('schwamNam', 0.19)
            end
            if tag == 'schwamNam' then
                setProperty('mirrorZoom.x', 0.9)
                doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.19, 'cubeOut')
                doTweenAngle('mirrorAngle', 'mirror', 0, 0.38, 'cubeOut')
            end
        end
    end

    if eventName == 'bblurBeat' then
        setProperty('BarrelBlurEffect.x', value1)
        doTweenX('BarrelBlurEffect', 'BarrelBlurEffect', 0, 0.3)
        cameraShake('camGame', 0.005, 0.15)
    end
	
	if eventName == 'ChromBeat' then
		setProperty('ChromAbEffect.x', 0.012)
		doTweenX('ChromAbEffect', 'ChromAbEffect', 0, 0.4, 'cubeOut')
	end
	
	if eventName == 'ChromAbEffect' then 
		doTweenX('ChromAbEffect', 'ChromAbEffect', value1, value2, 'cubeOut')
	end
    
    if eventName == 'BlurEffect' then
        doTweenX('BlurEffect', 'BlurEffect', value1, value2, 'cubeOut')
        doTweenY('BlurEffectY', 'BlurEffectY', value1, value2, 'cubeOut')
    end

    -- MirrorFloat (camGame)
    if name == 'MirrorFloat' then
        local str, opt = tostring(value1):match('([^,]+),?%s*(.*)')
        local strength = tonumber(str) or 1
        local noZoom = (opt and opt:lower() == 'nozoom')

        if strength > 0 then
            floatMirrorActive = true
            floatMirrorStrength = strength
            floatMirrorTweenZoom = not noZoom
            floatMirrorTime = 0
        else
            floatMirrorActive = false
            setProperty('mirror.x', 0)
            setProperty('mirror.y', 0)
            setProperty('mirror.angle', 0)
            -- Зум не трогаем!
        end
    end

    -- MirrorFloat (camGame)
    if name == 'MirrorFloat' then
        local strength, opt = tostring(value1):match('([^,]+),?%s*(.*)')
        strength = tonumber(strength) or 1
        local noZoom = (opt ~= nil and opt:lower() == 'nozoom')

        if strength > 0 then
            floatMirrorActive = true
            floatMirrorStrength = strength
            floatMirrorTweenZoom = not noZoom
            floatMirrorTime = 0
        else
            floatMirrorActive = false
            setProperty('mirror.x', 0)
            setProperty('mirror.y', 0)
            setProperty('mirror.angle', 0)
            -- Зум не трогаем!
        end
    end

    -- MirrorFloatHud (camHUD)
    if name == 'MirrorFloatHud' then
        local strength, opt = tostring(value1):match('([^,]+),?%s*(.*)')
        strength = tonumber(strength) or 1
        local noZoom = (opt ~= nil and opt:lower() == 'nozoom')

        if strength > 0 then
            floatMirrorHUDActive = true
            floatMirrorHUDStrength = strength
            floatMirrorHUDTweenZoom = not noZoom
            floatMirrorHUDTime = 0
        else
            floatMirrorHUDActive = false
            setProperty('mirrorHUD.x', 0)
            setProperty('mirrorHUD.y', 0)
            setProperty('mirrorHUD.angle', 0)
            -- Зум не трогаем!
        end
    end

    if eventName == 'BlurSnap' then
        setProperty('BlurEffect.x', 10)
        setProperty('BlurEffectY.y', 10)
        doTweenX('BlurEffect', 'BlurEffect', 0, value1, 'cubeOut')
        doTweenY('BlurEffectY', 'BlurEffectY', 0, value1, 'cubeOut')
    end

    if eventName == 'BlurBeat' then
        setProperty('BlurEffect.x', 4.5)
        setProperty('BlurEffectY.y', 4.5)
        doTweenX('BlurEffect', 'BlurEffect', 0, 0.4, 'cubeOut')
        doTweenY('BlurEffectY', 'BlurEffectY', 0, 0.4, 'cubeOut')
        setProperty('mirrorZoom.x', 0.85)
        doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.4, 'cubeOut')
    end

    if eventName == 'BlurBeat2' then
        setProperty('BlurEffect.x', 7.5)
        setProperty('BlurEffectY.y', 7.5)
        doTweenX('BlurEffect', 'BlurEffect', 0, 0.6, 'cubeOut')
        doTweenY('BlurEffectY', 'BlurEffectY', 0, 0.6, 'cubeOut')
        setProperty('mirrorZoom.x', 0.7)
        doTweenX('mirrorZoom', 'mirrorZoom', 1, 0.7, 'cubeOut')
    end

    if eventName == 'BlurBeatNoZoom' then
        setProperty('BlurEffect.x', 4.5)
        setProperty('BlurEffectY.y', 4.5)
        doTweenX('BlurEffect', 'BlurEffect', 0, 0.4, 'cubeOut')
        doTweenY('BlurEffectY', 'BlurEffectY', 0, 0.4, 'cubeOut')
        triggerEvent('Add Camera Zoom', '0.075', '0.15')
    end

    if eventName == 'FadeScreenIn' then
        doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 0, value1, 'cubeOut')
        doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 0, value1, 'cubeOut')
        doTweenX('ColorOverrideRed', 'ColorOverrideRed', 0, value1, 'cubeOut')
    end

    if eventName == 'FadeScreenOut' then
        doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value1, 'cubeIn')
        doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value1, 'cubeIn')
        doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value1, 'cubeIn')
    end

    if eventName == 'BarrelBlur' then
        doTweenX('BarrelBlurEffect', 'BarrelBlurEffect', value1, value2, 'cubeOut')
        setProperty('BarrelBlurChroma.x', true)
    end

    if eventName == 'BarrelBlurNoChroma' then
        doTweenX('BarrelBlurEffect', 'BarrelBlurEffect', value1, value2, 'cubeOut')
        setProperty('BarrelBlurChroma.x', false)
    end

    if eventName == 'BarrelBlurTransition' then
        setProperty('BarrelBlurEffect.x', 25)
        setProperty('BarrelBlurChroma.x', true)

        doTweenX('BarrelBlurEffect', 'BarrelBlurEffect', 0, value1, 'cubeOut')
    end
	
    if eventName == 'MosaicEffect' then
        doTweenX('MosaicEffect', 'MosaicEffect', value1, value2, 'cubeOut')
    end
    
    if eventName == 'SobelEffect' then
        doTweenX("SobelEffect", "SobelEffect", value1, value2, "linear")
        doTweenX("SobelIntensity", "SobelIntensity", value1, value2, "linear")
    end

    if eventName == 'SobelFlash' then
        setProperty('SobelEffect.x', 1)
        setProperty('SobelIntensity.x', 2)


        doTweenX("SobelEffect", "SobelEffect", 0, value1, "cubeOut")
        doTweenX("SobelIntensity", "SobelIntensity", 0, 1, "cubeOut")
    end

    if eventName == 'greyScale' then
        doTweenX('greyScale', 'greyScale', value1, value2, 'linear')
    end

    if eventName == 'bloomHigh' then
		setProperty('bloomEffect.x', 0.8)
		setProperty('bloomStrength.x', 1.6)

        doTweenX("bloomEffect", "bloomEffect", 0, value1, "linear")
        doTweenX("bloomStrength", "bloomStrength", 0, value1, "linear")
    end

    if eventName == 'bloomMed' then
        setProperty('bloomEffect.x', 0.5)
        setProperty('bloomStrength.x', 1.3)

        doTweenX("bloomEffect", "bloomEffect", 0, value1, "linear")
        doTweenX("bloomStrength", "bloomStrength", 0, value1, "linear")
    end

    if eventName == 'bloomLow' then
        setProperty('bloomEffect.x', 0.2)
        setProperty('bloomStrength.x', 1)

        doTweenX("bloomEffect", "bloomEffect", 0, value1, "linear")
        doTweenX("bloomStrength", "bloomStrength", 0, value1, "linear")
    end

if eventName == 'glitch' then
   setProperty("gamt.x", value1)
   setProperty("gspeed.x", value2)
    end

      if eventName == 'chess' then

        -- Альфа: value1
        local alpha = tonumber(value1) or 0.35

        -- value2 парсим: xSpeed,ySpeed,tweenTime
        local parts = {}
        for str in string.gmatch(value2 or "", "([^,]+)") do
            table.insert(parts, str)
        end

        local xSpd = tonumber(parts[1]) or 15
        local ySpd = tonumber(parts[2]) or 0
        local tweenTime = tonumber(parts[3]) or 0.4

        -- Шейдер-параметры
        setShaderFloat("chessBG", "xSpeed", xSpd)
        setShaderFloat("chessBG", "ySpeed", ySpd)
        setShaderFloat("chessBG", "timeMulti", 0.02)

        -- Прозрачность
        doTweenAlpha("chess_alpha", "chessBG", alpha, tweenTime, "linear")
    end

    if eventName == 'bloomEffect' then
        doTweenX("bloomEffect", "bloomEffect", 0.2, value1, "cubeIn")
        doTweenX("bloomStrength", "bloomStrength", 1, value1, "cubeIn")
    end

    if eventName == 'Vignette' then
        doTweenX('Vignette', 'Vignette', value1, value2, 'linear')
        doTweenX('VignetteSize', 'VignetteSize', value1, value2, 'linear')
    end

    if eventName == 'ColorOverride' then
        if value1 == '0' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '1' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 0.6, value2, 'cubeOut')
        end

        if value1 == '2' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 0.6, value2, 'cubeOut')
        end

        if value1 == '3' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1.2, value2, 'cubeOut')
        end

        if value1 == '4' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 0.6, value2, 'cubeOut')
        end

        if value1 == '5' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1.2, value2, 'cubeOut')
        end

        if value1 == '6' then
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1.2, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 0.6, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1.2, value2, 'cubeOut')
        end

    end

    if eventName == 'ColorOverrideFlash' then

        if value1 == '1' then
            setProperty('ColorOverrideGreen.x', 0.6)
            setProperty('ColorOverridenBlue.x', 1.2)
            setProperty('ColorOverrideRed.x', 0.6)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '2' then
            setProperty('ColorOverrideGreen.x', 1.2)
            setProperty('ColorOverridenBlue.x', 0.6)
            setProperty('ColorOverrideRed.x', 0.6)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '3' then
            setProperty('ColorOverrideGreen.x', 0.6)
            setProperty('ColorOverridenBlue.x', 0.6)
            setProperty('ColorOverrideRed.x', 1.2)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '4' then
            setProperty('ColorOverrideGreen.x', 1.2)
            setProperty('ColorOverridenBlue.x', 1.2)
            setProperty('ColorOverrideRed.x', 0.6)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '5' then
            setProperty('ColorOverrideGreen.x', 0.6)
            setProperty('ColorOverridenBlue.x', 1.2)
            setProperty('ColorOverrideRed.x', 1.22)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end

        if value1 == '6' then
            setProperty('ColorOverrideGreen.x', 1.2)
            setProperty('ColorOverridenBlue.x', 0.6)
            setProperty('ColorOverrideRed.x', 1.2)
            doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, value2, 'cubeOut')
            doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, value2, 'cubeOut')
        end
    end


    if eventName == 'RainbowShit' then
        doTweenX('colorR', 'ColorOverrideRed', 1.2, 0.75, 'linear') --this starts the cycle

        function onTweenCompleted(tag)
            if tag == 'colorR' then
                doTweenX('colorRG', 'ColorOverrideGreen', 1.2, 0.75, 'linear')
            end
            if tag == 'colorRG' then
                doTweenX('colorG', 'ColorOverrideRed', 0.5, 0.75, 'linear')
            end
            if tag == 'colorG' then
                doTweenX('colorGB', 'ColorOverrideBlue', 1.2, 0.75, 'linear')
            end
            if tag == 'colorGB' then
                doTweenX('colorB', 'ColorOverrideGreen', 0.5, 0.75, 'linear')
            end
            if tag == 'colorB' then
                doTweenX('colorBR', 'ColorOverrideRed', 1.2, 0.75, 'linear')
            end
            if tag == 'colorBR' then
                doTweenX('colorR', 'ColorOverrideBlue', 0.5, 0.75, 'linear')
            end
            if tag == 'colordone' then
                doTweenX('colordone1', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorR', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorRG', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorG', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorGB', 'ColorOverrideBlue', 1, 0.2, 'linear')
                doTweenX('colorB', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorBR', 'ColorOverrideRed', 1, 0.2, 'linear')
            end
            if tag == 'colordone1' then
                doTweenX('colordone2', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorR', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorRG', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorG', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorGB', 'ColorOverrideBlue', 1, 0.2, 'linear')
                doTweenX('colorB', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorBR', 'ColorOverrideRed', 1, 0.2, 'linear')
            end
            if tag == 'colordone2' then
                doTweenX('colordone', 'ColorOverrideBlue', 1, 0.2, 'linear')
                doTweenX('colorR', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorRG', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorG', 'ColorOverrideRed', 1, 0.2, 'linear')
                doTweenX('colorGB', 'ColorOverrideBlue', 1, 0.2, 'linear')
                doTweenX('colorB', 'ColorOverrideGreen', 1, 0.2, 'linear')
                doTweenX('colorBR', 'ColorOverrideRed', 1, 0.2, 'linear')
            end
        end
        if value1 == 'on' then
            doTweenX('colorR', 'ColorOverrideRed', 1.2, 0.2, 'linear')
        end
        if value1 == 'off' then
            doTweenX('colordone', 'ColorOverrideRed', 1, 0.2, 'linear')
            doTweenX('colordone1', 'ColorOverrideGreen', 1, 0.2, 'linear')
            doTweenX('colordone2', 'ColorOverrideBlue', 1, 0.2, 'linear')
        end
    end

    if eventName == 'crazyshader' then
        if value1 == 'glitch' then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"])]);')  
        end

        if value1 == 'cool' then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["weird"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["weird"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        end

        if value1 == 'heat' then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["heat"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["heat"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')       
        end

        if value1 == 'vcr' then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["vcrshader"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["chess"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["vcrshader"]), new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')  
        end

        if value1 == 'statichud' then
            runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
            runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        end

        if value1 == 'nomorecool' then
        runHaxeCode('game.camGame.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')
        runHaxeCode('game.camHUD.setFilters([new ShaderFilter(game.variables["greyScale"]), new ShaderFilter(game.variables["ChromAbEffect"]), new ShaderFilter(game.variables["mirrorRepeatHUD"]), new ShaderFilter(game.variables["PerlinSmokeEffect"]), new ShaderFilter(game.variables["bloomEffect"]), new ShaderFilter(game.variables["MosaicEffect"]), new ShaderFilter(game.variables["ColorOverrideEffect"]), new ShaderFilter(game.variables["mirrorRepeat"]), new ShaderFilter(game.variables["BarrelBlurEffect"]), new ShaderFilter(game.variables["SobelEffect"]), new ShaderFilter(game.variables["glitchy"]), new ShaderFilter(game.variables["BlurEffect"]), new ShaderFilter(game.variables["VignetteEffect"])]);')       
        end
    end
end

function onStepHit()
    if curStep == 1 then
        doTweenX('ColorOverrideGreen', 'ColorOverrideGreen', 1, 0.1, 'linear')
        doTweenX('ColorOverrideBlue', 'ColorOverrideBlue', 1, 0.1, 'linear')
        doTweenX('ColorOverrideRed', 'ColorOverrideRed', 1, 0.1, 'linear')
        doTweenX('Vignette', 'Vignette', 0, 0.3, 'linear')
        doTweenX('VignetteSize', 'VignetteSize', 0, 0.3, 'linear')
    end
end