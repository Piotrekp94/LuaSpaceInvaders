level = {}


function level:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.enemiesList = {}
    self.isFinished = false
    return o
end

function level:draw()
    error("Draw is abstract method please use subclass!")
end
