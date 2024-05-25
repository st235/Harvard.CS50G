APP_TITLE = 'Type Racer'

VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

MAXIMUM_ERROR_ACCUMULATION_LENGTH = 6

-- ground tiles
GROUND_TILE_SIZE = 16

GROUND_GRASS_TILES = { 1, 2, 3 }
GROUND_PAVEMENT_TILES = { 4 }

GROUND_TILE_FLOWER = 5

GROUND_TILE_ROAD = 6

GROUND_GRASS_HEIGHT = 5
GROUND_PAVEMENT_HEIGHT = 2

-- building
BUILDING_SIZES = {
    { width = 48, height = 88 },
    { width = 56, height = 88 },
    { width = 72, height = 104 },
    { width = 64, height = 115 },
    { width = 56, height = 104 },
    { width = 64, height = 128 },
    { width = 73, height = 128 },
}

-- race parameters
PLACE_NOT_QUALIFIED = -1
TIME_NO_TIME = -1

PLACES_NAMES = {
    [0] = 'N/A',
    [1] = '1st',
    [2] = '2nd',
    [3] = '3rd',
    [4] = '4th',
}

-- gui constants
VIEWS_SPACING = 10

INPUT_WIDTH = 220
INPUT_HEIGH = 80

LEADERBOARD_WIDTH = 110
LEADERBOARD_HEIGHT = 80

-- game over state
LEVEL_LOST_REASON_KILLED = 0
LEVEL_LOST_REASON_TYPOS = 1

GAME_OVER_OPPONENTS_KILLED_MESSAGES = {
    'Unfortunately, they were faster',
}

GAME_OVER_TOO_MANY_TYPOS = {
    'Too many typos',
}

-- credits

CREDITS = "\n" ..
"Thank you\n" ..
"for playing\n" ..
"Type Racer\n" ..
"\n" ..
"\n" ..
"Director:\n" ..
"Alex Dadukin\n" ..
"\n" ..
"\n" ..
"Lead Graphics Engineer:\n" ..
"Alex Dadukin\n" ..
"\n" ..
"\n" ..
"Lead AI Engineer:\n" ..
"Alex Dadukin\n" ..
"\n" ..
"\n" ..
"Senior Level Designer:\n" ..
"Alex Dadukin\n" ..
"\n" ..
"\n" ..
"Lead Counselor:\n" ..
"Tatiana Dadukina\n" ..
"\n" ..
"\n" ..
"Senior QA Engineer:\n" ..
"Marina Dadukina\n" ..
"\n" ..
"\n" ..
"Assets\n" ..
"\n" ..
"Sprites:\n" ..
"GB Studio Vehicle Asset Pack\n" ..
"\n" ..
"GameBoy-styled essential outdoor tiles by chuckiecatt\n" ..
"\n" ..
"GB Studio Buildings\n" ..
"\n" ..
"Trophies pack\n" ..
"\n" ..
"Fonts:\n" ..
"Kitchen Sink\n" ..
"\n" ..
"\n" ..
"\n" ..
"Lorem ipsum dolor sit amet, consectetur adipiscing elit...\n" ..
"\n" ..
"\n" ..
"\n" ..
"May 2024"
