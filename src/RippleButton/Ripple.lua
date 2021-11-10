local Hooks = require(script.Parent.Parent.Parent.Hooks)
local Roact = require(script.Parent.Parent.Parent.Roact)
local RoactFlipper = require(script.Parent.Parent.Parent.RoactFlipper)
local Flipper = require(script.Parent.Parent.Parent.Flipper)

local function Ripple(props, hooks)
	local sizeBinding, sizeMotor = RoactFlipper.useSpring(0, {}, hooks)
	hooks.useEffect(function()
		sizeMotor:setGoal(Flipper.Spring.new(2.5, {
			frequency = 2,
			dampingRatio = 1,
		}))
	end)

	return Roact.createElement("ImageLabel", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Position = props.Position,
		Image = "rbxassetid://7953074888",
		ZIndex = props.ZIndex,
		AnchorPoint = Vector2.new(0.5, 0.5),
		SizeConstraint = Enum.SizeConstraint.RelativeXX,
		Size = sizeBinding:map(function(size)
			return UDim2.fromScale(size, size)
		end),
		ImageTransparency = props.Transparency:map(function(transparency)
			return transparency
		end),
		ImageColor3 = props.RippleColor,
	}, props[Roact.Children])
end

return Hooks.new(Roact)(Ripple)
