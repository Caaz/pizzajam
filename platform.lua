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
      this.x = sin(this.tick/128)*32+32
    end
    -- class_mob.update(this)
  end
}
