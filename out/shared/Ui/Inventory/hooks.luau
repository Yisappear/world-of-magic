-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local React = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "react")
-- main frame
local function changeMainFrameVisbile()
	local mVisible, changeState = React.useState(false)
	local changeMVisible = function()
		return changeState(function(v)
			return not v
		end)
	end
	return mVisible, changeMVisible
end
return {
	changeMainFrameVisbile = changeMainFrameVisbile,
}
