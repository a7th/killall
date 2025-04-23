getgenv().AutoClick = false
getgenv().AutoUpgrade = false
getgenv().AutoEgg = false
local selected_player = nil
local Whitelisted = {}
local test = game.Players:GetChildren()
local plr = game.Players.LocalPlayer

function Anti_Tase()
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(.2)
    game.Players.LocalPlayer.Character.ClientInputHandler.Disabled = true
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 24
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
 end)
end
function touch(Toucher,TouchThis)
		if not Toucher or not TouchThis then
			return
		end
		task.spawn(function()
			firetouch(Toucher,TouchThis,0)
			firetouch(Toucher,TouchThis,1)
			print("Touch")
		end)
	end
function getpos()
		return plr.Character:FindFirstChild("HumanoidRootPart").CFrame
end
function MoveToJunk(v)
	v.CFrame = CFrame.new(0,5^5,0)
end
function MoveTo(Pos,t)
		pcall(function()
			if typeof(Pos):lower() == "position" then
				Pos = CFrame.new(Pos)
			end
			for i =1,3 do
				plr.Character:FindFirstChild("HumanoidRootPart").CFrame = Pos
			end
		end)
	end
function Last_Team(Lastteam)
		task.spawn(function()
			local a,b,c= nil,getpos(),workspace.CurrentCamera.CFrame
			a =plr.CharacterAdded:Connect(function(Char)
				task.spawn(function()
					workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
					for i =1,5 do
						workspace.CurrentCamera.CFrame = c
					end
				end)
				Char:WaitForChild("HumanoidRootPart")
				MoveTo(b)
				a:Disconnect()
			end)
			local Team = Valid_Team(Lastteam)
			if Team and Team~=1 then
				local pos = getpos()
				workspace.Remote.TeamEvent:FireServer(Lastteam)
			elseif Team and Team == 1 then
				workspace.Remote.TeamEvent:FireServer("Bright orange")
				local crimpad = workspace["Criminals Spawn"].SpawnLocation
				crimpad.CanCollide = false
				crimpad.Transparency = 1
				repeat task.wait()crimpad.CFrame = getpos() until plr.Team == game.Teams.Criminals
				MoveToJunk(crimpad)
			end
		end)
	end
function GetGun(String,a)
		local saved = game:GetService("Players").LocalPlayer.Character:GetPrimaryPartCFrame()
		if String and game:GetService("Workspace").Prison_ITEMS.giver:FindFirstChild(String) then
			local RandomPart = game:GetService("Workspace").Prison_ITEMS.giver:FindFirstChild(String):FindFirstChildOfClass("Part")
			MoveTo(CFrame.new(RandomPart.Position))
			wait()
			for i =1,3 do
				task.spawn(function()
					workspace.Remote.ItemHandler:InvokeServer(RandomPart)
				end)
			end
		else
			return
		end
		if not plr.Backpack:FindFirstChild(String) then
			GetGun(String,saved)
		end
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(a or saved)
	end
function ChangeTeam(Team)
		if Team == game.Teams.Criminals then
			local pos = getpos()
			local crimpad = workspace["Criminals Spawn"].SpawnLocation
			crimpad.CanCollide = false
			crimpad.Transparency = 1
			repeat task.wait()crimpad.CFrame = getpos() until plr.Team == game.Teams.Criminals
			wait()
			MoveTo(pos)
			MoveToJunk(crimpad)
			return
		end
		local a,b,c= nil,getpos(),workspace.CurrentCamera.CFrame
		a =plr.CharacterAdded:Connect(function(Char)
			task.spawn(function()
				workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
				for i =1,5 do
					workspace.CurrentCamera.CFrame = c
				end
			end)
			Char:WaitForChild("HumanoidRootPart")
			MoveTo(b)
			a:Disconnect()
		end)
		local ohString1 = Team.TeamColor.Name
		workspace.Remote.TeamEvent:FireServer(ohString1)
		return
end
function GetTeam()
		return plr.TeamColor.Name
	end
