math.randomseed(os.time())
local physics = require("physics")

local composer = require("composer")
local options = {
    isModal = true,
    effect = "fade",
    time = 400,
    params = {
        sampleVar = "my sample variable"
    }
}

local mainMenu = composer.newScene()


function mainMenu:playGame()
    composer.gotoScene("mainMenu", options)
end

mainMenu:playGame()





