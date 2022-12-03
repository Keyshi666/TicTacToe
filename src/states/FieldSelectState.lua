FieldSelectState = Class{__includes = BaseState}

local highlighted = 0

function FieldSelectState:enter(params)
    self.opponent1 = params.opponent1
	self.opponent2 = params.opponent2
end

function FieldSelectState:init()
    self.currentField = 1
end

function FieldSelectState:update(dt)
	if love.keyboard.wasPressed('up') then
		highlighted = (highlighted - 1) % 3
	elseif love.keyboard.wasPressed('down') then
		highlighted = (highlighted + 1) % 3
    end

    -- select paddle and move on to the serve state, passing in the selection
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then

		if highlighted == 0 then
			self.field = Field(3)
        elseif highlighted == 1 then
            self.field = Field(4)
        else
			self.field = Field(5)
		end
		
        gStateMachine:change('play', {
            opponent1 = self.opponent1,
            opponent2 = self.opponent2,
			field = self.field
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function FieldSelectState:render()
    -- instructions
    love.graphics.setColor(156/255, 0, 84, 1)
    love.graphics.printf("Select field to play!", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
    love.graphics.printf("(Press Enter to continue!)", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
        
		
    if highlighted == 0 then
        love.graphics.setColor(love.math.colorFromBytes(250, 110, 133))
    end
    love.graphics.printf("3x3", 0, VIRTUAL_HEIGHT / 2 - 15,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(156/255, 0, 84, 1)

    if highlighted == 1 then
        love.graphics.setColor(love.math.colorFromBytes(250, 110, 133))
    end
    love.graphics.printf("4x4", 0, VIRTUAL_HEIGHT / 2 + 15,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(156/255, 0, 84, 1)

    -- render blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(love.math.colorFromBytes(250, 110, 133))
    end
    love.graphics.printf("5x5", 0, VIRTUAL_HEIGHT / 2 + 45,
        VIRTUAL_WIDTH, 'center')

end