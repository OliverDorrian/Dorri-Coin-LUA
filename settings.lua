local composer = require("composer")
local scene = composer.newScene()


function scene:create(event)
    local sceneGroup = self.view;

    local titleScreen = display.newImage("./assets/settingsBack.gif", display.contentCenterX, display.contentCenterY);
    titleScreen.width = display.viewableContentWidth;
    titleScreen.height = display.safeActualContentHeight;

    local playButton = display.newImage("./assets/settingsText.png", display.contentCenterX, 0 + 50);
    playButton.width = display.contentWidth / 1;
    playButton:scale(0.7, 0.7);

    local audioText = display.newText("Audio: On", display.contentCenterX, 0 + 150, "./assets/windows_command_prompt.ttf",
        30);

    audioOn = true;
    audioText:addEventListener("touch", function(event)
        if event.phase == "began" then
            if audioOn then
                audioText.text = "Audio: Off";
                audioOn = false;
                audio.setVolume(0.00, { channel = 1 });
            else
                audioText.text = "Audio: On";
                audioOn = true;
                audio.setVolume(0.40, { channel = 1 });
            end
        end
    end)

    returnButton = display.newImage("./assets/box.png", 0 + 70, display.actualContentHeight - 200)
    returnButton.width = 100;
    returnButton.height = 50;
    returnButton:setFillColor(0.71, 0.39, 0.11)

    local returnText = display.newText("Back", 0 + 70, display.actualContentHeight - 200, "./assets/windows_command_prompt.ttf",
        30);



    returnButton:addEventListener("touch", function(event)
        if event.phase == "began" then
            transition.to(returnButton, { time = 100, xScale = 1.1, yScale = 1 })
        elseif event.phase == "ended" then
            transition.to(returnButton, { time = 100, xScale = 1, yScale = 1})
        end
    end)

    returnButton:addEventListener("tap", function()
        composer.gotoScene("mainMenu", { effect = "fade", time = 400 })
    end)


    sceneGroup:insert(titleScreen);
    sceneGroup:insert(playButton);
    sceneGroup:insert(returnButton);
    sceneGroup:insert(returnText);
    sceneGroup:insert(audioText);
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene;