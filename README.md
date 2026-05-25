# godot-4-useful-scripts
some useful, reusable godot 4 scripts i frequently refer to

Under the MIT License. Aimed for **Godot 4.1**.

## Descriptions
### Attacks
This contains some useful scripts I used to modularize (is that a word?) attack data for various action based games. 

`AttackData.gd` stores a copy of `DamageData.gd` and frame data information. `DamageData.gd` stores a damage (range), knockback, screenshake, and hitfreeze amounts. This is often used with the `Events.gd` singleton/design pattern also included in this repository.

`Hitbox.gd` (and Hitbox.tscn) is used to make a reusable scene that most things in your game can implement and have the same functionality. In the future I may update it with some other goodies.

### InventorySystem
A module of scripts and scenes for setting up a basic inventory system. The current system is for supporting multiplayer with RPC, but it could be significantly simplified for singleplayer.

`InventoryEventBus.gd` must be added as an autoload under that name, allowing the inventory to react and respond to various inventory actions.

`InventorySlot.gd` is used to have items within them and react as expected to move items around slots.

### State Machine
An expansion of [GDQuest's State Machine article](https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/). Relatively well commented but likely needs a small amount of adjusting per project.

### CameraJuice2D
A Camera2D extension that adds an easy method of doing screenshake. This should be used with the `Events.gd` singleton to make it seamless to activate across scripts.

### Events
A basic foundation for an [Events singleton](https://www.gdquest.com/tutorial/godot/design-patterns/event-bus-singleton/) that has built-in methods/signals for screenshake and hitfreeze, for use with `CameraWithShake.gd` but can easily be extended.

### Movement2D
A custom Node that stores movement information for 2D games, such as speed, jump height, gravity, friction, acceleration, etc. Expected for use with platformers.


## Credits
The `state_machine` folder of scripts is initially based off of [GDQuest's State Machine article](https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/), then expanded to include a version for both the Player and Enemies. Should be easy to adjust.

The `CameraJuice2D.gd` is based off of this [YouTube tutorial](https://youtu.be/RVtcnkuNUIk?si=wqZkNfKp7YX4zTCt) by TheShaggyDev.
