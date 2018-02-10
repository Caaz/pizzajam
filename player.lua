-- require class
-- require mob
-- require animator

local max_movement = 3
local speed = .6
class_player = class{
  extends = class_mob,
  new = function(this,args)
    merge(args,{
      width = 8,
      height = 8,
      vel_y = 2,
      animator = class_animator{
        animations = {
          class_animation{
            speed = 4,
            frames = {
              {0,0,8,8},
              {0,0,8,8},
              {0,0,8,8},
              {8,0,6,8,1},
              {14,0,4,8,2},
              {18,0,6,8,1}
            }
          }
        }
      }
    })
    class_mob.new(this,args)
  end,
  update = function(this)
    class_mob.update(this)
    if this.on then
      local x_change = this.on.x - this.on_x
      this.vel_x = x_change *1.2
      -- this.vel_x += (x_change > 0 and .01 or -.01)
      this.on = nil
    end
    if this.on_floor then
      this.vel_x -= this.vel_x/5
      this.on_wall = false
    else
      this.vel_x -= this.vel_x/10
    end
    if btn(0) then this.vel_x = max(this.vel_x-speed,-max_movement)
    elseif btn(1) then this.vel_x = min(this.vel_x+speed,max_movement) end
    if btnp(2) or btnp(4) then
      if this.on_floor then
        this.vel_y = -5
      elseif this.on_wall then
        this.vel_y = -5
        this.vel_x = (this.wall_side and -4 or 4)
        this.on_wall = false
      end
    end
    this.vel_y = min(this.vel_y + .5, 5)
    this.on_floor = false
  end,
  collide = function(this,that,x,vel)
    class_mob.collide(this,that,x,vel)
    if x then
      this.on_wall = true
      this.wall_side = vel > 0
    elseif vel > 0 then
      this.on = that
      this.on_x = that.x
      this.on_floor = true
    end
  end,
  draw = function(this)
    class_mob.draw(this)
    this.animator:draw(this.x,this.y)
    if this.on_wall then
      pset(this.x,this.y,8)
    end
    if this.on_floor then
      pset(this.x+1,this.y,9)
    end
  end
}