function GodMode()
		local Hats = {}
		repeat task.wait() until plr.Character:FindFirstChildOfClass("Accessory")
		do
			--//Fix the stupid hat falling off because it looks good without it falling and because im not gay
			for i,v in pairs(plr.Character:GetChildren()) do
				if v and v:IsA("Accessory") then
					pcall(function()
						v.Handle.CanTouch = false
						Hats[#Hats+1] = {
							Hat = v,
							OldPosition = v.Handle:FindFirstChildOfClass("Weld").C0,
							OldPosition2 = v.Handle:FindFirstChildOfClass("Weld").C1
						}
						v.Handle.Anchored = true
					end)

				end
			end
		end
		do--//Glitch Humanoid
			task.spawn(function()
				plr.Character:FindFirstChildOfClass("Humanoid"):Destroy()
				Instance.new("Humanoid",plr.Character)
				pcall(function()
					plr.Character:FindFirstChild("Animate").Disabled = true
					plr.Character:FindFirstChild("Animate").Disabled = false
				end)
			end)
		end
		return true
	end
function All_Guns()
		local saved = game:GetService("Players").LocalPlayer.Character:GetPrimaryPartCFrame()
		if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(plr.UserId, 96651) then
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP.Position))
			local ohInstance1 = game:GetService("Workspace").Prison_ITEMS.giver.M4A1:GetChildren()[6]
			workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
				end		
			end)
			wait(.1)
		end
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP.Position))
		for i =1,2 do
			local ohInstance1 = game:GetService("Workspace").Prison_ITEMS.giver.M9:GetChildren()[6]
			workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
				end		
			end)
			local ohInstance2 = workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP
			workspace.Remote.ItemHandler:InvokeServer(ohInstance2)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance2)
				end		
			end)
			local ohInstance3 = game:GetService("Workspace").Prison_ITEMS.giver["AK-47"]:GetChildren()[51]
			wait()
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(game:GetService("Workspace").Prison_ITEMS.giver["AK-47"]:GetChildren()[51].Position+Vector3.new(0,4,0)))
			workspace.Remote.ItemHandler:InvokeServer(ohInstance3)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance3)
				end		
			end)
		end
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(saved)
end


function MKILL(target,STOP,P)
		if typeof(target):lower() == "string" and game:GetService("Players"):FindFirstChild(target) then
			target = game:GetService("Players"):FindFirstChild(target)
		end
		if not STOP then STOP =1 end
		if not target or not target.Character or not target.Character:FindFirstChild("Humanoid") or target.Character:FindFirstChildOfClass("ForceField") or target.Character:FindFirstChild("Humanoid").Health<1 or not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or not plr.Character:FindFirstChild("HumanoidRootPart")  then
			return
		end
	end

function kill(player,Type)
		if typeof(player):lower() == "string" then
			if game:GetService("Players"):FindFirstChild(player) then
				player = game:GetService("Players"):FindFirstChild(player)
			else
				return
			end
		end
		if player == plr then
			
		end
		local Gun = ReturnGun()
		if table.find(Whitelisted,player.Name) then
			print("error is whitelisted - 1")
			return Notif("This player is whitelisted")
		end
		if Gun and plr.Team ~= player.Team then
			local Gen = {}
			for i =1,15 do
				Gen[#Gen+1]={
					["RayObject"] = Ray.new(Vector3.new(0,0,0), Vector3.new(0,0,0)),
					["Distance"] = .1,
					["Cframe"] = CFrame.new(),
					["Hit"] = player.Character:WaitForChild("Head")
				}
			end

			game:GetService("ReplicatedStorage").ShootEvent:FireServer(Gen, Gun)
		else
			MKILL(player)
		end
		wait(.3)
		if player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health <1 then
			
		else
			
		end
end
function Kill_All(TeamS)
		local a = GetTeam()
		local saved = getpos()
		local Team = GetTeam()
		if not TeamS then
			ChangeTeam(game.Teams.Inmates)
		end
		GetGun("M9")
		repeat task.wait() until plr.Backpack:FindFirstChild("M9")
		local Gun = plr.Backpack:FindFirstChild("M9")
		local Gen = {}
		if TeamS then
			if TeamS == game.Teams.Guards then
				ChangeTeam(game.Teams.Inmates)
			elseif TeamS == game.Teams.Inmates then
				ChangeTeam(game.Teams.Criminals)
			end
		end
		if not TeamS then
			for i,v in pairs(game:GetService("Players"):GetPlayers()) do
				if not table.find(Whitelisted,v.Name) and v ~= plr then
					if v.Team == game.Teams.Criminals then
						for i =1,10 do
							Gen[#Gen+1]={
								["RayObject"] = Ray.new(Vector3.new(0,0,0), Vector3.new(0,0,0)),
								["Distance"] = .1,
								["Cframe"] = CFrame.new(),
								["Hit"] = v.Character:WaitForChild("Head")
							}
						end
					end
				end
			end
			game:GetService("ReplicatedStorage").ShootEvent:FireServer(Gen, Gun)
		end
		--
		if not TeamS then
			ChangeTeam(game.Teams.Criminals)
		end
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if not table.find(Whitelisted,v.Name) and v ~= plr then
				if (TeamS and v.Team == TeamS) or not TeamS then
					for i =1,10 do
						Gen[#Gen+1]={
							["RayObject"] = Ray.new(Vector3.new(0,0,0), Vector3.new(0,0,0)),
							["Distance"] = .1,
							["Cframe"] = CFrame.new(),
							["Hit"] = v.Character:WaitForChild("Head")
						}
					end
				end
			end
		end
		game:GetService("ReplicatedStorage").ShootEvent:FireServer(Gen, Gun)
		wait(.1)
		Last_Team(a)
		wait(.4)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = saved
