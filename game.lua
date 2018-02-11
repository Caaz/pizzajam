-- require player
-- require platform
-- require coin

_ichor.add('game', {
  init = function(this)
    -- called when this state begins
    -- this.player = class_player{}
    this.score = 0
    this.tick = 0
    this.mobs = {
      class_player{x=60,y=58},
      class_platform{ set= true },
    }
    -- this.mobs[2]:set_side(false)
    this.mobs[2].x = 40
    this.mobs[2].y = 64
    this.mobs[2].vel_x = 1
    this:add_coin()
  end,
  add_coin = function(this)
    add(this.mobs, class_coin{})
  end,
  update = function(this)
    this.tick += 1
    if(this.tick%20 == 0) then
      add(this.mobs,class_platform{})
    end
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
    print('score: '..this.score)
  end
})
