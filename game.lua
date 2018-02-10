-- require player
-- require platform

_ichor.add('game', {
  init = function(this)
    -- called when this state begins
    -- this.player = class_player{}
    this.mobs = {
      class_player{x=70},
      class_platform{
        x = 64,
        y = 64,
        width = 40,
        height = 10
      }
    }
  end,
  update = function(this)
    -- called every update when this state is active
    local mobs = this.mobs
    for i, mob in pairs(mobs) do
      mob:update(this)
      for i, that in pairs(mobs) do
        if mob == that then goto continue end
        for set in all({
          {
            key = 'vel_x',
            aabb = {
              x = mob.x+mob.vel_x,
              y = mob.y,
              width = mob.width,
              height = mob.height,
            }
          },
          {
            key = 'vel_y',
            aabb = {
              x = mob.x,
              y = mob.y+mob.vel_y,
              width = mob.width,
              height = mob.height,
            }
          },
        }) do
          if mob[set.key] != 0 then
            if that:aabb(set.aabb) then
              mob:collide(that,(set.key == 'vel_x'),mob[set.key])
            end
          end
        end
        ::continue::
      end
    end
  end,
  draw = function(this)
    -- called every draw when this state is active.
    for mob in all(this.mobs) do mob:draw() end
  end
})
