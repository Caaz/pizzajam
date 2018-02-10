-- require class
-- require mob

class_player = class{
  extends = class_mob,
  new = function(this,args)
    merge(args,{
      width = 8,
      height = 8,
      vel_y = 2,
    })
    class_mob.new(this,args)
  end,
  update = function(this)
    class_mob.update(this)
    if btn(0) then this.vel_x = -2
    elseif btn(1) then this.vel_x = 2
    else this.vel_x = 0 end
    if btnp(2) or btnp(4) then this.vel_y = -5 end
    this.vel_y = min(this.vel_y + .5, 5)
  end
}
