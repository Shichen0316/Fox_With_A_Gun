# Cherry Ice Cream Project - 2D Shooter Game

## Introduction

Welcome to Cherry Ice Cream, a 2D shooter game where you play as a Succubus defending a base from waves of enemies. This game focuses on engaging mechanics, responsive controls, and an exciting survival logic using Godot Engine.


## Installation

To set up Cherry Ice Cream on your local machine, follow these steps:

1. Clone the repository: `git clone https://github.com/EnikoAgotai/cherry-cream`
2. Navigate to the project directory: `cd cherryicecream`

### Installation from zip (Lars)
1. Download zip
2. Unzip file
3. Open the unpacked cherryicecream directory in Godot Engine


## Git usage

Updating your local repository (in Webstorm):
1. Open 'Git' window (bottom left)
2. Click fetch all remotes (dashed arrow)
3. Ctrl click desired branch
4. Click update

Pushing to remote:
1. Open 'Commit' window (top left)
2. Also open 'Git window' (bottom left)
3. Click fetch all remotes - just making sure you local repo is up-to-date
4. Ctrl click branch you want to commit on and click update
5. In 'Commit' window check files you want to commit or click all changes
6. Write commmit message
7. Click 'Commit and push'


## Project structure
```text
cherryicecream/
├── .godot/                        
│   └── ...Godot-specific configuration files
├── Asset/
│   ├── Character/ 
│   │   └── ...character asset files
│   ├── Map/                       
│   │   └── ...map asset files
│   ├── Weapons/                   
│   │   └── ...weapon asset files
├── assets/
│   ├── audio/                     
│   │   └── .mp3 files for sound effects and music
│   ├── characters/
│   ├── map/                       
│   │   └── .jpg and .png file map assets and tiles
│   ├── UI/                        
│   │   └── .jpg and .png files for user interface elements (e.g., buttons)
│   ├── weapons/                   
│   │   └── .jpg and .png files for weapons
├── characters/                    
│   └── ... .gd and .tscn files for enemies and player
├── languages/ 
│   └── ... .gd and .tscn files for translation management 
├── level/                         
│   └── ... .gd and .tscn files for game levels, scores and logic
├── views/                         
│   └── ... .gd and .tscn files for menus, status pages and UI elements
├── weapons/                       
│   └── ... .gd and .tscn files for different weapons and their bullets, components
├── .gitignore
├── project.godot                  
├── README.md
```

## Team efforts:
This project, Cherry Ice Cream, was a collaborative effort by three dedicated team members: Enikő Ágotai, Olle Nordlander, and Shichen Zhang. We all equally contributed to the planning process and the overall implementation of the game. Each of us brought unique skills and perspectives to the project, resulting in a well-rounded and polished final product.
### Individual contributions
While the project was a team effort, certain features and aspects were specifically developed by individual team members:

* Enikő Ágotai: 
  * set up the GitHub repository and the project basics
  * implemented the random weapon spawning system
  * created the player area, tilemap design and collision elements
	* for this, contributed to polishing the existing visual design elements
  * developed the language management system, including the language manager and dictionary
  * contributed to developing the scoring system
* Olle Nordlander:
  * created the user interface elements, including the main menu, options menu, and in-game UI components
  * handled the sound design, integrating sound effects and background music
  * implemented game controller scripts, ensuring smooth transitions between different game states
* Shichen Zhang: 
  * created the game's visual design and animated elements like characters, guns, bushes
  * developed the core gameplay mechanics, including player movement, shooting mechanics, and enemy behaviors
  * implemented the interactive game tutorial solution


## Instructions to run application
1. Install (see above)
2. Open project in Godot Engine
3. Navigate to FileSystems in the bottom left and open res://views/menu.tscn or any other files
4. Run project by clicking the play icon in the top right corner


## Gameplay mechanics:
* Movement: smooth and responsive controls for moving left, right, up, and down.
* Shooting/attacking: basic shooting mechanics with different weapons and unique behaviors.
* Weapon spawning: weapons spawn and respawn randomly to add an element of surprise.
* Health: visual indicators of the base’s and player's status (life bar). The base’s or player's destruction leads to player defeat.
* Enemies: various types of animals with different speeds, health points, and abilities.


## Game features:
* Autonomous animation: independent animations to enhance game atmosphere.
* Media integration: sound effects and background music.
* Interactive tutorial: a guided, interactive help system to explain game mechanics.
* Localised: multilingual textual elements.


## Development process
* Define data structures and game logic using GDScript.
* Create scenes for game elements in Godot.
* Write controller scripts for user inputs and game state management.
* Implement visual and audio representations.
* Develop and integrate interactive and autonomous animations.
* Conduct thorough testing and documentation.


## MVC Architecture
Cherry Ice Cream is designed using the Model-View-Controller (MVC) architecture.

### Model
In Cherry Ice Cream, the model manages the game's state and rules, such as player health, scores, and weapon properties. It's implemented through various GDScript files that define the behavior and attributes of game entities.

#### Examples:

* `character_body_2d`: manages player attributes such as health and movement speed.
* `enemy_bear.gd`: defines enemy behaviors, including movement patterns, attack strategies, and health.
* separate `.gd` files for each weapon (like laser_gun.gd): handles weapon attributes like damage, fire rate, and ammunition.

### View
In other words, the scenes. It includes all the graphical elements that the player interacts with, such as the user interface, character sprites, and animations. 

#### Examples:
* `menu.tscn` and `menu.gd`: define the main menu layout and logic.
* `game_level.tscn`: contains the design of the game level, including the background, obstacles, and item placements.
* UI elements: scripts and scenes for the menus, score display, health bar, and other user interface components.

### Controller
In Cherry Ice Cream, the role of the Controller is integrated within the scripts themselves.

#### Examples:
* `game_level.gd`: manages the overall game flow, including spawning weapons and enemies.


## UI/UX design
The UI/UX design focuses on:
* Thematically relevant design specification
* Unified and harmonious fresh color scheme
* Clear user guidance logic
* Convenient and fast operation
* The final design of Cherry Ice Cream includes the old school pixel art style with a clear and engaging UI. Here are some highlights of the design process and final game elements:

### Main menu
The main menu is designed with a colorful and inviting background. The options include Play, Tutorial, Options, and Quit, providing a straightforward navigation experience for the player.
### Gameplay
The gameplay screen features a top-down view of the player character defending the base. The design focuses on clarity and simplicity, ensuring that the player can easily navigate and interact with the environment. Weapons spawn randomly across the map, adding an element of strategy and surprise.
### Game Over screen
The game over screen provides options to Play Again or return to the Main Menu. The design maintains consistency with the overall aesthetic of the game, ensuring a seamless experience for the player.


## Visual and audio design
The game features vibrant pixel art graphics and engaging sound effects that enhance the gameplay experience. The background music and sound effects are carefully chosen to match the game's theme and pace.


## Development process and game basics: 
https://docs.google.com/document/d/13ZI9VcHtYlXYPb8hinkr9uqLD2RADXODWDIrWlDzbvc/edit?usp=sharing


## Usage of chatbots:
Language dictionaries:
* The language dictionaries for Hungarian were generated using ChatGPT3.5 from the English dictionary
* Edits/corrections to those dictionaries were made by us.


## Documentation:
* GitHub Copilot was used to assist in generating documentation for the project.
* Just open  2 taps and let the copilot do the work.