end
function tase_all()
		local lastteam,Last = plr.TeamColor.Name,getpos()
		local Table = {}
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v and v.Team ~= game:GetService("Teams").Guards and v ~= plr then
				Table[#Table+1]={
					["RayObject"] = Ray.new(Vector3.new(972.877869, 101.489967, 2362.66821), Vector3.new(-53.8579292, -7.45228672, 83.9272766)),
					["Distance"] = 1,
					["Cframe"] = CFrame.new(969.60144, 100.734177, 2369.42334, 0.777441919, -0.0313242674, -0.628174186, 1.86264515e-09, 0.998758912, -0.0498036928, 0.628954709, 0.038719479, 0.776477098),
					["Hit"] = v.Character.HumanoidRootPart
				}
			end
		end
		if plr.Team ~= game.Teams.Guards then
			local ohString1 = "Bright blue"
			task.spawn(function()
				plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = Last
			end)
			workspace.Remote.TeamEvent:FireServer(ohString1)
		end
		repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser")
		game:GetService("ReplicatedStorage").ShootEvent:FireServer(Table, game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser"))
		task.spawn(function() game:GetService("ReplicatedStorage").ReloadEvent:FireServer(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser")) end)
		wait(.3)
		Last_Team(lastteam)
		plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = Last
end
function tase(player)
		print("Called")
		local lastteam,Last = plr.TeamColor.Name,getpos()
		if typeof(player):lower() == "string" then
			if game:GetService("Players"):FindFirstChild(player) then
				player = game:GetService("Players"):FindFirstChild(player)

			end
		end
		if table.find(Whitelisted,player.Name) then
			print("error is whitelisted - 1")
			return Notif("This player is whitelisted")
		end
		if plr.Team ~= game.Teams.Guards then
			local ohString1 = "Bright blue"
			task.spawn(function()
				plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = Last
			end)
			workspace.Remote.TeamEvent:FireServer(ohString1)
		end
		repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser")
		wait(.3)
		game:GetService("ReplicatedStorage").ShootEvent:FireServer({
			[1] = {
				["RayObject"] = Ray.new(Vector3.new(972.877869, 101.489967, 2362.66821), Vector3.new(-53.8579292, -7.45228672, 83.9272766)),
				["Distance"] = 1,
				["Cframe"] = CFrame.new(969.60144, 100.734177, 2369.42334, 0.777441919, -0.0313242674, -0.628174186, 1.86264515e-09, 0.998758912, -0.0498036928, 0.628954709, 0.038719479, 0.776477098),
				["Hit"] = player.Character.HumanoidRootPart
			}
		}, game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser"))
		print('ShotBullet')
		task.spawn(function() game:GetService("ReplicatedStorage").ReloadEvent:FireServer(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Taser")) end)
		print('Reloaded')
		wait(.4)
		Last_Team(lastteam)
		plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = Last
end
function AntiPunchC(v2)
		pcall(function()
			if v2 == plr then
				return
			end
			v2.Character:FindFirstChildOfClass("Humanoid").AnimationPlayed:Connect(function(animationTrack)
				if States.AntiPunch and not unloaded then
					if animationTrack.Animation.AnimationId == "rbxassetid://484200742" or animationTrack.Animation.AnimationId =="rbxassetid://484926359" then
						if (plr.Character.HumanoidRootPart.Position-v2.Character.HumanoidRootPart.Position).magnitude <3.5 and not table.find(Whitelisted,v2.Name) and not IsBringing then
							for i =1,13 do
								task.spawn(function()
									game.ReplicatedStorage["meleeEvent"]:FireServer(v2)
								end)
							end
						end
					end
				end
			end)
		end)
end
function bring(player,pos,Type,Extra)

		if player then
			local lastteam = plr.TeamColor.Name
			if plr.Team ~= game.Teams.Guards then
				local ohString1 = "Bright blue"
				workspace.Remote.TeamEvent:FireServer(ohString1)
			end
			task.spawn(function()
				wait(.1)
				if plr.Team ~= game.Teams.Guards then
					return
				end
			end)
			wait()
			local Done = false
			local _MAX = 0
			local Last = getpos()
			local Handcuffs = plr.Backpack:FindFirstChild("Handcuffs")
			local hrp = plr.Character:WaitForChild("HumanoidRootPart")
			if not pos then
				pos = getpos()
			end
			local Goto = pos
			repeat task.wait() Handcuffs = plr.Backpack:FindFirstChild("Handcuffs")  until Handcuffs and Handcuffs:FindFirstChild("Handle")
			Handcuffs.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
			wait(.1)
			if pos then
				MoveTo(pos)
				wait()
			end
			IsBringing = true
			wait(.1)
			local Hats = {}
			do
				--//Fix the stupid hat falling off because it looks good without it falling and because im not gay
				for i,v in pairs(plr.Character:GetChildren()) do
					if v and v:IsA("Accessory") then
						pcall(function()
							v.Handle.CanTouch = false
							Hats[#Hats+1] = {
								Hat = v,
								OldPosition = v.Handle:FindFirstChildOfClass("Weld").C0,
								OldPosition2 = v.Handle:FindFirstChildOfClass("Weld").C1
							}
							v.Handle.Anchored = true
						end)

					end
				end
			end
			do--//Glitch Humanoid
				task.spawn(function()
					plr.Character:FindFirstChildOfClass("Humanoid"):Destroy()
					Instance.new("Humanoid",plr.Character)
				end)
			end
			do
				local function FindHat(a)
					for i,v in pairs(Hats) do
						if v and v == a then
							return v
						end
					end
					return nil
				end
				--Fix hats 2
				for i,v in pairs(Hats) do
					if v then
						pcall(function()
							local Hat = v.Hat
							local NewWeld = Instance.new("Weld",Hat.Handle)
							NewWeld.Part0 = Hat.Handle
							NewWeld.Part1 = plr.Character.Head
							NewWeld.C0 = v.OldPosition
							NewWeld.C1 = v.OldPosition2
							Hat.Handle.Anchored = false
						end)
					end
				end
			end
			repeat task.wait()
				pcall(function()
					plr.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Handcuffs)
				end)
			until Handcuffs.Parent == plr.Character
			local crimpad = workspace["Criminals Spawn"].SpawnLocation
			crimpad.CanCollide = false
			crimpad.Transparency = 1
			repeat game:GetService("RunService").RenderStepped:Wait()
				if Handcuffs and Handcuffs:FindFirstChild("Handle") then
					task.spawn(function()
						_MAX = _MAX + 1
						MoveTo(Goto)
						player.Character:SetPrimaryPartCFrame(Handcuffs.Handle.CFrame)
						wait(.1)
					end)
				end
				if Handcuffs and Handcuffs:FindFirstChild("Handle") then
					touch(GetPlayersPart(player),Handcuffs.Handle)
					if Extra == "crim" then
						crimpad.CFrame = player.Character:GetPrimaryPartCFrame()
						touch(GetPlayersPart(player),crimpad)
					end
				end
			until Handcuffs.Parent ~= plr.Character or _MAX>200
			if pos then
				wait(.2)
				MoveToJunk(crimpad)
			end
			if Extra =="fling" then
				local b = Instance.new("BodyThrust",plr.Character.HumanoidRootPart)
				b.Force = Vector3.new(99999,10000,999999)
				b.Location = plr.Character.HumanoidRootPart.Position
				wait(.2)
			end
			game:GetService("Players").LocalPlayer.Character:MoveTo(player.Character.Head.Position)
			MoveTo(Last)--//stupid fix for it killing
			Last_Team(lastteam)
			plr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = Last
			Done = true
			task.spawn(function()
				wait(.4)
				if player.Character:FindFirstChild("HumanoidRootPart") and (player.Character:FindFirstChild("HumanoidRootPart").Position-Goto.Position).Magnitude >6 then
					if Extra and Extra == true and Extra ~="crim" or Extra == "fling" then
					else
						IsBringing = false
						return bring(player,Goto,Type,true)
					end
				end
			end)
			if pos then
				wait(.1)
			end
			IsBringing = false
			return
		end
	end


Kill_All()
