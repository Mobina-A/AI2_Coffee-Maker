(define (problem espresso_problem)
  (:domain espresso)
  
  (:objects
    coffee water milk sugar filter ready_coffee - object
    closet1 water_tap closet3 closet4 target_location start_location - location
    coffee_container water_glass milk_container  sugar_container grinder - container
    bottom_reservoir bottom_chamber filter - part
    spoon - tool
    cup_red cup_blue - cups
    beans not_beans - o_type
    three_times - number
    medium - degree
    five_seconds - time
  )
  
  (:init
    (at coffee_container closet1)
    (at water_glass water_tap)
    (at milk_container closet3)
    (at sugar_container closet4)
    (agent_at start_location)
    
    (at_container coffee coffee_container)
    (at_container water water_glass)
    (at_container sugar sugar_container)
    (at_container milk milk_container)
    
    (object_type coffee beans)
    (object_type milk not_beans)
    (object_type water not_beans)
    (object_type sugar not_beans)

    
    (closed)
    (moka_closed)
    (container_closed)
    (all_not_in_machine)

  )
  
  (:goal
    (and (all_together)
    (level_off coffee spoon)
    (open_container coffee_container)
    (all_in_machine)
    (coffee_at_cups ready_coffee cup_red)
    (coffee_at_cups ready_coffee cup_blue)
    )
  )
)
