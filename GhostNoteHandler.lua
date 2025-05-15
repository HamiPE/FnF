-- mods/yourMod/scripts/GFSingHandler.lua

-- Скрипт через JSON-персонажей и Haxe для анимации духов на ноте 'GF Sing'
-- Отвязан от позиции персонажей: духи появляются один раз в фиксированной позиции
local ghostOffsets = {
    bf  = { x = 830, y = -95 },
    dad = { x = 460, y = -75 }
}
local animDuration = 0.35
local singDirs   = {'LEFT','DOWN','UP','RIGHT'}
local blockAnims = {'blockLEFT','blockDOWN','blockUP','blockRIGHT'}

function onCreatePost()
    -- Регистрируем персонажей
    addCharacterToList('Echo', 'bf')
    addCharacterToList('Nunchuck', 'dad')
    -- Создаём Haxe-объекты духов на фиксированной позиции
    runHaxeCode([[        
        var echo = new Character(]] .. ghostOffsets.bf.x .. [[, ]] .. ghostOffsets.bf.y .. [[, 'Echo', true);
        echo.visible = false;
        game.add(echo);
        game.variables.set('echoGhost', echo);

        var nunchuck = new Character(]] .. ghostOffsets.dad.x .. [[, ]] .. ghostOffsets.dad.y .. [[, 'Nunchuck', false);
        nunchuck.visible = false;
        game.add(nunchuck);
        game.variables.set('nunchuckGhost', nunchuck);
    ]])
end

function goodNoteHit(id, direction, noteType, isSustain)
    if noteType == 'GF Sing' then
        local dirName = singDirs[direction+1]
        -- Анимация Echo без перемещения
        runHaxeCode(string.format([[            
            var g = game.variables.get('echoGhost');
            g.visible = true;
            g.playAnim('sing%s', true);
            g.specialAnim = true;
            game.remove(g);
            game.add(g);
        ]], dirName))

        setObjectOrder('boyfriendGroup', getObjectOrder('dadGroup') + 1)
        setObjectOrder('echoGhost', getObjectOrder('boyfriendGroup') + 1)

        triggerEvent('Play Animation', blockAnims[direction+1], 'Dad')
        setProperty('dad.specialAnim', true)

        runTimer('hideEchoGhost', animDuration)
        return Function_Stop
    end
end

function opponentNoteHit(id, direction, noteType, isSustain)
    if noteType == 'GF Sing' then
        local dirName = singDirs[direction+1]
        -- Анимация Nunchuck без перемещения
        runHaxeCode(string.format([[            
            var g = game.variables.get('nunchuckGhost');
            g.visible = true;
            g.playAnim('sing%s', true);
            g.specialAnim = true;
            game.remove(g);
            game.add(g);
        ]], dirName))

        setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') + 1)
        setObjectOrder('nunchuckGhost', getObjectOrder('dadGroup') + 1)

        triggerEvent('Play Animation', blockAnims[direction+1], 'BF')
        setProperty('boyfriend.specialAnim', true)

        runTimer('hideNunchuckGhost', animDuration)
        return Function_Stop
    end
end

function onTimerCompleted(tag)
    if tag == 'hideEchoGhost' then
        runHaxeCode([[ game.variables.get('echoGhost').visible = false; ]])
    elseif tag == 'hideNunchuckGhost' then
        runHaxeCode([[ game.variables.get('nunchuckGhost').visible = false; ]])
    end
end
