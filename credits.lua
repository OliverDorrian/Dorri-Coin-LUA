local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view;

    local background = display.newImage("./assets/creditsBackground.gif", display.contentCenterX, display.contentCenterY);
    background.width = display.viewableContentWidth;
    background.height = display.safeActualContentHeight;


    local creditsTitle = display.newImage("./assets/creditText.png", display.contentCenterX, 0 + 50);
    creditsTitle.width = display.contentWidth / 1;
    creditsTitle:scale(0.7, 0.7);

    local creditsText = display.newImage("./assets/madeByText.png", display.contentCenterX, 0 + 150);
    creditsText.width = display.contentWidth / 1;
    creditsText:setFillColor(1, 1, 1);
    creditsText:scale(0.6, 0.6);

    local creditsText2 = display.newImage("./assets/oliverDorrainTexr.png", display.contentCenterX, 0 + 200);
    creditsText2.width = display.contentWidth / 0.7;
    creditsText2:scale(0.6, 0.6);

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
            transition.to(returnButton, { time = 100, xScale = 1, yScale = 1 })
        end
    end)

    returnButton:addEventListener("tap", function()
        composer.gotoScene("mainMenu", {effect = "fade", time = 400})
    end)

    sceneGroup:insert(background)
    sceneGroup:insert(creditsTitle)
    sceneGroup:insert(creditsText)
    sceneGroup:insert(creditsText2)
    sceneGroup:insert(returnButton)
    sceneGroup:insert(returnText)

end

scene:addEventListener("create", scene)

return scene