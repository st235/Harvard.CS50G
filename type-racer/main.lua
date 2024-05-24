require 'src/Dependencies'

function love.config(c)
    -- enable console debugging
    c.console = true
end

function love.load()
    math.randomseed(os.time())

    love.window.setTitle(APP_TITLE)
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()
    gStateStack:push(PlayState())
    gStateStack:push(CountDownState(4))

    love.keyboard.keyPressed = {}
    love.keyboard.symbolsQueue = Queue()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keyPressed[key] or false
end

function love.textinput(t)
    love.keyboard.symbolsQueue:enqueue(t)
end

function love.keyboard.hasPendingSymbols()
    return not love.keyboard.symbolsQueue:isEmpty()
end

function love.keyboard.consumePendingSymbol()
    return love.keyboard.symbolsQueue:remove()
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keyPressed = {}
    love.keyboard.symbolsQueue:clear()
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
