local HUMAN_FORM = 0
local BEAST_FORM = 1
dragonmaiden = {
  initial_properties = {
    hp_max = 10,
    visual = "mesh",
    mesh = "",
    textures = {},
    use_texture_alpha = true,
    makes_footstep_sound = true,
    stepheight = 1,
    show_on_minimap = true,
  },
  _sitting = false,
  _form = HUMAN_FORM,
  _passenger = nil,
}
function dragonmaiden:on_right_click(clicker) 
  if clicker.is_player() then
    if clicker:get_player_control()["sneak"] then
    self:transform()
  elseif self._form == BEAST_FORM then
    self:ride(clicker)
  end
end
end

function dragonmaiden:on_step()
  local passenger = self._passenger
  if passenger then
    controls =  passenger:get_player_control()
    if controls["sneak"] then
      self:set_detach()
      return
    end

  end
end

function dragonmaiden:get_static_data()
end


function dragonmaiden:transform()
  if self._form == HUMAN_FORM then
    self:transform_into_beast()
  elseif 
    self:transform_into_human()
  end
end

function dragonmaiden:transform_into_beast()
end
function dragonmaiden:transform_into_human()
end

function dragonmaiden:ride(passenger)
  self:set_attach(passenger)
  self._passenger = passenger
  passenger:set_physics_override({speed = 1.2, jump = 2, gravity = 0.6, acceleration_air = 1.2, sneak: false,})
end

function dragonmaiden:on_detach(passenger)
  passenger:set_physics_override({speed = 1, jump = 1, gravity = 1, acceleration_air = 1, sneak = true})
  self._passenger = nil
end

return dragonmaiden
