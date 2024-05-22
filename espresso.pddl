(define (domain espresso)
  (:requirements :strips :typing)
  
  (:types
    location object container part number degree time tool cups o_type
  )
  
  (:predicates

    (at_container ?obj - object ?con - container)
    (at ?con - container ?loc - location)
    (agent_at ?loc - location)
    (carrying ?con - container)
    (add_to ?obj - object ?p - part )
    (open_container ?con - container)
    (open_part ?p - part)
    (level_off ?obj - object ?tool - tool)
    (cup_at ?c - cups ?loc - location)
    (coffee_at_cups ?obj - object ?c - cups)
    (all_together)
    (object_type ?obj - object ?t - o_type)
    (extract_with ?obj - object ?tool - tool)
    
    (turns_completed ?turns - number)
    (set_degree ?d - degree)
    (for_seconds ?time - time)
    (extracting)
    (closed)
    
    (all_parts_opened)
    
    (moka_closed)
    (moka_not_closed)
    
    (part_opened)
    (leveling)
    (container_closed)
    
    (water_in_machine)
    
    (filter_in_machine)
    (filter_not_in_machine)
    
    (all_in_machine)
    (all_not_in_machine)
    (at_grinder)
    (on_stove)
    (set_heat)
    
    (be_ready)

  )
  
  (:action move
    :parameters (?from - location ?to - location)
    :precondition (and (agent_at ?from)(closed))
    :effect (and (not (agent_at ?from)) (agent_at ?to))
  )

  (:action open
    :parameters (?loc - location ?con - container )
    :precondition (and (agent_at ?loc) (at ?con ?loc) (closed))
    :effect (not(closed))
  )

  (:action pick_up
    :parameters (?con - container ?loc - location)
    :precondition (and (agent_at ?loc) (at ?con ?loc) (not(carrying ?con))(not(closed)))
    :effect (carrying ?con)
  )
  
  (:action close
    :parameters (?loc - location ?con - container )
    :precondition (and (agent_at ?loc) (at ?con ?loc) (carrying ?con) (not(closed)))
    :effect (closed)
  )

  (:action put_down
    :parameters (?con - container ?loc - location)
    :precondition (and (agent_at ?loc)(not (at ?con ?loc))(carrying ?con)(closed))
    :effect (and (at ?con ?loc) (not (carrying ?con)))
  )
  
  (:action all_together
    :parameters ()
    :precondition (and
      (at coffee_container target_location)
      (at water_glass target_location)
      (at milk_container target_location)
      (at sugar_container target_location)
    )
    :effect (all_together)
  )
  
  (:action screw_moka_pod
    :parameters (?turns - number)
    :precondition (and (all_together) (moka_closed))
    :effect (and (moka_not_closed) (not (moka_closed)) (turns_completed ?turns))
  )
  
  (:action open_container
    :parameters (?con - container)
    :precondition (and (not(open_container ?con)) (moka_not_closed)(not(part_opened)))
    :effect (and (open_container ?con)(not(container_closed)))
  )
  
  
  (:action open_part
    :parameters (?p - part)
    :precondition (and(moka_not_closed) (not(container_closed)) (not(open_part ?p)))
    :effect (and (open_part ?p)(part_opened))
  )
  
  (:action pour_from_to
      :parameters (?coffee - object ?from - container ?to - container)
      :precondition (and (at_container ?coffee ?from)(moka_not_closed)(not(part_opened))(not(container_closed))(object_type ?coffee beans ))
      :effect (and
          (object_type ?coffee beans)
          (at_container ?coffee ?to) (at_grinder)
      )
  )
  
  (:action grind
      :parameters (?coffee - object)
      :precondition (and (moka_not_closed)(not(part_opened))(not(container_closed))(object_type ?coffee beans )(at_grinder))
      :effect (and (object_type ?coffee not_beans)(not(object_type ?coffee beans))(not(extracting)))
  )
  
  (:action extract
      :parameters (?coffee - object ?tool - tool)
      :precondition (and (moka_not_closed)(add_to filter bottom_chamber)(add_to water bottom_reservoir)(all_parts_opened)(not(container_closed))(object_type ?coffee not_beans)(at_grinder))
      :effect (and (extract_with ?coffee ?tool)
          (not (at_grinder))
      )
  )
  
   (:action all_parts_opened
    :parameters ()
    :precondition (and
      (object_type coffee not_beans)
      (open_part  bottom_chamber)
      (open_part bottom_reservoir)
    )
    :effect (all_parts_opened)
  )
  
  (:action put_in_machine
      :parameters (?obj - object ?p - part)
      :precondition (and (all_parts_opened)(moka_not_closed)(not(container_closed)))
      :effect (add_to ?obj ?p)
  )
  
  (:action all_in_machine
    :parameters ()
    :precondition (and
      (add_to water bottom_reservoir)
      (add_to filter bottom_chamber)
      (extract_with coffee spoon)
      (add_to coffee filter)
    )
    :effect (all_in_machine)
  )
  
  (:action close_containers
    :parameters ()
    :precondition (and (moka_not_closed)(leveling)(not(container_closed)))
    :effect (container_closed)
  )
  
  (:action leveling
      :parameters (?obj - object ?tool - tool)
      :precondition (and(all_in_machine))
      :effect (level_off ?obj ?tool)
  )
  
  (:action level_off
      :parameters ()
      :precondition (level_off coffee spoon)
      :effect (leveling)
  )
  
  (:action close_part
      :parameters (?p - part)
      :precondition (and (open_part ?p)(container_closed)(moka_not_closed)(part_opened))
      :effect (not(open_part ?p))
  )
  
  (:action all_parts_closed
      :parameters ()
      :precondition (and 
      (not(open_part bottom_reservoir))
      (not(open_part bottom_chamber))
    )
      :effect (not (part_opened))
  )
  
  (:action unscrew_moka_pod
      :parameters (?turns - number)
      :precondition (and (moka_not_closed) (not(part_opened)))
      :effect (and (moka_closed)(not(moka_not_closed))(turns_completed ?turns))
  )
  
  (:action put_on_stove
      :parameters ()
      :precondition (and (all_in_machine)(moka_closed)(not(on_stove)))
      :effect (and(on_stove)
      )
  )
  
  (:action set_heat
      :parameters (?d - degree)
      :precondition (and (on_stove)(not(set_heat)))
      :effect (and
          (set_degree ?d)
          (set_heat)
      )
  )
  
  (:action wait
      :parameters (?time - time)
      :precondition (and (set_heat)(not(be_ready)))
      :effect (and (for_seconds ?time)
          (be_ready)
      )
  )
  
  
  (:action pour_to
      :parameters (?obj - object ?c - cups)
      :precondition (and(be_ready)(moka_not_closed))
      :effect (coffee_at_cups ?obj ?c)
  )
  
    

)