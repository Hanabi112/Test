getgenv().Settings = {
	["Auto Farm Level"] = false,
	["Auto Haki"] = true,
	["Select Weapon"] = nil,
	["Select Mode Farm"] = "Above",
	["Auto Skill"] = false,
	["Distance"] = 3,
	-- Stats
	["Auto Defense"] = false,
	["Auto Melee"] = false,
	["Auto Sword"] = false,
	["Auto Power Fruit"] = false,
	["Select Point Stats"] = 4000
}


function Load()
	if readfile and writefile and isfile and isfolder then
		if isfolder("AbilityHub") == false then
			makefolder("AbilityHub")
		end
		if isfile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json") == false then
			writefile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json", game:GetService("HttpService"):JSONEncode(getgenv().Settings))
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json"))
			for i,v in pairs(Decode) do
				getgenv().Settings[i] = v
			end
		end
	else
		warn("Failed Load")
		return false
	end
end
function Save()
	if readfile and writefile and isfile then
		if isfile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json") == false then
			Load()
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json"))
			local Array = {}
			for i,v in pairs(getgenv().Settings) do
				Array[i] = v
			end
			writefile("/AbilityHub/KingLegacy_" .. game.Players.LocalPlayer.DisplayName .. ".json", game:GetService("HttpService"):JSONEncode(Array))
		end
	else
		warn("Failed Save")
		return false
	end
end

Load()
Save()
repeat wait()
if game.PlaceId == 4520749081 or game.PlaceId == 6381829480 then

game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService'VirtualUser':Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService'VirtualUser':Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local PlaceIDD = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
	local Site;
	if foundAnything == "" then
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceIDD .. '/servers/Public?sortOrder=Asc&limit=100'))
	else
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceIDD .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
	end
	local ID = ""
	if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
		foundAnything = Site.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Site.data) do
		local Possible = true
		ID = tostring(v.id)
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			for _,Existing in pairs(AllIDs) do
				if num ~= 0 then
					if ID == tostring(Existing) then
						Possible = false
					end
				else
					if tonumber(actualHour) ~= tonumber(Existing) then
						local delFile = pcall(function()
							-- delfile("NotSameServers.json")
							AllIDs = {}
							table.insert(AllIDs, actualHour)
						end)
					end
				end
				num = num + 1
			end
			if Possible == true then
				table.insert(AllIDs, ID)
				wait()
				pcall(function()
					-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
					wait()
					game:GetService("StarterGui"):SetCore("SendNotification",
					{
						Title = "Server",
						Text = "Teleport Working..."
					}
				)
					wait(1)
					game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceIDD, ID, game.Players.LocalPlayer)
				end)
				wait(.1)
			end
		end
	end
end
function Teleport() 
	while wait() do
		pcall(function()
			TPReturner()
			if foundAnything ~= "" then
				TPReturner()
			end
		end)
	end
end

_G.Color = Color3.fromHSV(tick() * 24 % 255/255, 1, 1)

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/Hanabi112/Ui-Mukuro-Hub/main/Ui.lua")()

local win = DiscordLib:Window("KING LEGACY",_G.Color, _G.Toggle)

local serv = win:Server("ABILITY LAZY HUB", "")

local Main = serv:Channel("Main","")

local Stats = serv:Channel("Stats","")

local Misc = serv:Channel("Misc","")

Time = Main:Label("Server Time")

function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime+0.5)
    local Hour = math.floor(GameTime/(60^2))%24
    local Minute = math.floor(GameTime/(60^1))%60
    local Second = math.floor(GameTime/(60^0))%60
    Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
end

spawn(function()
    while true do
        UpdateTime()
        wait()
    end
end)

Client = Main:Label("FPS Server")

function UpdateClient()
    local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local Fps = game:GetService("Stats").Workspace.Heartbeat:GetValueString()
    Client:Refresh("Fps : "..Fps.." Ping : "..Ping)
end

spawn(function()
    while true do wait(.1)
        UpdateClient()
    end
end)

Main:Line()

if getgenv().Settings["Select Mode Farm"] == nil then
	Select_Tood = "Select Mode Farm"
else
	Select_Tood = getgenv().Settings["Select Mode Farm"]
end

