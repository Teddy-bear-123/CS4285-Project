# Project Report: Development of a 2D Roguelike Game in Godot

## Executive Summary

This project documents the end-to-end development of a game using the Godot Engine, starting from experimental VR and AR concepts and culminating in a fully playable 2D action roguelike. Multiple pivots were required due to asset limitations, technical complexity, and time constraints. The final outcome is a polished, replayable 2D dungeon crawler featuring procedural generation, multiple weapons, enemies, multi-floor progression, UI feedback, and a boss fight. The project demonstrates iterative design, scope management, and practical game development using Godot.

## Evolution of the Project (Pivots)

### Phase 1: VR Game Concept

The project began as a VR-based game leveraging Godot’s VR support.

**Issues encountered:**

- Lack of high-quality, VR-ready assets.
    
- Requirement of specialized hardware and extensive testing.
    
- Development time exceeded available resources.

This phase was abandoned early to prevent project stagnation.

### Phase 2: AR 3D Garden Prototype

The next iteration was an AR garden simulation where users could place virtual flowers in real-world space.

**Issues encountered:**

- Gameplay was limited to object placement.
    
- No progression, challenge, or replay value.
    
- The experience felt more like a demo than a game.
    
This was the video followed - [Here](https://www.youtube.com/watch?v=FJAO6jDYljs&list=PLgMA_KSaYh5MyoBJOxto0wkBd3MVKJphO&index=10&t=5288s&pp=gAQBiAQB)

This led to another pivot toward a more systems-driven genre.

### Phase 3: 3D Roguelike Attempt

A 3D roguelike with procedurally generated dungeon levels was attempted.

**Issues encountered:** 

- Procedural room and map generation is complex.
    
- More data and assets couldn't be found.
    
### Final Direction: 2D Roguelike

The project finally transitioned to a **2D top-down roguelike**, allowing focus on gameplay mechanics, procedural systems, and polish while staying within technical limits.

# Godot Roguelike Tutorial: Step-by-Step Guide to Building the Game

This guide provides a complete, sequential set of instructions to recreate a fully featured 2D action roguelike game in Godot. By following these instructions in order, you will build a replayable dungeon crawler with procedural generation, combat, multiple weapons, multi-floor progression, items, a boss fight, and polished UI/feedback.

**Requirements:**
- Godot Engine
- A 16×16 pixel dungeon tile set/asset pack (free packs are widely available; search for "16x16 dungeon tile set") Link given below 
- Basic familiarity with Godot's editor, scenes, nodes, and GDScript

## Step 1: Project Setup
1. Create a new Godot project.
2. Configure basic project settings (window size, stretch mode, etc.).
3. Organize your workspace: create folders for Scenes, Scripts, Assets (Sprites, Tiles, Effects), and Autoloads.
4. Import your 16×16 dungeon asset pack.

## Step 2: Create Reusable Character Base and Player
1. Create a **Character** scene as the base for all entities:
   - Use a CharacterBody2D as the root.
   - Add child nodes: AnimatedSprite2D (or Sprite2D), CollisionShape2D.
   - Attach a script with shared variables (e.g., health, max_health, speed) and a basic state machine (states like IDLE, MOVE, ATTACK).
2. Create a **Player** scene that inherits from Character:
   - Add player-specific input handling (movement via arrow keys or WASD).
   - Set up a dedicated player state machine.
   - Ensure movement updates velocity and plays appropriate animations.

## Step 3: Add Melee Attack (Sword)
1. Add a **Sword** node as a child of the Player (Sprite2D + CollisionShape2D for the hitbox).
2. Script the sword to rotate and aim toward the mouse position. Flip the sprite when the mouse crosses sides.
3. Create an attack input action (left mouse click).
4. Implement a swing animation for the sword when attacking.
5. Add a simple slash visual effect (AnimatedSprite2D or Particles2D) that plays during the swing.

## Step 4: Add Movement and Hit Visual Effects
1. Create a **Dust Effect** scene (short-lived AnimatedSprite2D or GPUParticles2D).
2. Instance the dust effect when the player starts/stops moving or changes direction.
3. Create a **Hit/Impact Effect** scene.
4. Play the hit effect when an attack connects.

## Step 5: Implement Damage System and Player Hurtbox
1. Add a damage-handling function to the Character script (reduce health, emit signal).
2. Add a Hurtbox (Area2D + CollisionShape2D) to the Player with appropriate collision layers/masks.
3. Connect the hurtbox's area_entered signal to apply damage when overlapped by enemy attacks.

## Step 6: Enemy Attacks and Player Death
1. Create basic enemy scenes (inherit from Character).
2. Add attack logic so enemy hitboxes overlap the player's hurtbox and call the shared damage function (with cooldowns to avoid constant damage).
3. When player health reaches zero:
   - Switch to a DEATH state.
   - Disable input, play death animation.
   - Implement basic game-over behavior (show start state).

## Step 7: Add Player Health Bar UI
1. Create a **HealthBar** scene using ProgressBar or TextureProgressBar.
2. Position it on-screen (e.g., top-left).
3. Emit a signal from the Character script whenever health changes.
4. Connect the signal to update the health bar's value.

## Step 8: Create Combat Rooms
1. Build a reusable **Room** template scene with TileMap for walls/floors.
2. Create a **Door** scene that can toggle between open/closed states (animation or visibility).
3. Create a specific combat room inheriting the template:
   - Add enemy spawn markers (Node2D placeholders).
   - Add doors and an exit.
4. Add a room script:
   - On player entry, close doors and spawn enemies with a visual effect (puff/explosion).
   - Track enemy deaths.
   - Open exit door when all enemies are defeated.

## Step 9: Simple Procedural Dungeon Generation
1. Create multiple room variants (different layouts, all with origin at top-left corner).
2. Create a **DungeonGenerator** script:
   - Decide number of rooms per floor.
   - Randomly select and instance rooms sequentially.
   - Connect rooms with corridors (draw tiles or place corridor segments; randomize vertical position).
3. Add the generator to the main scene and ensure the camera follows the player.

## Step 10: Add Ranged Enemy and Projectiles
1. Create a **RangedEnemy** scene (inherits Character).
   - AI keeps distance from player.
   - Spawns **Projectile** scenes toward player.
2. Create a **Projectile** scene:
   - Moves in a straight line.
   - Uses Area2D to detect collision with player → apply damage → destroy self.
3. Update room spawns to include both melee and ranged enemies at random positions.

## Step 11: Bug Fixes and Polish
1. Improve enemy pathfinding (avoid getting stuck on walls/corners).
2. Fix collision and navigation issues.
3. Ensure enemies despawn correctly and room states transition smoothly.

## Step 12: Charge Attack and Blocking
1. Add charge mechanic: hold attack button → build charge (particles + animation).
2. Release after threshold → stronger attack with higher damage and bigger effect.
3. Enable blocking: during charge or specific animation frames, sword collides with projectiles and destroys/deflects them.

## Step 13: Generic Weapon System
1. Create a reusable **Weapon** scene/script with properties (damage, animations, etc.).
2. Move sword into this system.
3. Update Player to hold an array of weapons and use the current one's attack logic.
4. Add weapon switching (mouse wheel or number keys).
5. Create additional weapons (e.g., war hammer with different stats/animations).

## Step 14: Weapon Pickups and Dropping
1. Create **WeaponPickup** scenes (Area2D + sprite).
2. On player interact (e.g., E key):
   - Add weapon to player's inventory.
   - Equip it and remove pickup from world.
3. Add drop input:
   - Spawn a pickup instance of current weapon at player position.
   - Remove from player's inventory.

## Step 15: Multi-Floor Progression
1. Add a floor transition trigger (stairs Area2D).
2. Create an Autoload singleton (e.g., RunData) to store persistent data (health, weapons, etc.).
3. On transition:
   - Save current state.
   - Generate and load new floor.
   - Restore saved data to player.

## Step 16: Special Rooms and Health Potion
1. Enhance generator to rarely/occasionally include special rooms (e.g., one per floor).
2. Create **HealthPotion** pickup:
   - On interact, restore player health.
   - Ensure healing persists across floors via RunData.

## Step 17: Slime Boss Fight
1. Create a **BossRoom** (special room with boss spawn).
2. Create **SlimeBoss** scene (high health, unique attacks).
3. Implement phases: spawn minions or change patterns at health thresholds.
4. On boss death: trigger victory (open doors, show win state).

## Step 18: Active Ability and Minor Fixes
1. Add an active ability slot (separate key, cooldown).
2. Implement a powerful special ability (e.g., dash or area attack).
3. Fix any remaining bugs (e.g., asserts in Godot 3.x).

## Step 19: Inventory Bar UI
1. Create bottom-screen UI with HBoxContainer.
2. Add slots showing weapon icons.
3. Highlight equipped weapon.
4. Scroll to change weapon.

**Final Result:** You now have a complete action roguelike with procedural dungeons, varied combat, weapon management, multi-floor runs, items, a boss, and polished feedback. Test thoroughly, balance difficulty, and expand with your own ideas (e.g., more enemies, abilities, or rooms).

## Assets used 

1. **16x16 pixel art dungeon crawler pack** created by o_lobster [Download link](https://o-lobster.itch.io/simple-dungeon-crawler-16x16-pixel-pack)
2. [Weapon sfx](https://thesoundrack.itch.io/swords-blades-sound-pack)
3. [Character damage sfx](https://voicebosch.itch.io/taking-damage-sounds-male-grunts-audio-pack/download/eyJpZCI6MjY5MzEzOCwiZXhwaXJlcyI6MTc2NTczMzU1NX0%3d.NuowMleYbZVoUqTgn%2fCZXpX7lic%3d)
4. [Goblin](https://hsdsz.itch.io/goblin-warrior-1-pixelated-free-ver/download/eyJpZCI6MzU2NjE1NCwiZXhwaXJlcyI6MTc2NTcxNTU2MX0%3d.sng5qHTy86X4%2bYJsXIGCBc2xweo%3d)
5. [Slime](https://pixelmikazuki.itch.io/free-slime-enemy/download/eyJpZCI6MjY2MDY0MywiZXhwaXJlcyI6MTc2NTcxNjIxOX0%3d.0h6wfTxKfdmFAySlU3Un9OAXeXA%3d)
6. [Bats](https://segnah.itch.io/flyng-enemy-pixel-art?download)

Enjoy your finished game!

## Project by: Team 14
K. Pranav Suhas Reddy
Anirudh Ram
C.V. Rishi
Rahul Kumar Singh
Arushi Khethavath