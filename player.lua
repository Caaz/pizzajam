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
    this.vel_y = 1
    -- if btn(2) then this.vel_y = -2
    -- elseif btn(3) then this.vel_y = 2
    -- else this.vel_y = 0 end
  end
}