Main:Dropdown(Select_Tood,{"Above","Behind","Above + Behind"}, function(Value)
	getgenv().Settings["Select Mode Farm"] = Value
	Save()
end)

Main:Toggle("Auto Farm Level", getgenv().Settings["Auto Farm Level"], function(Value)
	getgenv().Settings["Auto Farm Level"] = Value
	Save()
end)

local Wapon = {"Melee","Sword","Power Fruits"}
if getgenv().Settings["Select Weapon"] == nil then
	SelectPOOOOONsssssssssssssssssssssssssssssss = "Select Weapon"
elseif getgenv().Settings["Select Weapon"] == ("Combat") then    
	SelectPOOOOONsssssssssssssssssssssssssssssss = "Melee"
elseif getgenv().Settings["Select Weapon"] == ("Sword") then    
	SelectPOOOOONsssssssssssssssssssssssssssssss = "Sword"
elseif getgenv().Settings["Select Weapon"] == ("Fruit Power") then    
	SelectPOOOOONsssssssssssssssssssssssssssssss = "Power Fruits"
end
Main:Dropdown(SelectPOOOOONsssssssssssssssssssssssssssssss,Wapon, function(Value)
	getgenv().Settings["Select Weapon"] = Value
	Save()
end)

spawn(function()
	while wait(.1) do
		if getgenv().Settings["Select Weapon"] == "Power Fruits" then
			getgenv().Settings["Select Weapon"] = "Fruit Power"
		elseif getgenv().Settings["Select Weapon"] == "Melee" then
			getgenv().Settings["Select Weapon"] = "Combat"
		end
	end
end)

Main:Toggle("Auto Haki", getgenv().Settings["Auto Haki"], function(Value)
	getgenv().Settings["Auto Haki"] = Value
	Save()
end)

Main:Slider("Distance", 0, 5, getgenv().Settings["Distance"], function(Value)
	getgenv().Settings["Distance"] = Value
	Save()
end)

-----------------------------------------------------------------------

Point = Stats:Label("")

function Points()
    local PointStats = game:GetService("Players")["LocalPlayer"].PlayerStats.Points.Value
    Point:Refresh("Points Stats : "..PointStats)
end

Defense = Stats:Label("")
function Defensee()
	if game:GetService("Players")["LocalPlayer"].PlayerStats.Defense.Value >= 4250 then
		Defenses = "MAX"
	else
		Defenses = game:GetService("Players")["LocalPlayer"].PlayerStats.Defense.Value
	end
	Defense:Refresh("Defense : "..Defenses)
end

Melee = Stats:Label("")
function Meleee()
	if game:GetService("Players")["LocalPlayer"].PlayerStats.Melee.Value >= 4250 then
		Combat = "MAX"
	else
		Combat = game:GetService("Players")["LocalPlayer"].PlayerStats.Melee.Value
	end
	Melee:Refresh("Melee : "..Combat)
end

Sword = Stats:Label("")
function Swordd()
	if game:GetService("Players")["LocalPlayer"].PlayerStats.sword.Value >= 4250 then
		Swords = "MAX"
	else
		Swords = game:GetService("Players")["LocalPlayer"].PlayerStats.sword.Value
	end
	Sword:Refresh("Sword : "..Swords)
end

Fruit = Stats:Label("")
function Fruits()
	if game:GetService("Players")["LocalPlayer"].PlayerStats.DF.Value >= 4250 then
		PowerFruits = "MAX"
	else
		PowerFruits = game:GetService("Players")["LocalPlayer"].PlayerStats.DF.Value
	end
	Fruit:Refresh("Power Fruits : "..PowerFruits)
end

spawn(function()
    while true do wait(.1)
        Points()
		Fruits()
		Swordd()
		Meleee()
		Defensee()
    end
end)

getgenv().Settings["Select Point Stats"] = 1
Stats:Slider("Select Point Stats", 0, 4000,getgenv().Settings["Select Point Stats"], function(Value)
	getgenv().Settings["Select Point Stats"] = Value
	Save()
end)

Stats:Line()

Stats:Toggle("Auto Defense", getgenv().Settings["Auto Defense"], function(Value)
	getgenv().Settings["Auto Defense"] = Value
	Save()
end)

Stats:Line()

