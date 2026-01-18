local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui", 10)

local Categories = {}
local MainFrame = nil

local function findCharacterMenu()
    local possibleNames = {"MenuCharacterSelection", "CharacterSelection"}
    
    for _, menuName in ipairs(possibleNames) do
        local menu = gui:FindFirstChild(menuName)
        if menu then
            local main = menu:FindFirstChild("Main")
            if main then
                return menu, main
            end
        end
    end
    
    return nil, nil
end

local function updateCategories()
    local success, err = pcall(function()
        local menu, main = findCharacterMenu()
        
        if not menu or not main then
            return
        end
        
        MainFrame = main
        
        Categories = {
            ["F2P ULTRAS"]   = MainFrame:FindFirstChild("F2P ULTRAS"),
            ["TRINITIUM"]     = MainFrame:FindFirstChild("TRINITIUM"),
            ["SUPER DUPERS"]  = MainFrame:FindFirstChild("SUPER DUPERS"),
            ["SEIJIN"]        = MainFrame:FindFirstChild("SEIJIN"),
            ["EVIL ULTRAS"]   = MainFrame:FindFirstChild("EVIL ULTRAS"),
            ["MULTIVERSALS"]  = MainFrame:FindFirstChild("MULTIVERSALS"),
            ["REIONICS"]      = MainFrame:FindFirstChild("REIONICS"),
        }
        
        for name, obj in pairs(Categories) do
        end
    end)
    
    if not success then
    end
end

local function closeAllCategories()
    if not MainFrame then return end
    
    for _, child in ipairs(MainFrame:GetChildren()) do
        if (child:IsA("Frame") or child:IsA("ScrollingFrame")) and child.Visible then
            child.Visible = false
        end
    end
end

local function openCategory(targetName)
    if not MainFrame then
        return
    end
    
    local target = Categories[targetName]
    if not target then
        return
    end
    
    closeAllCategories()
    target.Visible = true
end

-- โหลด WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Quick X Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(10110028480).Name,
    Icon = "",
    Author = "By : คนหล่อ",
    BackgroundImageTransparency = 0,
})

local Ultraman = Window:Tab({
    Title = "Ultraman",
    Icon = "",
    Locked = false,
})

Ultraman:Section({ Title = "เลือกหมวดตัวละคร" })

local categoryButtons = {
    {name = "TRINITIUM",     title = "Open Trinity"},
    {name = "SUPER DUPERS",  title = "Open SUPER DUPERS"},
    {name = "SEIJIN",        title = "Open SEIJIN"},
    {name = "EVIL ULTRAS",   title = "Open EVIL ULTRAS"},
    {name = "MULTIVERSALS",  title = "Open MULTIVERSALS"},
    {name = "REIONICS",      title = "Open REIONICS", desc = "ไม่รู้ตัวอะไร (555)"}
}

for _, btn in ipairs(categoryButtons) do
    Ultraman:Button({
        Title = btn.title,
        Desc = btn.desc or "",
        Locked = false,
        Callback = function()
            openCategory(btn.name)
        end
    })
end

Ultraman:Section({ Title = "-----------------------------" })

local function tryLoadGUI()
    task.wait(1.5)
    updateCategories()
end


task.spawn(tryLoadGUI)

player.CharacterAdded:Connect(function()
    task.spawn(tryLoadGUI)
end)

task.spawn(function()
    while true do
        if not MainFrame or not MainFrame.Parent then
            tryLoadGUI()
        end
        task.wait(5)
    end
end)
