#==============================================================================
# Spike's Yanfly Engine Ace Addon - Categorize Skill by Class UI Tweak
# (CC) 2019 Spike | Discord: You#2305
# Required Script(s):
# - YEA Class System (v1.10)
# - YEA Learn Skill Engine (v1.00)
#==============================================================================

#==============================================================================
# ■ Window_LearnSkillCommand
#==============================================================================

class Window_LearnSkillCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # Overwrite method: make_command_list
  #--------------------------------------------------------------------------
  def make_command_list
    return if @actor.nil?
    return unless $imported["YEA-ClassSystem"]
    add_command(@actor.class.name, :skill, true, @actor.class.id) if !@actor.class.nil?
    add_command(@actor.subclass.name, :skill, true, @actor.subclass.id) if !@actor.subclass.nil?
    #end
  end
  
  #--------------------------------------------------------------------------
  # Overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    @skill_window.class_id = current_ext if @skill_window
  end
  
end # Window_LearnSkillCommand

#==============================================================================
# ■ Window_LearnSkillList
#==============================================================================

class Window_LearnSkillList < Window_SkillList
  
  #--------------------------------------------------------------------------
  # Alias method: Initialize
  #--------------------------------------------------------------------------
  alias init_skilllist initialize
  def initialize(x, y, width, height)
    @class_id = 0
    init_skilllist(x, y, width, height)
  end
  
  #--------------------------------------------------------------------------
  # New method: Set Skill Class ID
  #--------------------------------------------------------------------------
  def class_id=(class_id)
    return if @class_id == class_id
    @class_id = class_id
    refresh
    self.oy = 0
  end
  
  #--------------------------------------------------------------------------
  # Overwrite method: include?
  #--------------------------------------------------------------------------
  def include?(item)
    return false if item.nil?
    return false unless meet_requirements?(item)
    return $data_classes[@class_id].learn_skills.include?(item.id)
  end
  
end # Window_LearnSkillList