Stats:Toggle("Auto Melee", getgenv().Settings["Auto Melee"], function(Value)
	getgenv().Settings["Auto Melee"] = Value
	Save()
end)

Stats:Line()

Stats:Toggle("Auto Sword", getgenv().Settings["Auto Sword"], function(Value)
	getgenv().Settings().Settingstings["Auto Sword"] = Value
	Save()
end)

Stats:Line()

Stats:Toggle("Auto Power Fruit", getgenv().Settings["Auto Power Fruit"], function(Value)
	getgenv().Settings["Auto Power Fruit"] = Value
	Save()
end)

spawn(function()
	while wait(.1) do
		pcall(function()
			if getgenv().Settings["Auto Defense"] then
				game:GetService("Players").LocalPlayer.PlayerGui.Stats.Button.StatsFrame.RemoteEvent:FireServer("Defense",Settings["Select Point Stats"])
			end
		end)
	end
end)

spawn(function()
	while wait(.1) do
		pcall(function()
			if getgenv().Settings["Auto Melee"] then
				game:GetService("Players").LocalPlayer.PlayerGui.Stats.Button.StatsFrame.RemoteEvent:FireServer("Melee",Settings["Select Point Stats"])
			end
		end)
	end
end)


spawn(function()
	while wait(.1) do
		pcall(function()
			if getgenv().Settings["Auto Sword"] then
				game:GetService("Players").LocalPlayer.PlayerGui.Stats.Button.StatsFrame.RemoteEvent:FireServer("Sword",Settings["Select Point Stats"])
			end
		end)
	end
end)


spawn(function()
	while wait(.1) do
		pcall(function()
			if getgenv().Settings["Auto Power Fruit"] then
				game:GetService("Players").LocalPlayer.PlayerGui.Stats.Button.StatsFrame.RemoteEvent:FireServer("Devil Fruit",Settings["Select Point Stats"])
			end
		end)
	end
end)


Main:Line()

Main:Toggle("Auto Skill", getgenv().Settings["Auto Skill"], function(Value)
	getgenv().Settings["Auto Skill"] = Value
	Save()
end)

spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		if getgenv().Settings["Select Mode Farm"] == "Above" then
			Farm_Mode = CFrame.new(0, getgenv().Settings["Distance"], 0)
		elseif getgenv().Settings["Select Mode Farm"] == "Behind" then
			Farm_Mode = CFrame.new(0, 0, getgenv().Settings["Distance"])
		elseif getgenv().Settings["Select Mode Farm"] == "Above + Behind" then
			Farm_Mode = CFrame.new(0, getgenv().Settings["Distance"], getgenv().Settings["Distance"])
		end
	end)
end)

spawn(function()
	while wait(.1) do
		pcall(function()
			if getgenv().Settings["Auto Haki"] then
				if game.Players.LocalPlayer.Character.Haki.Value ~= 1 then
					game:GetService("Players").LocalPlayer.Character.Services.Client.Armament:FireServer()
					wait(1.5)
				end
			end
		end)
	end
end)

---------------------------------------------------------------------------------------------

Misc:Button("Rejoin", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").localPlayer)
end)

Misc:Button("Discord : Ability Hub",function()
	local req =  http_request or request or HttpPost or syn.request
	if req then
		req({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = game:GetService("HttpService"):JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = game:GetService("HttpService"):GenerateGUID(false),
				args = {code = 'zxekHPMGtA'}
			})
		})
	end
end)

Misc:Button("Server Hop", function()
	Teleport()
end)
function EquipWeapon(ToolSe)
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
		if v:IsA("Tool") then 
			if v.ToolTip == ToolSe then    
				Weapon = v.Name
			end
		end
	end
    if game.Players.LocalPlayer.Backpack:FindFirstChild(Weapon) then
        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(Weapon)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

