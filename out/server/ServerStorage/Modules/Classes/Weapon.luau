-- Compiled with roblox-ts v3.0.0
local WeaponClass
do
	WeaponClass = setmetatable({}, {
		__tostring = function()
			return "WeaponClass"
		end,
	})
	WeaponClass.__index = WeaponClass
	function WeaponClass.new(...)
		local self = setmetatable({}, WeaponClass)
		return self:constructor(...) or self
	end
	function WeaponClass:constructor(model, bullet, bulletSpeed, damage, cooldown, range)
		self.model = model
		self.bullet = bullet
		self.bulletSpeed = bulletSpeed
		self.damage = damage
		self.cooldown = cooldown
		self.range = range
	end
end
return {
	default = WeaponClass,
}
