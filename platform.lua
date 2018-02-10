-- require class
-- require mob

class_platform = class{
  extends = class_mob,
  new = function(this,args)
    -- this.tick = 1
    class_mob.new(this,args)
    -- local v = rnd()>.5
    this:set_side(this.set or rnd()>.5)
  end,
  set_side = function(this,v)
    local antikey = (v and 'y' or 'x')
    local key = (v and 'x' or 'y')
    local positive = rnd()>.5
    this['vel_'..key] = (positive and 2 or -2)
    this[key] = (positive and -64 or 192)
    this[antikey] = rnd(120)
    if not v then
      this.width = 8
      this.height = 64
    else
      this.width = 64
      this.height = 8
    end
  end,
  update = function(this)
    class_mob.update(this)
    if this.x > 256 or this.x < -256 or this.y > 256 or this.y < -256 then
      del(_ichor.modules.game.mobs,this)
    end
  end,
  collide = function() end,
  draw = function(this)
    local x,y = flr(this.x),flr(this.y)
    rect(x, y, x + this.width-1, y + this.height-1, (this.clear and 5 or 7))
  end
}
