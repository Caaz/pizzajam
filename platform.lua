-- require class
-- require mob

class_platform = class{
  extends = class_mob,
  new = function(this,args)
    class_mob.new(this,args)
  end
}