if game.PlaceId == 4520749081 then
	First_Sea = true
 elseif game.PlaceId == 6381829480 then
	Second_Sea = true
 elseif game.PlaceId == 5931540094 then
	Dungeon_Sea = true
 end
	--[[function CheckQuest()
        QUEST = {}
        LVLREAL = {}
        local MyLevel = game.Players.LocalPlayer.PlayerStats.lvl.Value
        for i,v in pairs(game:GetService("Workspace").AllNPC:GetChildren()) do 
            if string.find(v.Name,"QuestLvl") then
                table.insert(QUEST,v.Name)
            end
        end
        for i,v in pairs(game:GetService("ReplicatedStorage").MAP:GetChildren()) do 
            if string.find(v.Name,"QuestLvl") then
                table.insert(QUEST,v.Name)
            end
        end
        for i,v in pairs(QUEST) do
            values = v:split("QuestLvl")
            LVL = values[2]
            if MyLevel >= tonumber(LVL) then
                table.insert(LVLREAL,LVL)
            end
        end
        LevelQuest = math.max(unpack(LVLREAL))
    end]]

	local Mob = nil
	local monname = nil
	local plr = game.Players.LocalPlayer
	local IslandTable = {}
	local VirtualUser = game:GetService("VirtualUser")
	local devilfruitx = require(game:GetService("ReplicatedStorage").Modules.DFROBUX)
	local quest = require(game:GetService("ReplicatedStorage").Modules.QuestManager)
	local Levelmon,RealUse,new_table,valuexxx = {},{},nil,1
	for i,v in pairs(quest) do
		table.insert(Levelmon, tonumber(v['Mob']:match('%d+')))
	end
	for i,v in pairs(quest) do
		table.insert(RealUse, tonumber(v['Mob']:match('%d+')))
	end


	local function sort(a, b)
		if a < b then 
			return true     
		end
	end
	table.sort(Levelmon)
	local function lvlx()
		if plr.PlayerStats.lvl.Value >= 3325 then
			new_table = 3325
		else
			if plr.PlayerStats.lvl.Value >= Levelmon[valuexxx] and plr.PlayerStats.lvl.Value < Levelmon[valuexxx + 1] then
				new_table = Levelmon[valuexxx]
			else
				valuexxx = valuexxx + 1
			end
		end
	end

	local function ReturnMonFolder()
		if game:GetService("Workspace").Monster.Mon:FindFirstChild(quest[plr.CurrentQuest.Value].Mob) then
			return 'Mon'
		elseif game:GetService("Workspace").Monster.Boss:FindFirstChild(quest[plr.CurrentQuest.Value].Mob) then
			return 'Boss'
		end
	end

	local function Munrock()
		if game:GetService("Workspace").AllNPC:FindFirstChild('QuestLvl' .. tostring(new_table))then
			plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AllNPC:FindFirstChild('QuestLvl' .. tostring(new_table)).Head.CFrame * CFrame.new(0,0,3)
			game:GetService("ReplicatedStorage").Remotes.Functions.CheckQuest:InvokeServer(workspace.AllNPC:FindFirstChild(('QuestLvl' .. tostring(new_table))))
		elseif game:GetService("ReplicatedStorage").MAP:FindFirstChild('QuestLvl' .. tostring(new_table)) then
			plr.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage").MAP:FindFirstChild('QuestLvl' .. tostring(new_table)).Head.CFrame  * CFrame.new(0,0,3)
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,5000,0)
		end
	end

local VirtualUser = game:GetService('VirtualUser')
function Click()
	game:GetService'VirtualUser':Button1Down(Vector2.new(0.9,0.9))
	game:GetService'VirtualUser':Button1Up(Vector2.new(0.9,0.9))
end
local function UseSkill(Value)
	game:GetService("VirtualInputManager"):SendKeyEvent(true, Value, false, game)
	wait(.5)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, Value, false, game)
end

