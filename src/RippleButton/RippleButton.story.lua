local Roact = require(script.Parent.Parent.Parent.Roact)
local RippleButton = require(script.Parent)

return function(target)
	local buttons = Roact.createElement("Frame",{
		Size= UDim2.fromScale(1,1),
		BackgroundColor3=Color3.fromRGB(241, 241, 241),
	}, {
		Roact.createElement(RippleButton, {
			Size = UDim2.fromOffset(150, 50),
			Position = UDim2.fromOffset(10, 10),
			RippleColor = Color3.fromRGB(130, 34, 240),
			BackgroundColor3 = Color3.fromRGB(81, 0, 173),
			BackgroundTransparency = 0
		}, {
			Content = Roact.createElement("TextLabel", {
				Text = "BUTTON1",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(.5, .5),
				AnchorPoint = Vector2.new(.5, .5),
				FontSize = Enum.FontSize.Size18,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255,255,255),
				Font = Enum.Font.JosefinSans,
				ZIndex = 4,
			}),
		}),
		Roact.createElement(RippleButton, {
			Size = UDim2.fromOffset(150, 50),
			Position = UDim2.fromOffset(10, 70),
			RippleColor = Color3.fromRGB(130, 34, 240),
			BackgroundColor3 = Color3.fromRGB(81, 0, 173),
			BackgroundTransparency = 0
		}, {
			Content = Roact.createElement("TextLabel", {
				Text = "BUTTON2",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(.5, .5),
				AnchorPoint = Vector2.new(.5, .5),
				FontSize = Enum.FontSize.Size18,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255,255,255),
				Font = Enum.Font.JosefinSans,
				ZIndex = 4,
			}),
		}),
		Roact.createElement(RippleButton, {
			Size = UDim2.fromOffset(150, 50),
			Position = UDim2.fromOffset(10, 130),
			RippleColor = Color3.fromRGB(130, 34, 240),
			BackgroundColor3 = Color3.fromRGB(81, 0, 173),
			BackgroundTransparency = 0
		}, {
			Content = Roact.createElement("TextLabel", {
				Text = "BUTTON3",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(.5, .5),
				AnchorPoint = Vector2.new(.5, .5),
				FontSize = Enum.FontSize.Size18,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255,255,255),
				Font = Enum.Font.JosefinSans,
				ZIndex = 4,
			}),
		}),
	})
	local handle = Roact.mount(buttons, target)

	return function()
		Roact.unmount(handle)
	end
end
