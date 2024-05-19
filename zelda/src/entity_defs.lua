--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.155,
                looping = true,
                texture = 'character-walk'
            },
            ['walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                looping = true,
                texture = 'character-walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                looping = true,
                texture = 'character-walk'
            },
            ['walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                looping = true,
                texture = 'character-walk'
            },
            ['idle-left'] = {
                frames = {13},
                looping = true,
                texture = 'character-walk'
            },
            ['idle-right'] = {
                frames = {5},
                looping = true,
                texture = 'character-walk'
            },
            ['idle-down'] = {
                frames = {1},
                looping = true,
                texture = 'character-walk'
            },
            ['idle-up'] = {
                frames = {9},
                looping = true,
                texture = 'character-walk'
            },
            ['sword-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-right'] = {
                frames = {9, 10, 11, 12},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['sword-up'] = {
                frames = {5, 6, 7, 8},
                interval = 0.05,
                looping = false,
                texture = 'character-swing-sword'
            },
            ['lift-left'] = {
                frames = {10, 11, 12},
                interval = 0.15,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['lift-right'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['lift-up'] = {
                frames = {7, 8, 9},
                interval = 0.15,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['lift-down'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                looping = false,
                texture = 'character-pot-lift'
            },
            ['hold-idle-left'] = {
                frames = {12},
                texture = 'character-pot-lift'
            },
            ['hold-idle-right'] = {
                frames = {6},
                texture = 'character-pot-lift'
            },
            ['hold-idle-up'] = {
                frames = {9},
                texture = 'character-pot-lift'
            },
            ['hold-idle-down'] = {
                frames = {3},
                texture = 'character-pot-lift'
            },
            ['hold-walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.15,
                looping = true,
                texture = 'character-pot-hold-walk'
            },
            ['hold-walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.15,
                looping = true,
                texture = 'character-pot-hold-walk'
            },
            ['hold-walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.15,
                looping = true,
                texture = 'character-pot-hold-walk'
            },
            ['hold-walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                looping = true,
                texture = 'character-pot-hold-walk'
            }
        }
    },
    ['skeleton'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {22, 23, 24, 23},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {34, 35, 36, 35},
                looping = true,
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {10, 11, 12, 11},
                looping = true,
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {46, 47, 48, 47},
                looping = true,
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {23},
                looping = true
            },
            ['idle-right'] = {
                frames = {35},
                looping = true
            },
            ['idle-down'] = {
                frames = {11},
                looping = true
            },
            ['idle-up'] = {
                frames = {47},
                looping = true
            }
        }
    },
    ['slime'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {61, 62, 63, 62},
                looping = true,
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {73, 74, 75, 74},
                looping = true,
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {49, 50, 51, 50},
                looping = true,
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {86, 86, 87, 86},
                looping = true,
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {62},
                looping = true
            },
            ['idle-right'] = {
                frames = {74},
                looping = true
            },
            ['idle-down'] = {
                frames = {50},
                looping = true
            },
            ['idle-up'] = {
                frames = {86},
                looping = true
            }
        }
    },
    ['bat'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {64, 65, 66, 65},
                looping = true,
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {76, 77, 78, 77},
                looping = true,
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {52, 53, 54, 53},
                looping = true,
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {88, 89, 90, 89},
                looping = true,
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {64, 65, 66, 65},
                looping = true,
                interval = 0.2
            },
            ['idle-right'] = {
                frames = {76, 77, 78, 77},
                looping = true,
                interval = 0.2
            },
            ['idle-down'] = {
                frames = {52, 53, 54, 53},
                looping = true,
                interval = 0.2
            },
            ['idle-up'] = {
                frames = {88, 89, 90, 89},
                looping = true,
                interval = 0.2
            }
        }
    },
    ['ghost'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {67, 68, 69, 68},
                looping = true,
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {79, 80, 81, 80},
                looping = true,
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {55, 56, 57, 56},
                looping = true,
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {91, 92, 93, 92},
                looping = true,
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {68},
                looping = true
            },
            ['idle-right'] = {
                frames = {80},
                looping = true
            },
            ['idle-down'] = {
                frames = {56},
                looping = true
            },
            ['idle-up'] = {
                frames = {92},
                looping = true
            }
        }
    },
    ['spider'] = {
        texture = 'entities',
        animations = {
            ['walk-left'] = {
                frames = {70, 71, 72, 71},
                looping = true,
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {82, 83, 84, 83},
                looping = true,
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {58, 59, 60, 59},
                looping = true,
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {94, 95, 96, 95},
                looping = true,
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {71},
                looping = true
            },
            ['idle-right'] = {
                frames = {83},
                looping = true
            },
            ['idle-down'] = {
                frames = {59},
                looping = true
            },
            ['idle-up'] = {
                frames = {95},
                looping = true
            }
        }
    }
}