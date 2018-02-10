-- require class
-- require table/merge

class_mob = class{
  new = function(this,args)
    merge(this, {
      x = 0,
      y = 0,
      vel_x = 0,
      vel_y = 0,
      width = 0,
      height = 0
    })
    merge(this,args)
  end,
  aabb = function(this,that)
    return (that.x < this.x + this.width and
    that.x + that.width > this.x and
    that.y < this.y + this.height and
    that.height + that.y > this.y)
  end,
  update = function(this)
    this.x += this.vel_x
    this.y += this.vel_y
  end,
  draw = function(this)
    local x,y = flr(this.x),flr(this.y)
    rect(x, y, x + this.width-1, y + this.height-1, 7)
  end,
  collide = function(this,that,x,vel)
    if vel != 0 then
      local key = 'vel_'..(x and 'x' or 'y')
      this[key] = 0
      local a = 'y'
      local b = 'height'
      if x then a = 'x' b = 'width' end
      this[a] = that[a] + (vel <= 0 and that[b] or -this[b])
    -- else
    end
  end
}
