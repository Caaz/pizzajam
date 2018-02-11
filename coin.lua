-- require class
-- require mob
-- require table/merge
-- require animator

class_coin = class{
  coin = true,
  extends = class_mob,
  new = function(this,args)
    class_mob.new(this,args)
    merge(this,{
      x = flr(rnd(16))*8,
      y = flr(rnd(16))*8,
      width = 8,
      height = 8,
      animator = class_animator{
        animations = {
          class_animation{
            speed = 3,
            frames = {
              {0,0,8,8},
              {0,0,8,8},
              {0,0,8,8},
              {8,0,6,8,1},
              {14,0,4,8,2},
              {18,0,6,8,1}
            }
          },
        }
      }
    })
  end,
  draw = function(this)
    this.animator:draw(this.x,this.y)
  end
}
