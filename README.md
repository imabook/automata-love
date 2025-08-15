# automata-love

## Simple cellular automata with multiple rulesets to choose

Third lua proyect, made to learn.

You can input the size of the grid with command line args, if not it'll default to a 30x30 grid (`love . 15 15`).
Click a tile in the board to make it alive, to start the simulation press the spacebar

Keybinds:

```s
space: Starts/Stops the simulation

r: Randomizes the board

n: Displays the number of neighbours of each cell (goes one step behind)

h: Toggles the heatmap view. The more neighbours a cell has, the redder it appears

up arrow/down arrow: Changes the velocity of the simulation by 0.5 (steps per second)
```
