local TweenService = game:GetService("TweenService")
local SelectionHighlightSystem = {}

export type SelectionHighlightParameters = {
	UIStrokeObject: UIStroke,
	NonSelectTransparency: number,
	SelectTransparency: number,
	
	MouseEnterSignal: RBXScriptSignal,
	MouseLeaveSignal: RBXScriptSignal,
	
	CustomTweenInfoParameters: TweenInfo?

}

function SelectionHighlightSystem.new(UIStrokeObject: UIStroke, NonSelectTransparency: number, SelectTransparency: number, MouseEnterSignal: RBXScriptSignal, MouseLeaveSignal: RBXScriptSignal, CustomTweenInfoParameters: TweenInfo?): SelectionHighlightParameters
	local function tween(object, properties, tweeninfo)
		TweenService:Create(object, tweeninfo, properties):Play()
	end
	
	local self = setmetatable({}, {__index = SelectionHighlightSystem})
	self.UIStrokeObject = UIStrokeObject
	self.NonSelectTransparency = NonSelectTransparency
	self.SelectTransparency = SelectTransparency
	self.MouseEnterSignal = MouseEnterSignal
	self.MouseLeaveSignal = MouseLeaveSignal
	self.CustomTweenInfoParameters = CustomTweenInfoParameters or nil
	
	self.MouseEnterSignal:Connect(function()
		tween(self.UIStrokeObject, {Transparency = self.SelectTransparency}, self.CustomTweenInfoParameters or TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))
	end)
	
	self.MouseLeaveSignal:Connect(function()
		tween(self.UIStrokeObject, {Transparency = self.NonSelectTransparency}, self.CustomTweenInfoParameters or TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))
	end)
	
	return self
end

return SelectionHighlightSystem