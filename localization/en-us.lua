---@diagnostic disable: undefined-global

return {
    descriptions = {
        Enhanced = {
            m_fnaf_pizza = {
                name = "Pizza Card",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "no rank or suit",                    
                    "Expires after {C:attention}#2#{} Usages",
                },
            },
            m_fnaf_glitch = {
                name = "Glitch Card",
                text = {
                    "",
                }
            },
            m_fnaf_kid = {
                name = "Kid",
                text = {
                    "{X:chips,C:white} X#1# {} Chips",
                }
            }
        },

        fnaf_item = {
            c_fnaf_pizza_maker = {
                name = "Fredbear Pizza Maker",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2#",
                },
            },

            c_fnaf_grabber = {
                name = "Monty Grabber",
                text = {
                    "Draw {C:attention}#1#{} cards",
                    "{C:inactive}(Must have #1# or + on deck)",
                },
            },

            c_fnaf_deathcoin = {
                name = "Death Coin",
                text = {
                    "adds a {C:attention}#1#",
                },
            },

            c_fnaf_boost = {
                name = "Card Booster Pack",
                text = {
                    "Creates {C:attention}#1#{} cards"
                },
            },

            c_fnaf_grabbag = {
                name = "Grab Bag",
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:green}Item{} cards",
                    "{C:inactive}(Must have room)",
                },
            },

            c_fnaf_philately = {
                name = "Philately collection",
                text = {
                    "Adds a {C:attention}Random Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
        },

        Tarot = {
            c_fnaf_rabbit = {
                name = "invalid_tarot_object",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2#",
                },
            },            
            c_fnaf_kid = {
                name = "Six of Cups",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2#",
                },
            },
        },        
        
        Spectral = { 
            c_fnaf_secur_log = {
                name = "Security Logbook",
                text = {
                    "Add a {C:gold}Guard Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
            c_fnaf_bracelet = {
                name = "Bracelet",
                text = {
                    "Add a {C:uncommon}Security Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },
        },

        Joker = {
            j_fnaf_endo_01 = {
                name = "Endo-01",
                text = {
                    "{C:chips}+#1#{} Chips"
                },
            },
            j_fnaf_time_clock = {
                name = "Time Punch Clock",
                text = {
                    "{C:chips}+#1#{} Chips after scoring",
                    "a {C:attention}Straight{} with all cards",
                    "being numbered",
                },
            },
            j_fnaf_frog = {
                name = "Happy Frog",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "{C:attention}Blind{} skipped this run",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
                unlock = {
                    "Continue a saved run",
                    "from the main menu",
                },
            },
            j_fnaf_r_freddy = {
                name = "Rockstar Freddy",
                text = {
                    "Gives {C:chips}+#1#{} Chips for",
                    "each {C:attention}Gold Seal",
                    "in your {C:attention}full deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_fnaf_bb = {
                name = "Balloon Boy",
                text = {
                    "Don't",
                },
            },
            j_fnaf_balloon_boy = {
                name = "Balloon Boy",
                text = {
                    "{C:red}Utterly Annoying",
                    "{X:chips,C:white}X#1#{} Chips",
                    "{C:red}Eternal for (#2#/#3#) rounds.",
                },
            },
            j_fnaf_pizzabot = {
                name = "Pizza Bot",
                text = {
                    "Adds one {C:attention}Pizza{} card",
                    "to deck when",
                    "{C:attention}Blind{} is selected",
                },
            },
            j_fnaf_dee_dee = {
                name = "Dee Dee",
                text = {
                    "Spawns a random {C:attention}joker{}",
                    "at the start of a ante",
                    "{C:inactive}(No legendaries, must have room)",
                },
            },
            j_fnaf_glitchtrap = {
                name = "Glitchtrap",
                text = {
                    "All played {C:attention}ace{} cards",
                    "become {C:attention}Glitched{}",
                    "when scored",
                },
            },
            j_fnaf_eleanor = {
                name = "Eleanor",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if you have",
                    "at least {C:attention}#2#{} Enhanced",
                    "cards in your full deck",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive})",
                },
            },
            j_fnaf_vanessa = {
                name = "Vanessa",
                text = {
                    "{C:red,s:1.1}+#1#{} Mult for every card ", 
                    "trigger with {C:attention}Security Seal",
                },
            },
            j_fnaf_ennard = {
                name = "Ennard",
                text = {
                    "Gains {C:money}$#1#{} for", 
                    "every card destroyed",
                },
            },
            j_fnaf_glam_chica = {
                name = "Glamrock Chica",
                text = {
                    "Gains {X:mult,C:white} X#1# {} Mult per {C:attention}Pizza Card{} played", 
                    "{C:red,s:1.1}Destroy all those cards before scoring{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "{E:1,C:attention}#2#s{} in",
                    "your deck",
                },
            },
            j_fnaf_pickles = {
                name = "Pickles",
                text = {
                    "{C:green}Jar of Pickles",
                },
            },
            j_fnaf_s_puppet = {
                name = "Security Puppet",
                text = {
                    "Adds a {C:attention}Security seal",
                    "to {C:attention}kid{} cards",
                    "held in hand at the",
                    "{C:attention}end of the round",
                },
            }, 
            j_fnaf_helpy = {
                name = "Helpy",
                text = {
                    "Go up to {C:red}-$#1#{} in debt",
                    "the run {C:red,s:1.1}ends{} if you're in debt",
                    "after a boss blind",
                },
                unlock = {
                    "Have {E:1,C:red}-$#1#",
                },
            },
            j_fnaf_learning = {
                name = "Learning - Endo",
                text = {
                    "Has a chance to upgrade",
                    "{C:attention}played poker{} hand based on",
                    "{C:green}times used in #2#{}",
                },
            },
            j_fnaf_gator = {
                name = "Montgomery Gator",
                text = {
                    "Gains {X:mult,C:white} X#1# {} Mult for ",
                    "every card destroyed",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_fnaf_toy_bonnie = {
                name = "Toy Bonnie",
                text = {
                    "{C:attention}7s{} works similar to {C:attention}Wild Cards{}",
                },
            },
            j_fnaf_m_hippo = {
                name = "Mystic Hippo",
                text = {
                    "If the {C:attention}hand played{} is a",
                    "{C:attention}Base secret Poker Hand{}",
                    "creates a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
                unlock = {
					"Play a {C:attention}Secret Hand{}"
				},
            },
            j_fnaf_cassie = {
                name = "Cassie's Roxy-Talky",
                text = {
                    "Using a {C:green}item{} has a",
                    "{C:green}#1# in #2#{} chance",
                    "to create another one",
                },
                unlock = {
                    "Discover every",
                    "{E:1,C:green}Item{} card",
                },
            },
            j_fnaf_toy_chica = {
                name = "Toy Chica",
                text = {
                    "{C:chips}+#2#{} Chips",
                    " for every card destroyed",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_fnaf_missing = {
                name = "Missing Poster",
                text = {
                    "Playing a hand with {C:attention}#3#{} Face cards",
                    "have a {C:green}#1# in #2#{} chance to create ",
                    "a {C:attention}consumable{} card",
                    "{C:inactive}(Spectral cards not included)",
                },
            },
            j_fnaf_orville = {
                name = "Orville Elephant",
                text = {
                    "Switch the {C:attention}enhancement",
                    "of all {C:attention}scoring{} cards played",
                },
            },
            j_fnaf_jackie = {
                name = "Jackie",
                text = {
                    "Draw {C:attention}+#1#{} cards when",
                    "on your last hand",
                },
            },
            j_fnaf_logbook = {
                name = "Survival Logbook",
                text = {
                    "{C:attention}Face{} cards get a",
                    "{C:green}#Guard Seal#{} when scored",
                },
            },
            j_fnaf_c_baby = {
                name = "Circus Baby",
                text = {
                    '{C:chips}+#1#{} Chips',
                    "if your hand played has all {C:attention}Suits{}",
                    '{C:inactive}(Hearts / Diamonds / Spades / Clubs)'
                },
                unlock = {
                    "Play a 5 card hand",
                    "that contains only",
                    "{C:attention,E:1}Wild{} cards",
                },
            },

            j_fnaf_rock_chica = {
                name = "Rockstar Chica",
                text = {
                    "{C:attention}Pizza cards{}" ,
                    "have {C:green,E:1,S:1.1}#1#{} more {C:attention}usages"
                },
                unlock = {
                    "Have at least {E:1,C:attention}#1#",
                    "{E:1,C:attention}#2#s{} in",
                    "your deck",
                },
            },

            j_fnaf_toy_freddy = {
                name = "Toy Freddy",
                text = {
                    "All {C:attention}Face{} cards are",
                    "considered",
                    "{C:attention}Ace{} cards",
                },
            },


            -- Legendary

            j_fnaf_bonnie = {
                name = "Bonnie",
                text = {
                    "{X:green,C:white} x#1# {} all {C:green,E:1,S:1.1}listed{} {C:green,E:1,S:1.1}probabilities"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_fnaf_chica = {
                name = "Chica",
                text = {
                    "{C:attention}-#1#%{} All Blind Scores"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_fnaf_foxy = {
                name = "Foxy",
                text = {
                    "Retrigger all played cards"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_fnaf_freddy = {
                name = "Freddy Fazbear",
                text = {
                    "{X:mult,C:white} X#1# {} Mult per Marks of Completion",
                    "in fnaf games (Clickteam)",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },

            j_fnaf_golden = {
                name = "Golden Freddy",
                text = {
                    "Your {C:attention}UCN{} sore will be used as {C:red,s:1.1}Mult{}",
                    "{C:inactive}(Currently {C:red,s:1.1} #1# {C:inactive} Mult)",
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            }
        },

        Voucher = { 
            v_fnaf_collection = {
                name = "Collection",
                text = {
                    "{C:attention}+#1#{} Booster slot",
                },
            },
            v_fnaf_starter_deck = {
                name = "Starter Deck",
                text = {
                    "{C:tarot}Tarot{} cards may",
                    "appear in any of",
                    "the {C:attention}Item Packs",
                },
            }
        },

        Other = {
            k_fnaf_plus_item = {
                text = {
                    "+1 Item",
                },
            },
            fnaf_security_seal = {
                name = "Security Seal",
                text = {
                    "Immune to {C:green}debuffs",
                },
            },
            fnaf_guard_seal = {
                name = "Guard Seal",
                text = {
                    "Creates the {C:green}Item{} card",
                    "when {C:attention}discarded",
                    "{C:inactive}(Must have room)",
                },
            },
            p_fnaf_item_normal = {
                name = "Item Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Item cards{}",
                },
            },
            p_fnaf_item_jumbo = {
                name = "Jumbo Item Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Item cards{}",
                },
            },
            p_fnaf_item_mega = {
                name = "Mega Item Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:green} Item cards{}",
                },
            },
            fnaf_code_WIP = {
                name = "WIP: Code",
                text = {
                    "Code is in Work in Progress",
                },
            },
            fnaf_sprite_WIP = {
                name = "WIP: Sprite",
                text = {
                    "Sprite is in ",
                    "Work in Progress",
                    "or Placeholder",
                },
            },
            fnaf_dont = {
                name = "Don't",
                text = {
                    "Don't",
                },
            },
            fnaf_game_support = {
                name = "Game Data Supported",
                text = {
                    "This mod supports",
                    "FNAF 1 - 4",
                    "FNAF World",
                    "FNAF SL",
                    "FFPS",
                    "UCN",
                },
            },
            fnaf_save_import = {
                name = "Game data Unavailable",
                text = {
                    "{C:red,s:1.1}No game data imported",
                    "{C:red,s:1.1}Import your data",
                    "{C:red,s:1.1}in your mod folder",
                },
            },
        },

    },
    
    misc = {
        labels = {
            fnaf_security_seal = "Security Seal",
            fnaf_guard_seal = "Guard Seal",
        },
        dictionary = {
            k_item_pack = "Item Pack",
            fnaf_va = "Voicelines for cards",
            fnaf_va_volumeslider = "Volume for voicelines",
        },
    }
}
