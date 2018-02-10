-- require player

_ichor.add('game', {
  init = function(this)
    -- called when this state begins
    this.player = class_player{}
  end,
  update = function(this)
    -- called every update when this state is active
    this.player:update()
  end,
  draw = function(this)
    -- called every draw when this state is active.
    this.player:draw()
  end
})
