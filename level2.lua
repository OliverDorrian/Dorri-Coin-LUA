local composer = require("composer");
local widget = require("widget")
local scene = composer.newScene();
local physics = require("physics");
math.randomseed(os.time())
physics.start(true)


function genRndNumnber(high, low)
    return (math.random() * (high - low) + low)
end

function rotatreObject(object)
    return function()
        object.rotation = object.rotation + 3;
    end
end

totalMoney = 1000;

costOfSpawnRate = 40;
spawnReduction = 10000;
timePerSpawn = 3000;


coinValueIncrease = 0.5;
costOfCoinValue = 40;
moneyPerCoin = 1;


costOfSize = 40;
sizeReduction = 0;


costOfNextLevel = 1000;

function scene:create(event)
    local sceneGroup = self.view;

    local background = display.newImage("./assets/settingsBack.gif", display.contentCenterX, display.contentCenterY);
    background.width = display.viewableContentWidth;
    background.height = display.safeActualContentHeight + 100;
    sceneGroup:insert(background);

    local button4 = display.newImage("./assets/box2.png", 270, 0 - 70)
    button4:setFillColor(1, 1, 0);
    button4.width = 90;
    button4.height = 50;

    local function button4Listener(event)
        if (totalMoney >= costOfNextLevel) then
            composer.gotoScene("level2");
        end
    end
    button4:addEventListener("tap", button4Listener);

    local text4 = display.newText("Level 2:", 270, 0 - 75, "./assets/windows_command_prompt.ttf", 15);
    local text5 = display.newText("Cost: $" .. costOfNextLevel, 270, 0 - 60, "./assets/windows_command_prompt.ttf", 15);



    local moneyText = display.newText("Cash : $" .. totalMoney, 0 + 45, -80, "./assets/windows_command_prompt.ttf", 15);
    local spawnRateText = display.newText("Fall Rate: " .. timePerSpawn / 1000 .. "s", 0 + 50, -60,
        "./assets/windows_command_prompt.ttf", 15);
    local coinValueText = display.newText("Coin Value: $" .. moneyPerCoin, 0 + 50, -40,
        "./assets/windows_command_prompt.ttf", 15);

    tableOfCoins = {};

    function coinAtTop()
        local coin = display.newImage("./assets/coinBig.png", genRndNumnber(0, display.actualContentWidth), -120);
        coin.width = 30 - sizeReduction;
        coin.height = 30 - sizeReduction;
        coin.rotation = genRndNumnber(0, 1);


        function coin:touch(event)
            coin.alpha = 0;
            physics.removeBody(coin);
            totalMoney = totalMoney + (moneyPerCoin * 0.5);
            moneyText.text = "Cash : $" .. totalMoney;
            print("coin removed")
        end

        coin:addEventListener("touch", coin);
        physics.addBody(coin, { density = 5, friction = 0.3, bounce = 0.6 })
        tableOfCoins[#tableOfCoins + 1] = coin;
    end

    function checkCoinRemoved()
        for i = 1, #tableOfCoins do
            if not tableOfCoins[i] then

            else
                if ((tableOfCoins[i].y > 490 and tableOfCoins[i].x < 90) and tableOfCoins[i] ~= nil) then
                    print("Area 1")
                    tableOfCoins[i]:removeSelf();
                    tableOfCoins[i] = nil;
                    totalMoney = totalMoney + (moneyPerCoin * 2.5);
                    moneyText.text = "Cash : $" .. totalMoney;
                elseif ((tableOfCoins[i].y > 490 and (tableOfCoins[i].x > 90 and tableOfCoins[i].x < 240)) and tableOfCoins[i] ~= nil) then
                    print("Area 2")
                    tableOfCoins[i]:removeSelf();
                    tableOfCoins[i] = nil;
                    totalMoney = totalMoney + (moneyPerCoin * 1.5);
                    moneyText.text = "Cash : $" .. totalMoney;
                elseif ((tableOfCoins[i].y > 490 and (tableOfCoins[i].x > 240)) and tableOfCoins[i] ~= nil) then
                    print("Area 3")
                    tableOfCoins[i]:removeSelf();
                    tableOfCoins[i] = nil;
                    totalMoney = totalMoney + (moneyPerCoin * 2.5);
                    moneyText.text = "Cash : $" .. totalMoney;
                end
            end
        end
    end

    coinCollection2 = timer.performWithDelay(timePerSpawn, coinAtTop, 0);
    coinCheck2 = timer.performWithDelay(1, checkCoinRemoved, 0);

    local leftWall = display.newRect(0, display.contentCenterY, 1, display.actualContentHeight)
    leftWall:setFillColor(0, 0, 0);
    physics.addBody(leftWall, "static", { density = 0, friction = 0, bounce = 0 })
    local rightWall = display.newRect(display.contentWidth, display.contentCenterY, 1, display.actualContentHeight)
    rightWall:setFillColor(0, 0, 0);
    physics.addBody(rightWall, "static", { density = 0, friction = 0, bounce = 0 })


    local rect = display.newRect(160, 490, display.viewableContentWidth, 70);
    rect:setFillColor(0, 0, 0);
    rect.alpha = 0.70;

    local text = display.newText("1.5x", 170, 490, "./assets/windows_command_prompt.ttf", 20);
    text:setFillColor(1, 1, 1);

    local text2 = display.newText("2.5x", 40, 490, "./assets/windows_command_prompt.ttf", 20);

    local text3 = display.newText("2.5x", 290, 490, "./assets/windows_command_prompt.ttf", 20);

    local triangle1 = display.newImage("./assets/plank22.png", 90, 490);
    triangle1.width = 15;
    triangle1.height = 70;
    triangle1:toFront();
    physics.addBody(triangle1, "static", { density = 0, friction = 0.1, bounce = 0.1 })


    local triangle2 = display.newImage("./assets/plank22.png", 240, 490);
    triangle2.width = 15;
    triangle2.height = 70;
    triangle2:toFront();
    physics.addBody(triangle2, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    local button = display.newImage("./assets/box.png", 0 + 50, display.actualContentHeight - 150)
    button:toFront();
    button.width = 100;
    button.height = 50;
    button:setFillColor(0.71, 0.39, 0.11)

    local function buttonPressed(event)
        if (totalMoney < costOfSpawnRate) then
            return;
        end

        local increment = 10000
        spawnReduction = spawnReduction + increment;
        coinCollection = timer.performWithDelay(spawnReduction, coinAtTop, 0);

        spawnRateText.text = "Spawn Rate: " .. ((timePerSpawn) - (spawnReduction - timePerSpawn) / 10000) .. "ms";
        totalMoney = totalMoney - costOfSpawnRate;
        moneyText.text = "Cash : $: " .. totalMoney;
    end
    button:addEventListener("tap", buttonPressed)


    local buttonText = display.newText("Spawn Rate:", 0 + 50, display.actualContentHeight - 155,
        "./assets/windows_command_prompt.ttf", 15)

    local buttonText2 = display.newText("$ " .. costOfSpawnRate, 0 + 50, display.actualContentHeight - 140,
        "./assets/windows_command_prompt.ttf", 15)

    local button2 = display.newImage("./assets/box2.png", 0 + 160, display.actualContentHeight - 150)
    button2.width = 100;
    button2.height = 50;
    button2:toFront();
    button2:setFillColor(1, 0.39, 0.11)

    local buttonText3 = display.newText("Coin Value:", 0 + 160, display.actualContentHeight - 155,
        "./assets/windows_command_prompt.ttf", 15)

    local buttonText4 = display.newText("$ " .. costOfCoinValue, 0 + 160, display.actualContentHeight - 140,
        "./assets/windows_command_prompt.ttf", 15)

    local function button2Pressed(event)
        if (totalMoney < costOfCoinValue) then
            return;
        end
        totalMoney = totalMoney - costOfCoinValue;
        moneyText.text = "Cash : $" .. totalMoney;
        moneyPerCoin = moneyPerCoin + coinValueIncrease;
        coinValueText.text = "Coin Value: $" .. moneyPerCoin;
    end
    button2:addEventListener("tap", button2Pressed)

    local button3 = display.newImage("./assets/box4.png", 0 + 270, display.actualContentHeight - 150)
    button3.width = 100;
    button3.height = 50;
    button3:toFront();


    local buttonText5 = display.newText("Coin Size:", 0 + 270, display.actualContentHeight - 155,
        "./assets/windows_command_prompt.ttf", 15)

    local buttonText6 = display.newText("$ " .. costOfSize, 0 + 270, display.actualContentHeight - 140,
        "./assets/windows_command_prompt.ttf", 15)
    local function button3Pressed(event)
        if (totalMoney < costOfSize) then
            return;
        end

        sizeReduction = sizeReduction + 0.1;

        totalMoney = totalMoney - costOfSize;
        moneyText.text = "Cash : $" .. totalMoney;
    end
    button3:addEventListener("tap", button3Pressed)


    local rect = display.newRect(0 + 50, display.actualContentHeight - 150, display.safeActualContentWidth + 230, 75);
    rect:setFillColor(0, 0, 0);
    rect.alpha = 1;


    sceneGroup:insert(background);

    sceneGroup:insert(leftWall);
    sceneGroup:insert(rightWall);
    sceneGroup:insert(rect);
    sceneGroup:insert(text);
    sceneGroup:insert(text2);
    sceneGroup:insert(text3);


    sceneGroup:insert(triangle1);
    sceneGroup:insert(triangle2);
    sceneGroup:insert(moneyText);
    sceneGroup:insert(coinValueText);
    sceneGroup:insert(spawnRateText);
    sceneGroup:insert(button);
    sceneGroup:insert(button2);
    sceneGroup:insert(button3);
    sceneGroup:insert(buttonText);

    sceneGroup:insert(buttonText4);
    sceneGroup:insert(buttonText3);
    sceneGroup:insert(buttonText5);
    sceneGroup:insert(buttonText6);
    sceneGroup:insert(buttonText2);
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


    for i = 1, #tableOfCoins do
        if not tableOfCoins[i] then

        else
            tableOfCoins[i]:removeSelf();
            tableOfCoins[i] = nil;
        end
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

