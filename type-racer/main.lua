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
    gStateStack:push(StartState())
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end
