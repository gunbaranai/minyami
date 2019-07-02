#==============================================================================
# Spike's Yanfly Engine Ace Addon - Class System Character Level Tweak
# (CC) 2019 Spike | Discord: You#2305
# Required Script(s):
# - YEA Class System (v1.10)
#==============================================================================

class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # New method: Character Level
  #--------------------------------------------------------------------------
  def character_level
    return @level unless $imported["YEA-ClassSystem"]
    @character_level = 1
    @classes = []
    @classes = self.unlocked_classes.clone
    @classes != YEA::CLASS_SYSTEM::DEFAULT_UNLOCKS
    for class_id in @classes
      @character_level += self.class_level(class_id)-1
    end
    return @character_level
  end
  # Character Level
end

class Window_Base < Window
  #--------------------------------------------------------------------------
  # Overwrite method: Draw Level
  #--------------------------------------------------------------------------
  def draw_actor_level(actor, x, y)
    change_color(system_color)
    draw_text(x, y, 32, line_height, Vocab::level_a)
    change_color(normal_color)
    draw_text(x + 32, y, 24, line_height, actor.character_level, 2)
  end
  # Draw Level
end