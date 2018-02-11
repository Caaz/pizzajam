-- require class
-- require mob
-- require animator

local max_movement = 3
-- local speed = .6
class_player = class{
  extends = class_mob,
  new = function(this,args)
    merge(args,{
      width = 6,
      height = 7,
      vel_y = 2,
      side_force = 0,
      animator = class_animator{
        animations = {
          class_animation{
            speed = 10,
            frames = {
              {1,17,6,7},
              {1,26,6,6,0,1},
            }
          },
          class_animation{
            speed = 3,
            frames = {
              {1,17,6,7},
              {9,17,6,7},
              {17,16,6,6,0,-2},
              {25,17,6,7}
            }
          }
        }
      }
    })
    -- coin frames
    -- {0,0,8,8},
    -- {0,0,8,8},
    -- {0,0,8,8},
    -- {8,0,6,8,1},
    -- {14,0,4,8,2},
    -- {18,0,6,8,1}
    class_mob.new(this,args)
  end,
  poof = function(this)
    for i = 1,15 do
      _ichor.modules.particle_system:add(class_particle{
        x = this.x+this.width,
        y = this.y+this.height,
        size = 2,
        vel_y = rnd(2)-1,
        vel_x = rnd(2)-1,
      })
    end
  end,
  burst = function(this,right)
    for i = 1,5 do
      _ichor.modules.particle_system:add(class_particle{
        x = this.x+this.width,
        y = this.y+this.height,
        size = 2,
        vel_y = -rnd(1),
        vel_x = (right and 1 or -1)*rnd(2)
      })
    end
  end,
  update = function(this)
    class_mob.update(this)
    this.x %= 128
    if this.on then
      this.vel_x = this.on.vel_x
      -- this.vel_y = this.on.vel_y
    else
      this.vel_x = 0
    end
    if this.on_floor then
      this.on_wall = false
    else
    end
    if btn(0) then
      if not this.moving and this.on then this:burst(true) end
      this.moving = true
      this.animator:set_animation(2)
      this.vel_x -= max_movement
      this.facing_left = true
    elseif btn(1) then
      if not this.moving and this.on then this:burst(false) end
      this.moving = true
      this.animator:set_animation(2)
      this.vel_x += max_movement
      this.facing_left = false
    else
      this.moving = false
      this.animator:set_animation(1)
    end
    if btnp(2) or btnp(4) then
      if this.on_floor then
        this.vel_y = -5
        -- this:poof()
      elseif this.on_wall then
        this.vel_y = -5
        this.side_force = (this.wall_side and -6 or 6)
      elseif this.has_jump then
        this.vel_y = -5
        this.has_jump = false
        this:poof()
      end
    end
    if btnp(3) and this.on then
      this.on.clear = false
    end
    this.vel_y = min(this.vel_y + .5, 5)
    if this.side_force != 0 then
      this.side_force -= this.side_force/6
    end
    this.vel_x += this.side_force
    this.on_floor = false
    this.on_wall = false
    this.on = nil
    if this.y > 150 then
      _ichor.set_state('game')
    end
  end,
  collide = function(this,that,x,vel)
    if that.coin then
      local game = _ichor.modules.game
      for i = 0, 10 do
        _ichor.modules.particle_system:add(class_particle{
          x = that.x+that.width/2,
          y = that.y+that.height/2,
          size = 4,
          vel_y = rnd(3)-1.5,
          vel_x = rnd(3)-1.5,
          color = rnd()+10,
          decay = .7,
        })
      end
      del(game.mobs,that)
      game.score += 1
      game:add_coin()
      return
    elseif that.clear then return end
    class_mob.collide(this,that,x,vel)
    if x then
      this.on_wall = true
      this.wall_side = vel > 0
    elseif vel > 0 then
      this.on = that
      this.on_x = that.x
      this.on_floor = true
      this.has_jump = true
    end
  end,
  draw = function(this)
    -- class_mob.draw(this)
    this.animator:draw(this.x,this.y,nil,nil,this.facing_left)
    if this.on_wall then
      pset(this.x,this.y,8)
    end
    if this.on_floor then
      pset(this.x+1,this.y,9)
    end
  end
}
