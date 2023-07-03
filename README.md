# godot-4-useful-scripts
some useful, reusable godot 4 scripts i frequently refer to

Under the MIT License.

## Descriptions
### Attacks
This contains some useful scripts I used to modularize (is that a word?) attack data for various action based games. `AttackData.gd` stores a copy of `DamageData.gd` and frame data information. `DamageData.gd` stores a damage (range), knockback, screenshake, and hitfreeze amounts. This is often used with the `Events.gd` singleton/design pattern also included in this repository.

### State Machine
An expansion of [GDQuest's State Machine article](https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/), to include a version for the Player and for the Enemies. Relatively well commented but likely needs a small amount of adjusting per project.

### CameraWithShake
A Camera2D extension that adds an easy method of doing screenshake. This should be used with the `Events.gd` singleton to make it seamless to activate across scripts.

### Character
A CharacterBody2D extension that relies on the `Movement.gd` and `Stats.gd` to make a sort of modular baseline for entities to extend from. Somewhat of an attempt at an ECS in Godot 4? Very useful.

### Events
A basic foundation for an [Events singleton](https://www.gdquest.com/tutorial/godot/design-patterns/event-bus-singleton/) that has built-in methods/signals for screenshake and hitfreeze, for use with `CameraWithShake.gd` but can easily be extended.

### Movement
A custom Node that stores movement information, such as speed, jump height, gravity, friction, acceleration, etc. Can be expanded easily and is recommended to be used with `Character.gd`.

### Stats
A custom Node that stores statistical information specific for characters, such as health, knockback damping, etc. Can be expanded easily and is recommended to be used with `Character.gd`.
ex: I used this in a top-down arena shooter prototype to store and calculate damage upgrades and otherwise.


## Credits
The `state_machine` folder of scripts is initially based off of [GDQuest's State Machine article](https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/), then expanded to include a version for both the Player and Enemies. Should be easy to adjust.

The `CameraWithShake.gd` is based off of a YouTube tutorial I saw a long time ago and have since lost. :(
