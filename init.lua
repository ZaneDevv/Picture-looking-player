if not game:IsLoaded() then game.Loaded:Wait() end

local runService = game:GetService('RunService')

local player = game:GetService('Players').LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local pictureCenter = workspace.Picure:GetPivot().Position

local dummy = game:GetService('ReplicatedStorage').Dummy:Clone()
local headDummy = dummy.Head
local neckC0 = headDummy.Neck.C0
local neckC0Position = CFrame.new(neckC0.Position)

local viewport = script.Parent.Viewport

local camera = Instance.new('Camera') do
	camera.FieldOfView = 50
	
	dummy.Parent = viewport.WorldModel
	camera.CFrame = headDummy.CFrame * CFrame.new(0, 0, .75 * headDummy.Size.Y / math.tan(camera.FieldOfView * .5), -1, 0, 0, 0, 1, 0, 0, 0, -1)
	
	camera.Parent = viewport
	viewport.CurrentCamera = camera
end


local headSpeed = 5


local tau = math.pi * 2

local minAngleX = math.pi / 180 * -50 + tau
local maxAngleX = math.pi / 180 * 50 + tau



local Matrix = require(script.Matrix)



while true do
	local deltaTime = runService.Heartbeat:Wait()
	
	local playerCFrame = character:GetPivot()
	local playerToPicture = pictureCenter - playerCFrame.Position
	local dot = playerCFrame.LookVector:Dot(playerToPicture.Unit)
	
	if dot > ((playerToPicture.Magnitude <= 20) and .3 or .85) then
		headDummy.Neck.C0 = headDummy.Neck.C0:Lerp(neckC0, deltaTime * headSpeed)
		
	else
		local cframeTraget = (Matrix.byAngleX(math.clamp((math.atan2(playerToPicture.Y, playerToPicture.X) + math.pi) % tau, minAngleX, maxAngleX))
			* Matrix.byAngleY(math.atan2(playerToPicture.Z, playerToPicture.X) + math.pi)):GetCFrame(neckC0Position)
		
		headDummy.Neck.C0 = headDummy.Neck.C0:Lerp(cframeTraget, deltaTime * headSpeed)
	end
end
