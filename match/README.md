# Match

### Task

- Implement time addition on matches, such that scoring a match extends the timer by 1 second per tile in a match. This one will probably be the easiest! Currently, there’s code that calculates the amount of points you’ll want to award the player when it calculates any matches in PlayState:calculateMatches, so start there!
- Ensure Level 1 starts just with simple flat blocks (the first of each color in the sprite sheet), with only later levels generating the blocks with patterns on them (like the triangle, cross, etc.). These should be worth more points, at your discretion. This one will be a little trickier than the last step (but only slightly); right now, random colors and varieties are chosen in Board:initializeTiles, but perhaps we could pass in the level variable from the PlayState when a Board is created (specifically in PlayState:enter), and then let that influence what variety is chosen?
- Create random shiny versions of blocks that will destroy an entire row on match, granting points for each block in the row. This one will require a little more work! We’ll need to modify the Tile class most likely to hold some kind of flag to let us know whether it’s shiny and then test for its presence in Board:calculateMatches! Shiny blocks, note, should not be their own unique entity, but should be “special” versions of the colors already in the game that override the basic rules of what happens when you match three of that color.
- Only allow swapping when it results in a match. If there are no matches available to perform, reset the board. There are multiple ways to try and tackle this problem; choose whatever way you think is best! The simplest is probably just to try and test for Board:calculateMatches after a swap and just revert back if there is no match! The harder part is ensuring that potential matches exist; for this, the simplest way is most likely to pretend swap everything left, right, up, and down, using essentially the same reverting code as just above! However, be mindful that the current implementation uses all of the blocks in the sprite sheet, which mathematically makes it highly unlikely we’ll get a board with any viable matches in the first place; in order to fix this, be sure to instead only choose a subset of tile colors to spawn in the Board (8 seems like a good number, though tweak to taste!) before implementing this algorithm!
- (Optional) Implement matching using the mouse. (Hint: you’ll need push:toGame(x,y); see the push library’s documentation here for details! This one’s fairly self-explanatory; feel free to implement click-based, drag-based, or both for your application! This one’s only if you’re feeling up for a bonus challenge :) Have fun!

### Implementation details

1. Timer implementation can be found in [PlayState.lua, line 212](./src/states/PlayState.lua#L212)
2. Patterns generation:
    - I am limiting variety of tiles "complexity" by taking logarithm of the current level
    - When board is initialised [`self.maxTilesVariety` is calculated](./src/Board.lua#L25), which then limits the variety of tiles
3. Shiny tiles
    - Random shiny blocks destroy `rows` only (**as explicitly specified in the task description**)
    - Tiles hold special [`isShiny` flag](./src/Tile.lua#L39)
    - Shiny animation is done with [tweening](./src/Tile.lua#L43)
    - Algorithm is designed in a way to take into account account tiles that already participate in a match and do not extra score them. A shiny match consists only of tiles that are not part of regular match and belong to the same row where the shiny tile is.
    - If there are multiple shiny blocks within the same horizontal match, all tiles in this row are put into shiny match group exactly once
    - The board logic can be found [here](./src/Board.lua#L179)
4. Swapping
    - It is impossible to swap blocks if it does not lead to a match. The check can be found in [`PlayState`](./src/states/PlayState.lua#L151) and in [`Board#canSwap`](./src/Board.lua#L331)
    - If there are no more possible swaps on the board, the new board is created. The logic can be found in [`PlayState#calculateMatches`](./src/states/PlayState.lua#L231) and in [`Board#checkMatchExists`](./src/Board.lua#L313)
5. Mouse
    - I modified [`main.lua` and added `love.mouse.wasPressed` API](./main.lua#L106) similar to what we had for `keyboard`
    - To convert game coordinates (after calling `push:toGame`) to grid coordinates I created [`Board:toGrid`](./src/Board.lua#L30)
    - The actual check can be found in [`PlayState.lua` near 'enter' press check](./src/states/PlayState.lua#L127)

### Misc

- [Shiny animation](https://bdragon1727.itch.io/super-package-retro-pixel-effects-32x32-pack-2). Free to use on non-commercial games. 