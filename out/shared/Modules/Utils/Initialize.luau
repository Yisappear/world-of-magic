-- Compiled with roblox-ts v3.0.0
local function initialize(folder)
	if folder == nil or folder:IsA("Folder") == false then
		return nil
	end
	local Table = folder:GetChildren()
	for _, v in Table do
		if v:IsA("ModuleScript") then
			local module = require(v)
		end
	end
end
return {
	default = initialize,
}
