local function createGui(player)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local MessageBox = Instance.new("TextBox")
    local CountBox = Instance.new("TextBox")
    local SendButton = Instance.new("TextButton")
    local ToggleButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local SettingsButton = Instance.new("TextButton")
    local CensorshipButton = Instance.new("TextButton")
    local NotificationLabel = Instance.new("TextLabel")

    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Настройка Frame
    Frame.Size = UDim2.new(0, 300, 0, 300)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    -- Настройка MessageBox
    MessageBox.Size = UDim2.new(0, 280, 0, 50)
    MessageBox.Position = UDim2.new(0, 10, 0, 10)
    MessageBox.PlaceholderText = "Введите сообщение"
    MessageBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MessageBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    MessageBox.BorderSizePixel = 0
    MessageBox.Parent = Frame

    -- Настройка CountBox
    CountBox.Size = UDim2.new(0, 280, 0, 50)
    CountBox.Position = UDim2.new(0, 10, 0, 70)
    CountBox.PlaceholderText = "Введите количество"
    CountBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CountBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    CountBox.BorderSizePixel = 0
    CountBox.Parent = Frame

    -- Настройка SendButton
    SendButton.Size = UDim2.new(0, 280, 0, 50)
    SendButton.Position = UDim2.new(0, 10, 0, 130)
    SendButton.Text = "Отправить"
    SendButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SendButton.BorderSizePixel = 0
    SendButton.Parent = Frame

    -- Настройка ToggleButton
    ToggleButton.Size = UDim2.new(0, 140, 0, 50)
    ToggleButton.Position = UDim2.new(0, 10, 0, 190)
    ToggleButton.Text = "Переключить"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = Frame

    -- Настройка CloseButton
    CloseButton.Size = UDim2.new(0, 50, 0, 50)
    CloseButton.Position = UDim2.new(1, -60, 0, 10)
    CloseButton.Text = "Закрыть"
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = Frame

    -- Настройка SettingsButton
    SettingsButton.Size = UDim2.new(0, 100, 0, 50)
    SettingsButton.Position = UDim2.new(0, 160, 0, 190)
    SettingsButton.Text = "Настройки"
    SettingsButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsButton.BorderSizePixel = 0
    SettingsButton.Parent = Frame

    -- Настройка CensorshipButton
    CensorshipButton.Size = UDim2.new(0, 280, 0, 50)
    CensorshipButton.Position = UDim2.new(0, 10, 0, 250)
    CensorshipButton.Text = "Отключение цензуры"
    CensorshipButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    CensorshipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CensorshipButton.BorderSizePixel = 0
    CensorshipButton.Parent = Frame

    -- Настройка NotificationLabel
    NotificationLabel.Size = UDim2.new(0, 200, 0, 50)
    NotificationLabel.Position = UDim2.new(0.5, -100, 0, -60)
    NotificationLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationLabel.Text = ""
    NotificationLabel.Visible = false
    NotificationLabel.Parent = ScreenGui

    -- Переменная для хранения состояния кнопки цензуры
    local isCensorshipEnabled = true

    -- Обработчик нажатия кнопки "Send"
    SendButton.MouseButton1Click:Connect(function()
        local message = MessageBox.Text
        if not isCensorshipEnabled then
            message = message .. " le le le le"
        end
        NotificationLabel.Text = "Сообщение отправлено: " .. message
        NotificationLabel.Visible = true
        wait(2)
        NotificationLabel.Visible = false
    end)

    -- Обработчик нажатия кнопки "Close"
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Обработчик нажатия кнопки "Censorship"
    CensorshipButton.MouseButton1Click:Connect(function()
        isCensorshipEnabled = not isCensorshipEnabled
        if isCensorshipEnabled then
            CensorshipButton.Text = "Отключение цензуры"
        else
            CensorshipButton.Text = "Включение цензуры"
        end
    end)
end
