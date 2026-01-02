local Jack = {}
function Jack:new(x, y, sprite, frames)
  local image = love.graphics.newImage(sprite)
  local obj = {
    x = x,
    y = y,
    sprite = {
      image = image,
      width = image:getWidth(),
      height = image:getHeight(),
      quad_width = image:getWidth() / frames,
      quad_height = image:getHeight(),
      currentFrame = 1,
      quads = {}
    },
    animation = {
      direction = "right",
      idle = false,
      frame = 1,
      max_frames = frames,
      speed = 20,
      timer = 0.1
    }
  }
  for i = 1, obj.animation.max_frames do
    obj.sprite.quads[i] = love.graphics.newQuad((i - 1) * obj.sprite.quad_width, 0, obj.sprite.quad_width, obj.sprite.quad_height, obj.sprite.width, obj.sprite.height)
  end
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Jack.update = function(self, dt)
  if love.keyboard.isDown("right") then
    self.x = self.x + (self.animation.speed * dt)
    self.animation.idle = false
    self.animation.direction = "right"
  elseif love.keyboard.isDown("left") then
    self.x = self.x - (self.animation.speed * dt)
    self.animation.idle = false
    self.animation.direction = "left"
  else
    self.animation.idle = true
    self.animation.frame = 1
    self.sprite.currentFrame = self.animation.frame
  end
  if not self.animation.idle then
    self.animation.timer = self.animation.timer + dt
    if self.animation.timer > 0.2 then
      self.animation.timer = 0.1
      self.animation.frame = self.animation.frame + 1
      if self.animation.direction == "right" then
        self.x = self.x + self.animation.speed
      elseif self.animation.direction == "left" then
        self.x = self.x - self.animation.speed
      end
      if self.animation.frame > self.animation.max_frames then
        self.animation.frame = 1
      end
      self.sprite.currentFrame = self.animation.frame
    end
  end
end

Jack.draw = function(self)
  love.graphics.scale(0.3)
  if self.animation.direction == "right" then
      love.graphics.draw(self.sprite.image, self.sprite.quads[self.sprite.currentFrame], self.x, self.y)
  elseif self.animation.direction == "left" then
      love.graphics.draw(self.sprite.image, self.sprite.quads[self.sprite.currentFrame], self.x, self.y, 0, -1, 1, self.sprite.quad_width, 0)
  end
  love.graphics.scale(1)
end

return Jack