local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Функция для создания GUI
local function createGui(player)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local MessageBox = Instance.new("TextBox")
    local CountBox = Instance.new("TextBox")
    local SendButton = Instance.new("TextButton")
    local ToggleButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local SettingsButton = Instance.new("TextButton")
    local SettingsFrame = Instance.new("Frame")
    local LanguageButton = Instance.new("TextButton")
    local CensorshipToggle = Instance.new("TextButton")
    
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    -- Настройка Frame
    Frame.Size = UDim2.new(0, 300, 0, 250)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
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
    SendButton.Text = "Отправить" -- Перевод кнопки
    SendButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SendButton.BorderSizePixel = 0
    SendButton.Parent = Frame

    -- Настройка ToggleButton
    ToggleButton.Size = UDim2.new(0, 100, 0, 50)
    ToggleButton.Position = UDim2.new(0, 10, 0, 10)
    ToggleButton.Text = "Свернуть/Развернуть"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = ScreenGui

    -- Настройка CloseButton
    CloseButton.Size = UDim2.new(0, 50, 0, 50)
    CloseButton.Position = UDim2.new(1, -60, 0, 10)
    CloseButton.Text = "X"
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = Frame

    -- Настройка SettingsButton
    SettingsButton.Size = UDim2.new(0, 280, 0, 50)
    SettingsButton.Position = UDim2.new(0, 10, 0, 190)
    SettingsButton.Text = "Настройки"
    SettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsButton.BorderSizePixel = 0
    SettingsButton.Parent = Frame

    -- Настройка SettingsFrame
    SettingsFrame.Size = UDim2.new(0, 300, 0, 150)
    SettingsFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingsFrame.Visible = false
    SettingsFrame.Parent = ScreenGui

    -- Настройка LanguageButton
    LanguageButton.Size = UDim2.new(0, 280, 0, 50)
    LanguageButton.Position = UDim2.new(0, 10, 0, 10)
    LanguageButton.Text = "Изменить язык"
    LanguageButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    LanguageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LanguageButton.BorderSizePixel = 0
    LanguageButton.Parent = SettingsFrame

    -- Настройка CensorshipToggle
    CensorshipToggle.Size = UDim2.new(0, 280, 0, 50)
    CensorshipToggle.Position = UDim2.new(0, 10, 0, 70)
    CensorshipToggle.Text = "Цензура включена"
    CensorshipToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    CensorshipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CensorshipToggle.BorderSizePixel = 0
    CensorshipToggle.Parent = SettingsFrame

    -- Флаг для отслеживания состояния GUI
    local guiClosed = false
    local censorshipEnabled = true -- По умолчанию включена цензура
    local currentLanguage = "ru" -- По умолчанию русский

    -- Функция отправки сообщений
    local function sendMessages()
        local message = MessageBox.Text .. (censorshipEnabled and "" or " le le le le")
        local count = tonumber(CountBox.Text)

        if message ~= "" and count then
            for i = 1, count do
                local chatChannel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
                chatChannel:SendAsync(message)
                wait(1) -- Задержка в 1 секунду между сообщениями
            end
        else
            warn("Пожалуйста, введите корректное сообщение и количество.")
        end
    end

    SendButton.MouseButton1Click:Connect(sendMessages)

    -- Функция для сворачивания и разворачивания GUI
    local isFrameVisible = true
    ToggleButton.MouseButton1Click:Connect(function()
        isFrameVisible = not isFrameVisible
        Frame.Visible = isFrameVisible
        ToggleButton.Text = isFrameVisible and "Свернуть" or "Развернуть"
    end)

    -- Функция для открытия настроек
    SettingsButton.MouseButton1Click:Connect(function()
        SettingsFrame.Visible = true
    end)

    -- Функция для закрытия GUI
    CloseButton.MouseButton1Click:Connect(function()
        guiClosed = true
        ScreenGui:Destroy()
    end)

    -- Добавление кнопки закрытия настроек
    local SettingsCloseButton = Instance.new("TextButton")
    SettingsCloseButton.Size = UDim2.new(0, 50, 0, 50)
    SettingsCloseButton.Position = UDim2.new(1, -60, 0, 10)
    SettingsCloseButton.Text = "X"
    SettingsCloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SettingsCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsCloseButton.BorderSizePixel = 0
    SettingsCloseButton.Parent = SettingsFrame
    SettingsCloseButton.MouseButton1Click:Connect(function()
        SettingsFrame.Visible = false
    end)

    -- Функция для переключения цензуры
    CensorshipToggle.MouseButton1Click:Connect(function()
        censorshipEnabled = not censorshipEnabled
        CensorshipToggle.Text = censorshipEnabled and "Цензура включена" or "Цензура отключена"
    end)

    -- Функция для смены языка
    LanguageButton.MouseButton1Click:Connect(function()
        currentLanguage = (currentLanguage == "ru") and "en" or "ru"
        MessageBox.PlaceholderText = (currentLanguage == "ru") and "Введите сообщение" or "Enter message"
        CountBox.PlaceholderText = (currentLanguage == "ru") and "Введите количество" or "Enter count"SendButton.Text = (currentLanguage == "ru") and "Отправить" or "Send"
        ToggleButton.Text = (currentLanguage == "ru") and "Свернуть/Развернуть" or "Collapse/Expand"
        SettingsButton.Text = (currentLanguage == "ru") and "Настройки" or "Settings"
        LanguageButton.Text = (currentLanguage == "ru") and "Изменить язык" or "Change Language"
        CensorshipToggle.Text = censorshipEnabled and 
            ((currentLanguage == "ru") and "Цензура включена" or "Censorship Enabled") or 
            ((currentLanguage == "ru") and "Цензура отключена" or "Censorship Disabled")
    end)

    print("Создан GUI для игрока: " .. player.Name)
end

-- Создание GUI для каждого игрока
Players.PlayerAdded:Connect(function(player)
    createGui(player)
end)

-- Создание GUI для уже существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    createGui(player)
end

-- Обеспечение непрерывной работы скрипта
RunService.RenderStepped:Connect(function()
    -- Здесь можно добавить любой код, который должен выполняться постоянно
end)

print("Скрипт загружен и работает.")
