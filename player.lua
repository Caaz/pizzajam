-- require class
-- require mob

class_player = class{
  extends = class_mob,
  new = function(this,args)
    class_mob.new(this,args)
  end,
  update = function(this)
    if btn(0) then this.vel_x = -2
    elseif btn(1) then this.vel_x = 2
    else this.vel_x = 0 end
    if btn(2) then this.vel_y = -2
    elseif btn(3) then this.vel_y = 2
    else this.vel_y = 0 end
    class_mob.update(this)
  end
}
