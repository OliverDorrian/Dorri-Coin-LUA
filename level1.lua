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

totalMoney = 1;

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
    sceneGroup = self.view;

    local background = display.newImage("./assets/back44.gif", display.contentCenterX, display.contentCenterY);
    background.width = display.viewableContentWidth;
    background.height = display.safeActualContentHeight + 100;
    sceneGroup:insert(background);


    local moneyText = display.newText("Cash : $" .. totalMoney, 0 + 45, -80, "./assets/windows_command_prompt.ttf", 15);

    local spawnRateText = display.newText("Fall Rate: " .. timePerSpawn / 1000 .. "s", 0 + 50, -60,
        "./assets/windows_command_prompt.ttf", 15);
    

    local coinValueText = display.newText("Coin Value: $" .. moneyPerCoin, 0 + 50, -40,
        "./assets/windows_command_prompt.ttf", 15);

    tableOfCoins = {};
    
    function coinAtTop()
        local coin = display.newImage("./assets/coinBig.png", genRndNumnber(0, display.actualContentWidth), -120);
        coin.width = 30 - sizeReduction;
        coin.height = 30 -sizeReduction;
        coin.rotation = genRndNumnber(0, 1);


        function coin:touch(event)
            coin.alpha = 0;
            physics.removeBody(coin);
            totalMoney = totalMoney + (moneyPerCoin * 0.5);
            moneyText.text = "Cash : $" .. totalMoney;
            print("coin removed")
        end

        coin:addEventListener("touch", coin);
        physics.addBody(coin, { density = 5, friction = 0.3, bounce = 0.6})
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

    coinCollection = timer.performWithDelay(timePerSpawn, coinAtTop, 0);
    coinCheck = timer.performWithDelay(1, checkCoinRemoved, 0);


    leftWall = display.newRect(0, display.contentCenterY, 1, display.actualContentHeight)
    leftWall:setFillColor(0, 0, 0);
    physics.addBody(leftWall, "static", { density = 0, friction = 0, bounce = 0 })
    rightWall = display.newRect(display.contentWidth, display.contentCenterY, 1, display.actualContentHeight)
    rightWall:setFillColor(0, 0, 0);
    physics.addBody(rightWall, "static", { density = 0, friction = 0, bounce = 0 })


    circle = display.newImage("./assets/barrel1.png", 50 + 0, 0);
    circle.width = 25;
    circle.height = 25;
    physics.addBody(circle, "static", { density = 0, friction = 1, bounce = 0.1 })
    
    circle2 = display.newImage("./assets/barrel1.png", 50 + 110, 0);
    circle2.width = 25;
    circle2.height = 25;
    physics.addBody(circle2, "static", { density = 0, friction = 1, bounce = 0.1 })

    circle3 = display.newImage("./assets/barrel1.png", 50 + 220, 0);
    circle3.width = 25;
    circle3.height = 25;
    physics.addBody(circle3, "static", { density = 0, friction = 1, bounce = 0.1 })

    circle4 = display.newImage("./assets/barrel1.png", 50 + 50, 80);
    circle4.width = 25;
    circle4.height = 25;
    physics.addBody(circle4, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    circle5 = display.newImage("./assets/barrel1.png", 50 + 170, 80);
    circle5.width = 25;
    circle5.height = 25;
    physics.addBody(circle5, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    spinningObj1 = display.newImage("./assets/plank22.png", 50, 170);
    spinningObj1.width = 15;
    spinningObj1.height = 70;
    physics.addBody(spinningObj1, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj1), -1);

    spinningObj2 = display.newImage("./assets/plank22.png", 50, 170);
    spinningObj2.rotation = 90;
    spinningObj2.width = 15;
    spinningObj2.height = 70;
    physics.addBody(spinningObj2, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj2), -1);

    spinningObj3 = display.newImage("./assets/plank22.png", 50 + 110, 170);
    spinningObj3.width = 15;
    spinningObj3.height = 70;
    physics.addBody(spinningObj3, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj3), -1);

    spinningObj4 = display.newImage("./assets/plank22.png", 50 + 110, 170);
    spinningObj4.rotation = 90;
    spinningObj4.width = 15;
    spinningObj4.height = 70;
    physics.addBody(spinningObj4, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj4), -1);

    spinningObj5 = display.newImage("./assets/plank22.png", 50 + 220, 170);
    spinningObj5.width = 15;
    spinningObj5.height = 70;
    physics.addBody(spinningObj5, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj5), -1);

    spinningObj6 = display.newImage("./assets/plank22.png", 50 + 220, 170);
    spinningObj6.width = 15;
    spinningObj6.height = 70;
    spinningObj6.rotation = 90;
    physics.addBody(spinningObj6, "static", { density = 0, friction = 0, bounce = 0 })
    timer.performWithDelay(10, rotatreObject(spinningObj6), -1);

    circle6 = display.newImage("./assets/barrel1.png", 50 + 50, 270);
    circle6.width = 25;
    circle6.height = 25;
    physics.addBody(circle6, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    circle7 = display.newImage("./assets/barrel1.png", 50 + 170, 270);
    circle7.width = 25;
    circle7.height = 25;
    physics.addBody(circle7, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    circle8 = display.newImage("./assets/barrel1.png", 50 , 340);
    circle8.width = 25;
    circle8.height = 25;
    physics.addBody(circle8, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    circle9 = display.newImage("./assets/barrel1.png", 50 + 110, 340);
    circle9.width = 25;
    circle9.height = 25;
    physics.addBody(circle9, "static", { density = 0, friction = 0.1, bounce = 0.1 })

    circle10 = display.newImage("./assets/barrel1.png", 50 + 210 + 20, 340);
    circle10.width = 25;
    circle10.height = 25;
    physics.addBody(circle10, "static", { density = 0, friction = 0.1, bounce = 0.1 })
    

    rect = display.newRect(160, 420, display.viewableContentWidth, 70);
    rect:setFillColor(0, 0, 0);
    rect.alpha = 0.6;

    text = display.newText("1.5x", 170, 420, "./assets/windows_command_prompt.ttf", 20);
    text:setFillColor(1, 1, 1);

    text2 = display.newText("2.5x", 40, 420, "./assets/windows_command_prompt.ttf", 20);

    text3 = display.newText("2.5x", 290, 420, "./assets/windows_command_prompt.ttf", 20);

    triangle1 = display.newImage("./assets/plank22.png", 90, 420);
    triangle1.width = 15;
    triangle1.height = 70;
    triangle1:toFront();
    physics.addBody(triangle1, "static", { density = 0, friction = 0.1, bounce = 0.1 })


    triangle2 = display.newImage("./assets/plank22.png", 240, 420);
    triangle2.width = 15;
    triangle2.height = 70;
    triangle2:toFront();
    physics.addBody(triangle2, "static", { density = 0, friction = 0.1, bounce = 0.1 })
    
    button = display.newImage("./assets/box.png", 0 + 50, 490)
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

        spawnRateText.text = "Spawn Rate: " .. ((timePerSpawn) - (spawnReduction - timePerSpawn) / 10000 ) .. "ms";
        totalMoney = totalMoney - costOfSpawnRate;
        moneyText.text = "Cash : $: " .. totalMoney;
    end
    button:addEventListener("tap", buttonPressed)


    buttonText = display.newText("Spawn Rate:", 0 + 50, 485,
        "./assets/windows_command_prompt.ttf", 15)

    buttonText2 = display.newText("$ " .. costOfSpawnRate, 0 + 50, 500,
        "./assets/windows_command_prompt.ttf", 15)

    button2 = display.newImage("./assets/box2.png", 0 + 160, 490)
    button2.width = 100;
    button2.height = 50;
    button2:toFront();
    button2:setFillColor(1, 0.39, 0.11)

    buttonText3 = display.newText("Coin Value:", 0 + 160, 485,
        "./assets/windows_command_prompt.ttf", 15)

    buttonText4 = display.newText("$ " .. costOfCoinValue, 0 + 160, 500,
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

    button3 = display.newImage("./assets/box4.png", 0 + 270, 490)
    button3.width = 100;
    button3.height = 50;
    button3:toFront();


    buttonText5 = display.newText("Coin Size:", 0 + 270, 485,
        "./assets/windows_command_prompt.ttf", 15)
    
    buttonText6 = display.newText("$ " .. costOfSize, 0 + 270, 500,
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


    local rect1 = display.newRect(0 + 50, 490 + 220, display.safeActualContentWidth + 230, 500);
    rect1:setFillColor(0, 0, 0);
    rect1.alpha = 1;


    sceneGroup:insert(background);


    sceneGroup:insert(leftWall);
    sceneGroup:insert(rightWall);
    sceneGroup:insert(rect);
    sceneGroup:insert(rect1);
    sceneGroup:insert(text);
    sceneGroup:insert(text2);
    sceneGroup:insert(text3);


    sceneGroup:insert(triangle1);
    sceneGroup:insert(triangle2);
    sceneGroup:insert(spinningObj1);
    sceneGroup:insert(spinningObj2);
    sceneGroup:insert(spinningObj3);
    sceneGroup:insert(spinningObj4);
    sceneGroup:insert(spinningObj5);
    sceneGroup:insert(spinningObj6);
    sceneGroup:insert(circle);
    sceneGroup:insert(circle2);
    sceneGroup:insert(circle3);
    sceneGroup:insert(circle4);
    sceneGroup:insert(circle5);
    sceneGroup:insert(circle6);
    sceneGroup:insert(circle7);
    sceneGroup:insert(circle8);
    sceneGroup:insert(circle9);
    sceneGroup:insert(circle10);
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

    if (phase == "will") then
    elseif (phase == "did") then
    end
end

function scene:destroy(event)

    for i = 1, #tableOfCoins do
        if not tableOfCoins[i] then

        else
            tableOfCoins[i]:removeSelf();
            tableOfCoins[i] = nil;
        end
    end
    
    background:removeSelf();
    background = nil;

    leftWall:removeSelf();
    leftWall = nil;

    rightWall:removeSelf();
    rightWall = nil;

    rect:removeSelf();
    rect = nil;

    text:removeSelf();
    text = nil;

    text2:removeSelf();
    text2 = nil;

    text3:removeSelf();
    text3 = nil;

    triangle1:removeSelf();
    triangle1 = nil;

    triangle2:removeSelf();
    triangle2 = nil;

    spinningObj1:removeSelf();
    spinningObj1 = nil;

    spinningObj2:removeSelf();
    spinningObj2 = nil;

    spinningObj3:removeSelf();
    spinningObj3 = nil;

    spinningObj4:removeSelf();
    spinningObj4 = nil;

    spinningObj5:removeSelf();
    spinningObj5 = nil;

    spinningObj6:removeSelf();
    spinningObj6 = nil;

    circle:removeSelf();
    circle = nil;

    circle2:removeSelf();
    circle2 = nil;

    circle3:removeSelf();
    circle3 = nil;

    circle4:removeSelf();
    circle4 = nil;

    circle5:removeSelf();
    circle5 = nil;

    circle6:removeSelf();
    circle6 = nil;

    circle7:removeSelf();
    circle7 = nil;

    circle8:removeSelf();
    circle8 = nil;

    circle9:removeSelf();
    circle9 = nil;

    circle10:removeSelf();
    circle10 = nil;

    moneyText:removeSelf();
    moneyText = nil;

    coinValueText:removeSelf();
    coinValueText = nil;

    spawnRateText:removeSelf();
    spawnRateText = nil;

    button:removeSelf();
    button = nil;

    button2:removeSelf();
    button2 = nil;

    button3:removeSelf();
    button3 = nil;

    buttonText:removeSelf();
    buttonText = nil;

    buttonText2:removeSelf();
    buttonText2 = nil;

    buttonText3:removeSelf();
    buttonText3 = nil;

    buttonText4:removeSelf();
    buttonText4 = nil;

    buttonText5:removeSelf();
    buttonText5 = nil;

    buttonText6:removeSelf();
    buttonText6 = nil;

    physics.removeBody(leftWall);
    physics.removeBody(rightWall);
    physics.removeBody(triangle1);
    physics.removeBody(triangle2);
    physics.removeBody(spinningObj1);
    physics.removeBody(spinningObj2);
    physics.removeBody(spinningObj3);
    physics.removeBody(spinningObj4);
    physics.removeBody(spinningObj5);
    physics.removeBody(spinningObj6);
    physics.removeBody(circle);
    physics.removeBody(circle2);
    physics.removeBody(circle3);
    physics.removeBody(circle4);
    physics.removeBody(circle5);
    physics.removeBody(circle6);
    physics.removeBody(circle7);
    physics.removeBody(circle8);
    physics.removeBody(circle9);
    physics.removeBody(circle10);

end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene