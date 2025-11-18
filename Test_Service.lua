--[[  
    Minimal KEY SYSTEM (Script.key OUTSIDE)
    - Script.key is set externally
    - Script = {} is inside the script
    - First run: gives key link + kicks
    - Second run: validates → runs main()
]]

-----------------------------------
-- SCRIPT TABLE INSIDE
-----------------------------------
local Script = {}

-----------------------------------
-- MAIN SCRIPT (runs after key is valid)
-----------------------------------
local function main()
    print("Main script executed!")
    -- your executor / hub / features go here
end

-----------------------------------
-- CONFIG
-----------------------------------
local Config = {
    api = "a7bb8dbe-9362-4416-9970-20f0c05f0965", 
    service = "bot_script",
    provider = "bot_key_provider"
}

-----------------------------------
-- LOAD JUNKIE SDK
-----------------------------------
local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()

-----------------------------------
-- GIVE KEY LINK + KICK
-----------------------------------
local function giveLinkAndKick()
    local link = JunkieKeySystem.getLink(Config.api, Config.provider, Config.service)

    if setclipboard then
        setclipboard(link)
    end

    warn("Your key link: " .. tostring(link))
    game.Players.LocalPlayer:Kick("Key link copied. Complete verification and set Script.key externally")
end

-----------------------------------
-- VALIDATE KEY + RUN main()
-----------------------------------
local function tryValidateKey()
    if not Script.key or Script.key == "" then
        giveLinkAndKick()
        return
    end

    local valid = JunkieKeySystem.verifyKey(Config.api, Script.key, Config.service)

    if valid then
        warn("Key valid! Loading main()")
        main()
    else
        warn("Invalid key. Reset Script.key and try again.")
    end
end

-----------------------------------
-- STARTUP
-----------------------------------
tryValidateKey()
