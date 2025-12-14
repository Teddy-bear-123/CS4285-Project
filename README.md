## Instructions:

Clone this repo

```bash

git clone https://github.com/Teddy-bear-123/CS4285-Project.git
git checkout new
```

open this directory with godot

You can run the game inside godot itself by playing the `Game` Scene or you can export to a native binary

### Exporting to a native binary

1. Select the Project/export in top bar
2. Install an Export template if you have not done it already (it should automaticaly download it for you)
3. Click Export Project



## Edting the project

Here is some Infromation you might need to edit this project

1. Main Scene is called Game, Everything is build "under" this
2. The Charecter has a "Abstract class" which gets implimented as enimies, and players to extend this you just need to imliment it.
3. Similarly Rooms are procdrualy generated as a maze, where we have a set number of pre built rooms (in `Rooms/`)
4. Wepons also has an "Abstract class" to be imlimented
