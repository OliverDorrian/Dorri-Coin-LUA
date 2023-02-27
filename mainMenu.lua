local composer = require("composer");
local scene = composer.newScene();
local physics = require("physics");
math.randomseed(os.time())
physics.start(true)
function genRndNumnber(high, low)
    return (math.random() * (high - low) + low)
end

local song1 = audio.loadStream("./songs/song2.mp3");
local song2 = audio.loadStream("./songs/song2.mp3");
local song3 = audio.loadStream("./songs/song3.mp3");

function playMusic(number)
    audio.setVolume(0.00);

    number = math.floor(number);
    if number == 1 then
        audio.play(song1, { channel = 1, loops = -1, fadein = 1000 });
        timer.performWithDelay(1000, function()
            playMusic(genRndNumnber(4, 1));
        end)
    elseif number == 2 then
        audio.play(song2, { channel = 1, loops = -1, fadein = 1000 });
        timer.performWithDelay(1000, function()
            playMusic(genRndNumnber(4, 1));
        end)
    elseif number == 3 then
        audio.play(song3, { channel = 1, loops = -1, fadein = 1000 });
        timer.performWithDelay(1000, function()
            playMusic(genRndNumnber(4, 1));
        end)
    end
end

playMusic(genRndNumnber(4, 1));


function scene:create(event)
    local sceneGroup = self.view;

    local titleScreen = display.newImage("./assets/backMain.gif", display.contentCenterX, display.contentCenterY);
    titleScreen.width = display.viewableContentWidth;
    titleScreen.height = display.safeActualContentHeight + 100;

    local playButton = display.newImage("./assets/titleText.png", display.contentCenterX, 0 + 50);
    playButton.width = display.contentWidth / 1;
    playButton:scale(0.7, 0.7);

    local startButton = display.newImage(sceneGroup, "./assets/startText.png", display.contentCenterX, 0 + 170);
    startButton.width = display.contentWidth / 1.2;
    startButton:scale(0.5, 0.5);

    startButton:addEventListener("touch", function(event)
        if event.phase == "began" then
            transition.to(startButton, { time = 100, xScale = 0.5, yScale = 0.6 })
        elseif event.phase == "ended" then
            transition.to(startButton, { time = 100, xScale = 0.5, yScale = 0.5 })
        end
    end)

    startButton:addEventListener("tap", function()
        composer.gotoScene("level1", { effect = "fade", time = 400 })
    end)


    local settingsButton = display.newImage(sceneGroup, "./assets/settingsText.png", display.contentCenterX, 0 + 220);
    settingsButton.width = display.contentWidth / 1.2;
    settingsButton:scale(0.5, 0.5);
    settingsButton:addEventListener("touch", function(event)
        if event.phase == "began" then
            transition.to(settingsButton, { time = 100, xScale = 0.5, yScale = 0.6 })
        elseif event.phase == "ended" then
            transition.to(settingsButton, { time = 100, xScale = 0.5, yScale = 0.5 })
        end
    end)
    settingsButton:addEventListener("tap", function()
        composer.gotoScene("settings", { effect = "fade", time = 400 })
    end)


    local creditsButton = display.newImage(sceneGroup, "./assets/creditsText.png", display.contentCenterX, 0 + 270);
    creditsButton.width = display.contentWidth / 1.2;
    creditsButton:scale(0.5, 0.5);
    creditsButton:addEventListener("touch", function(event)
        if event.phase == "began" then
            transition.to(creditsButton, { time = 100, xScale = 0.5, yScale = 0.6 })
        elseif event.phase == "ended" then
            transition.to(creditsButton, { time = 100, xScale = 0.5, yScale = 0.5 })
        end
    end)
    creditsButton:addEventListener("tap", function()
        composer.gotoScene("credits", { effect = "fade", time = 400 })
    end)

    local quitButton = display.newImage(sceneGroup, "./assets/quitText.png", display.contentCenterX, 0 + 320);
    quitButton.width = display.contentWidth / 1.2;
    quitButton:scale(0.4, 0.4);
    quitButton:addEventListener("touch", function(event)
        if event.phase == "began" then
            transition.to(quitButton, { time = 100, xScale = 0.5, yScale = 0.6 })
        elseif event.phase == "ended" then
            transition.to(quitButton, { time = 100, xScale = 0.5, yScale = 0.5 })
        end
    end)

    quitButton:addEventListener("tap", function()
        os.exit()
    end)

    tableOfCoins = {};

    function coinAtTop()
        local maskCoin = graphics.newMask("./assets/coinBig.png");

        local coin = display.newCircle(genRndNumnber(0, display.actualContentWidth), -140, 16);

        coin:setMask(maskCoin);
        coin:setFillColor(1, 0.7, 0);
        coin.maskScaleX = 0.5;
        coin.maskScaleY = 0.5;
        coin.opacity = 1;
        coin.rotation = genRndNumnber(0, 1);

        coin.width = 32 + 3;
        coin.height = 32 + 3;
        physics.addBody(coin, { density = 0.5, friction = 0.1, bounce = 0.4 })
        tableOfCoins[#tableOfCoins + 1] = coin;
    end

    function checkCoinRemoved()
        for i = 1, #tableOfCoins do
            if not tableOfCoins[i] then
            else
                if (tableOfCoins[i].y > 800 and tableOfCoins[i] ~= nil) then
                    tableOfCoins[i]:removeSelf();
                    tableOfCoins[i] = nil;
                end
            end
        end
    end

    sceneGroup:insert(titleScreen)
    sceneGroup:insert(playButton)
    sceneGroup:insert(startButton)
    sceneGroup:insert(settingsButton)
    sceneGroup:insert(creditsButton)
    sceneGroup:insert(quitButton)
end


function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then

    end

end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

    elseif (phase == "did") then
        
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

end

scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
scene:addEventListener("create", scene)

return scene