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
                name = "Kid",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}#2#",
                },
            },
        },

        Joker = {
            j_fnaf_endo_01 = {
                name = "Endo-01",
                text = {
                    "{C:red,s:1.1}+#1#{} Mult"
                },
            },
            j_fnaf_endo_02 = {
                name = "Endo-02",
                text = {
                    '{C:chips}+#1#{} Chips'
                },
            },
            j_fnaf_r_freddy = {
                name = "Rockstar Freddy",
                text = {
                    '{C:chips}+#1#{} Chips per {C:money}Gold{} Seal',
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_fnaf_balloon_boy = {
                name = "Balloon Boy",
                text = {
                    '{C:chips}+#1#{} Chips',
                    "{C:attention}#2#{} hand size",
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
                    "{C:inactive}(except legendaries, must have room)",
                },
            },
            j_fnaf_glitchtrap = {
                name = "Glitchtrap",
                text = {
                    "All active cards played",
                    "will become {C:attention}Glitched",
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
                    "Gains {X:mult,C:white} X#1# {} Mult",
                    "per {C:attention}Pizza Card{} played", 
                    "{C:red,s:1.1}Destroy all those cards before scoring{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
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
                    "Adds a {C:attention}Security seal{} to {C:attention}kid{} cards",
                    "held in hand at the {C:attention}end of the round{}",
                },
            }, 
            j_fnaf_helpy = {
                name = "Helpy",
                text = {
                    "Go up to {C:red}-$#1#{} in debt",
                    "the run {C:red,s:1.1}ends{} if you're in debt",
                    "after a boss blind",
                },
            },
            j_fnaf_learning = {
                name = "Learning - Endo",
                text = {
                    "Has a chance to upgrade",
                    "played poker hand based on",
                    "{C:green}times used in 20{}",
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
            j_fnaf_m_hippo = {
                name = "Mystic Hippo",
                text = {
                    "If the {C:attention}hand played{} is a",
                    "{C:attention}Base secret Poker Hand{}",
                    "create a {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
            },
            j_fnaf_cassie = {
                name = "Cassie",
                text = {
                    "Using a {C:green}item{} has a",
                    "{C:green}#1# in #2#{} chance",
                    "to create another one",
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
                    "Playing a hand with 5 Face cards",
                    "will have a 1 in 2 chance to create a ",
                    "random consumable card",
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
                    "Draw {C:attention}#1#{} cards from the deck",
                    "when in your last hand",
                },
            },
            j_fnaf_logbook = {
                name = "Survival Logbook",
                text = {
                    "{C:attention}Face{} cards get a",
                    "{C:attention}Guard badge{} when scored",
                },
            },

            -- Legendary

            j_fnaf_bonnie = {
                name = "Bonnie",
                text = {
                    "{X:green,C:white} x#1# {} all {C:green,E:1,S:1.1}listed{} {C:green,E:1,S:1.1}probabilities"
                },
            },

            j_fnaf_golden = {
                name = "Golden Freddy",
                text = {
                    "Retrigger all jokers"
                },
            }
            
        },

        Other = {
            k_fnaf_plus_tarot = {
                text = {
                    "+1 Tarot",
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
            fnaf_WIP = {
                name = "WIP: Code",
                text = {
                    "Code is in Work in Progress",
                },
            },
            fnaf_sprite_WIP = {
                name = "WIP: Sprite",
                text = {
                    "Sprite is in Work in Progress or Placeholder",
                },
            },
        },

    },
    
    misc = {
        labels = {
            fnaf_security_seal = "Security Seal",
            fnaf_guard_seal = "Guard Seal",
        },
    }
}
