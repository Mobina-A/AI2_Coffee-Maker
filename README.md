# AI2_Coffee-Maker

AR-1 is a domestic assistant robot designed to make coffee using an Italian moka machine. The process includes preparing ingredients, grinding coffee beans, filling the water reservoir, inserting the filter and coffee, assembling the moka pot and heating it, and finally serving the coffee. AR-1 is capable of manipulating various kitchen objects and appliances to perform these tasks. The goal is to model this coffee-making scenario in a PDDL domain and generate at least one valid plan utilizing all of AR-1's capabilities.

### Running
----------------------

To run the program follow the next steps:

1) Downloads espresso.pddl (Domain) and espresso_problem.pddl (Problem) files.
2) Use the online version of pddl

```bash
(https://editor.planning.domains/)
```
3) Load both files in the site
```bash
Tab Files >> loads >> choose file >> click on load button
```
4) Run it by solver "BFWS -- FF-parser version"
```bash
Tab Solver >> choose Domain,Problem, and Solver >> click on Plan button
```
<p align="center">
    <img src="Images/solver.png?raw=true" alt="Fig.1: solver" width="300" style="display:inline-block; margin: 0 10px;" />
    <br />
    <strong>Fig.1:</strong> Compute Plan
</p>

### Modify the files
---------------------------------

This code is useful for both ground coffee "not_beans" and coffee beans "beans". The type of coffee can be changed in the ":init" section in the problem file. The uploaded code is initialized for coffee beans, but if the coffee is ground one, the type of coffee should be changed to "not_beans".
```bash
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
  )
```
```bash
(object_type coffee beans)   >>>   (object_type coffee not_beans)
```

As two of the ingredients are optional,milk & sugar, this can be achieved by changing the action of all_together. The only required modification is adding a ";" before the unused ingredients.

```bash
(:action all_together
    :parameters ()
    :precondition (and
      (at coffee_container target_location)
      (at water_glass target_location)
      ;(at milk_container target_location)
      ;(at sugar_container target_location)
    )
```
    :effect (all_together)
  )
