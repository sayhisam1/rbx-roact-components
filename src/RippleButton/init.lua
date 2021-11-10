local Hooks = require(script.Parent.Parent.Hooks)
local Roact: Roact = require(script.Parent.Parent.Roact)
local Flipper = require(script.Parent.Parent.Flipper)
local Ripple = require(script.Ripple)

local function RippleButton(props, hooks)
	local activeRipples, setActiveRipples = hooks.useState({})
	local rippleCounter = hooks.useValue(1)

    local children = {}

    children["RippleContainer"] = Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = (props.ZIndex and props.ZIndex+1) or 2,
	}, activeRipples)

    children["Content"] = Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = (props.ZIndex and props.ZIndex+2) or 3,
	}, props[Roact.Children])

    children["uicorner"] = Roact.createElement("UICorner", {
        CornerRadius = UDim.new(0, 2),
    })
    -- hacky way to tell if the button has been unmounted
    local isMounted = true
	hooks.useEffect(function()
		return function()
			isMounted = false
		end
	end)

    local connections = hooks.useValue({})
    hooks.useEffect(function()
        return function()
            for _, connection in pairs(connections.value) do
                connection:Disconnect()
            end
        end
    end)

    return Roact.createElement("TextButton", {
		[Roact.Event.InputBegan] = function(button: ImageButton, inputObject: InputObject)
            if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            if inputObject.UserInputState ~= Enum.UserInputState.Begin then
                return
            end
			local inputScreenPosition = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
			local inputButtonPosition = inputScreenPosition - button.AbsolutePosition
			local inputPositionScaled = Vector2.new(
				inputButtonPosition.X / button.AbsoluteSize.X,
				inputButtonPosition.Y / button.AbsoluteSize.Y
			)
			local currCounter = rippleCounter.value
			rippleCounter.value += 1
            local transparencyBinding, setTransparency = Roact.createBinding(.5)
			activeRipples[currCounter] = Roact.createElement(Ripple, {
				Position = UDim2.fromScale(inputPositionScaled.X, inputPositionScaled.Y),
				ZIndex = button.ZIndex + 1,
				RippleColor = props.RippleColor,
                Transparency = transparencyBinding,
			})
			setActiveRipples(activeRipples)
            connections[currCounter] = inputObject.Changed:Connect(function()
                if inputObject.UserInputState == Enum.UserInputState.End then
                    connections[currCounter]:Disconnect()
                    connections[currCounter] = nil
                    local motor = Flipper.SingleMotor.new(transparencyBinding:getValue())
                    motor:setGoal(Flipper.Spring.new(1, {
                        frequency = 2
                    }))
                    motor:onStep(setTransparency)

                    -- clean up ripples after a delay
                    task.delay(2, function()
                        if not isMounted then
                            return
                        end
                        activeRipples[currCounter] = nil
                        setActiveRipples(activeRipples)
                    end)
                end
            end)
		end,
		BackgroundTransparency = props.BackgroundTransparency,
		BackgroundColor3 = props.BackgroundColor3,
		Size = props.Size,
		Position = props.Position,
        ZIndex = props.ZIndex or 1,
        AutoButtonColor = false,
        Text = "",
        BorderSizePixel = 0,
	}, children)
end

return Hooks.new(Roact)(RippleButton)