spawn(function ()
    while true do
        if getgenv().Settings["Auto Farm Level"] then
            pcall(function ()
                lvlx()
                    if plr.PlayerGui.Quest.QuestBoard.Visible == false then
                        spawn(function ()
                            Munrock()
                        end)
                    elseif not string.match(plr.PlayerGui.Quest.QuestBoard.QuestCount.Text,new_table) then
                        spawn(function ()
                            Munrock()
                        end)
                    elseif plr.PlayerGui.Quest.QuestBoard.Visible == true and string.match(plr.PlayerGui.Quest.QuestBoard.QuestCount.Text,new_table) then
                        if  game:GetService("ReplicatedStorage").MOB:FindFirstChild(quest[plr.CurrentQuest.Value].Mob) then
                            plr.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage").MOB:FindFirstChild(quest[plr.CurrentQuest.Value].Mob).HumanoidRootPart.CFrame * CFrame.new(0,20,0)
                        else
                            for i,v in pairs(game:GetService("Workspace").Monster[ReturnMonFolder()]:GetChildren()) do
                                if v.Name == quest[plr.CurrentQuest.Value].Mob  and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    Mob = v
                                    repeat wait()
										EquipWeapon(getgenv().Settings["Select Weapon"])
										plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * Farm_Mode
										if getgenv().Settings["Auto Skill"] == false then 
										game:GetService('VirtualUser'):CaptureController()
										game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
										elseif Settings["Auto Skill"] == true then 
											UseSkill("Z")
											UseSkill("X")
											UseSkill("C")
											UseSkill("V")
										end
                                    until  v.Humanoid.Health <= 0 or getgenv().Settings["Auto Farm Level"] == false or plr.PlayerGui.Quest.QuestBoard.Visible == false
                                    return
                                end
                            end
                        end
                    end
                end)
            end
        wait()
    end    
end)
coroutine.wrap(function()
    game:getService("RunService"):UnbindFromRenderStep("noclOppl")
        game:getService("RunService"):BindToRenderStep("noclOppl",0,function()
        if getgenv().Settings["Auto Farm Level"] then
            pcall(function()
                for i2,v in pairs(plr.PlayerGui:GetChildren()) do
                    if string.find(v.Name,"QuestLvl") or string.find(v.Name,"SwordShop") then 
                    v.Dialogue.Accept.Position = UDim2.new(0, -800 ,0, -700)
                    v.Dialogue.Accept.Size = UDim2.new(5000, 5000, 5000, 5000)
                    v.Dialogue.Accept.BackgroundTransparency = 1
                    v.Dialogue.Accept.ImageTransparency = 1
                    Click()
                end
            end
        end)
        end
        
    end)
end)()

--[[local metatable = getrawmetatable(game)
local namecall = metatable.__namecall
  setreadonly(metatable, false)
    metatable.__namecall = newcclosure(function(self, ...)
        local args = {...}  
        if Settings["Auto Farm Level"] then
            if self.Name == "Z"  and Mob ~= nil then
                for i,v in pairs(args) do
                    if typeof(v) == "CFrame" then
                        args[i] = Mob.HumanoidRootPart.CFrame
                    end
                end
            return namecall(self,unpack(args))
          end
          if self.Name == "X" and Mob ~= nil then
            for i,v in pairs(args) do
                if typeof(v) == "CFrame" then
                    args[i] = Mob.HumanoidRootPart.CFrame
                end
            end
        return namecall(self,unpack(args))
      end
      if self.Name == "C" and Mob ~= nil then
        for i,v in pairs(args) do
            if typeof(v) == "CFrame" then
                args[i] = Mob.HumanoidRootPart.CFrame
            end
        end
    return namecall(self,unpack(args))
    end
    if self.Name == "V" and Mob ~= nil then
        for i ,v in pairs(args) do
            if typeof(v) == "CFrame" then
                args[i] = Mob.HumanoidRootPart.CFrame
            end
        end
    return namecall(self,unpack(args))
    end
        end
      
    return namecall(self, ...)
    end)
  setreadonly(metatable, true)	]]

	spawn(function()
		game:GetService("RunService").Heartbeat:Connect(function()
			pcall(function()
				if getgenv().Settings["Auto Farm Level"] then
					if not game:GetService("Workspace"):FindFirstChild("LOL") then
						local LOL = Instance.new("Part")
						LOL.Name = "LOL"
						LOL.Parent = game.Workspace
						LOL.Anchored = true
						LOL.Transparency = 0
						LOL.TopSurface = Enum.SurfaceType.Smooth
						LOL.Size = Vector3.new(10,-0.5,10)
						while true do wait(.5) 
							game:GetService('TweenService'):Create(
								LOL,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
							{Color = Color3.fromHSV(tick() * 24 % 255/255, 1, 1)}):Play() 
						end
					elseif game:GetService("Workspace"):FindFirstChild("LOL") then
						game.Workspace["LOL"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0)
					end
				else
					if game:GetService("Workspace"):FindFirstChild("LOL") then
						game:GetService("Workspace"):FindFirstChild("LOL"):Destroy()
					end
				end
			end)
		end)
	end)
end
until game:IsLoaded()
