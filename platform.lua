-- require class
-- require mob

class_platform = class{
  extends = class_mob,
  new = function(this,args)
    this.tick = 1
    class_mob.new(this,args)
  end,
  update = function(this)
    if this.moves then
      this.tick += 1
      this.x = sin(this.tick/128)*64+32
    end
    -- class_mob.update(this)
  end,
  draw = function(this)
    local x,y = flr(this.x),flr(this.y)
    rect(x, y, x + this.width-1, y + this.height-1, (this.clear and 5 or 7))
  end
}
