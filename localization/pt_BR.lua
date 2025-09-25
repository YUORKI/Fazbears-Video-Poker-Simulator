---@diagnostic disable: undefined-global

return {
    descriptions = {
        Enhanced = {
            m_fnaf_pizza = {
                name = "Carta Pizza",
                text = {
                     "{C:chips}+#1#{} Fichas",
                    "sem classe ou naipe",                   
                    "Expira depois de {C:attention}#2#{} Usos",
                },
            },
            m_fnaf_glitch = {
                name = "Carta Bugada",
                text = {
                    "",
                }
            },
            m_fnaf_kid = {
                name = "Criança",
                text = {
                    "{X:chips,C:white} X#1# {} Fichas",
                }
            }
        },

        fnaf_item = {
            c_fnaf_pizza_maker = {
                name = "Máquina De Pizza Fredbear",
                text = {
                    "Aprimora {C:attention}#1#{} carta(s)",
                    "selecionadas para",
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
                    "Adiciona a {C:attention}#1#",
                },
            },

            c_fnaf_boost = {
                name = "Booster Pack",
                text = {
                    "Cria até {C:attention}#1#{} cartas"
                },
            },

            c_fnaf_grabbag = {
                name = "Grab Bag",
                text = {
                    "Cria até {C:attention}#1#",
                    "cartas de {C:green}Item{} aleatórias",
                    "{C:inactive}(Deve ter espaço)",
                },
            },

            c_fnaf_philately = {
                name = "Philately collection",
                text = {
                    "Adiciona um {C:attention}Selo Aleatório{}",
                    "a {C:attention}1{} carta selecionada",
                    "na sua mão",
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
        
        Spectral = { 
            c_fnaf_secur_log = {
                name = "Security Logbook",
                text = {
                    "Adiciona um {C:gold}Guard Seal{}",
                    "a {C:attention}1{} carta selecionada",
                    "na sua mão",
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
                    "{C:chips}+#1#{} Fichas"
                },
            },
            j_fnaf_time_clock = {
                name = "Relógio de ponto",
                text = {
                    "{C:chips}+#1#{} Fichas depois de pontuar",
                    "uma {C:attention}Sequência{} com todas cartas",
                    "sendo numeradas",
                },
            },
            j_fnaf_frog = {
                name = "Happy Frog",
                text = {
                    "{C:chips}+#1#{} Fichas por cada",
                    "{C:attention}Blind{} ignorado nesta rodada",
                    "{C:inactive}(No momento, {C:chips}+#2#{C:inactive} Fichas)",
                },
            },
            j_fnaf_r_freddy = {
                name = "Rockstar Freddy",
                text = {
                    "Dá {C:chips}+#1#{} Fichas para",
                    "cada {C:attention}Selo Dourado",
                    "do seu {C:attention}baralho completo",
                    "{C:inactive}(No momento, {C:chips}+#2#{C:inactive} Fichas)",
                },
            },
            j_fnaf_bb = {
                name = "Balloon Boy",
                text = {
                    "Não faça",
                },
            },
            j_fnaf_balloon_boy = {
                name = "Balloon Boy",
                text = {
                    "{C:red}Totalmente irritante",
                    "{X:chips,C:white}X#1#{} Chips",
                    "{C:red}Eterno por (#2#/#3#) rodadas.",
                },
            },
            j_fnaf_pizzabot = {
                name = "Pizza Bot",
                text = {
                    "Adiciona uma carta {C:attention}Pizza{}",
                    "ao seu baralho quando",
                    "o {C:attention}Blind{} é selecionado",
                },
            },
            j_fnaf_dee_dee = {
                name = "Dee Dee",
                text = {
                    "Cria um {C:attention}Curinga{} aleatório",
                    "no começo de uma nova aposta",
                    "{C:inactive}(Sem lendarias, Deve ter espaço)",
                },
            },
            j_fnaf_glitchtrap = {
                name = "Glitchtrap",
                text = {
                    "Todas as cartas de {C:attention}Ases{}",
                    "se tornam cartas {C:attention}Bugadas{}",
                    "quando pontuadas",
                },
            },
            j_fnaf_ennard = {
                name = "Ennard",
                text = {
                    "Ganha {C:money}$#1#{} por", 
                    "cada carta destruida",
                },
            },
            j_fnaf_glam_chica = {
                name = "Glamrock Chica",
                text = {
                    "Ganha  {X:mult,C:white} X#1# {} Multi",
                    "por {C:attention}Pizza Card{} jogada", 
                    "{C:red,s:1.1}Destrói todas essas cartas antes de pontuar{}",
                    "{C:inactive}(No momento, {X:mult,C:white} X#2# {C:inactive} Multi)",
                },
            },
            j_fnaf_pickles = {
                name = "Pickles",
                text = {
                    "{C:green}Jarro de Pickles",
                },
            },
            j_fnaf_s_puppet = {
                name = "Security Puppet",
                text = {
                    "Adds a {C:attention}Security seal{},"
                    "to {C:attention}kid{} cards",
                    "held in hand at the",
                    "{C:attention}end of the round{}",
                },
            }, 
            j_fnaf_helpy = {
                name = "Helpy",
                text = {
                    "Tenha até {C:red}-$#1#{} em dívida",
                    "essa rodada {C:red,s:1.1}termina{} se",
                    "voce estiver em dívida",
                    "Depois da Blind de Chefe",
                },
            },
            j_fnaf_learning = {
                name = "Learning - Endo",
                text = {
                    "Tem a chance de aprimorar",
                    "{C:attention}mão de pôquer{} usada baseada",
                    "{C:green}vezes usada em #2#{}",
                },
            },
            j_fnaf_gator = {
                name = "Montgomery Gator",
                text = {
                    "Ganha {X:mult,C:white} X#1# {} Multi por",
                    "cada carta destruída",
                    "{C:inactive}(No momento, {X:mult,C:white} X#2# {C:inactive} Multi)",
                },
            },
            j_fnaf_toy_bonnie = {
                name = "Toy Bonnie",
                text = {
                    "{C:attention}7s{} funcionam como {C:attention}Naipe Curinga{}",
                },
            },
            j_fnaf_m_hippo = {
                name = "Mystic Hippo",
                text = {
                    "Se a {C:attention}mão de pôquer{} for",
                    "{C:attention}mão de pôquer secreta base{}, cria um(a)",
                    "carta {C:spectral}Espectral{} aleatória",
                    "{C:inactive}(Deve ter espaço)",
                },
            },
            j_fnaf_cassie = {
                name = "Cassie",
                text = {
                    "Usar um {C:green}item{} tem uma",
                    "Chance de {C:green}#1# in #2#{}",
                    "de criar outro",
                },
            },
            j_fnaf_toy_chica = {
                name = "Toy Chica",
                text = {
                    "{C:chips}+#2#{} Fichas",
                    "por cada carta destruida",
                    "{C:inactive}(No momento {C:chips}++#1#{C:inactive} Fichas)",
                },
            },
            j_fnaf_missing = {
                name = "Missing Poster",
                text = {
                    "Jogar uma mão com {C:attention}#3#{} Cartas de Realeza",
                    "tem chance de {C:green}#1# em #2#{} de criar",
                    "uma carta {C:attention}consumível{}",
                    "{C:inactive}(Cartas Espectrais não incluidas)",
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
                    "Compre {C:attention}+#1#{} cartas",
                    "na sua ultima mão",
                },
            },
            j_fnaf_logbook = {
                name = "Survival Logbook",
                text = {
                    "{C:attention}Face{} cards get a",
                    "{C:attention}Guard badge{} when scored",
                },
            },
            j_fnaf_c_baby = {
                name = "Circus Baby",
                text = {
                    '{C:chips}+#1#{} Chips',
                    "if your hand has all {C:attention}Suits{}",
                    '{C:inactive}(Hearts / Diamonds / Spades / Clubs)'
                },
            },

            j_fnaf_rock_chica = {
                name = "Rockstar Chica",
                text = {
                    "{C:attention}Pizza cards{}" ,
                    "have {C:green,E:1,S:1.1}#1#{} more {C:attention}usages"
                },
            },

            -- Legendary

            j_fnaf_bonnie = {
                name = "Bonnie",
                text = {
                    "{X:green,C:white} x#1# {} todas {C:green,E:1,S:1.1} probabilidades listadas"
                },
            },

            j_fnaf_chica = {
                name = "Chica",
                text = {
                    "{C:attention}-#1#%{} Todas Pontuações de Blind"
                },
            },

            j_fnaf_foxy = {
                name = "Foxy",
                text = {
                    "Reativa todas as cartas jogadas"
                },
            },

            j_fnaf_freddy = {
                name = "Freddy",
                text = {
                    "{X:mult,C:white} X#1# {} Mult per Marks of Completion",
                    "in fnaf games (Clickteam)",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    "{C:red,s:1.1}Import your data in your mod folder"
                },
            },

            j_fnaf_golden = {
                name = "Golden Freddy",
                text = {
                    "Seu pontuação da {C:attention}UCN{} sera usado como {C:red,s:1.1}Multi{}",
                    "{C:inactive}(No momento {C:red,s:1.1} #1# {C:inactive} Multi)",
                    "{C:red,s:1.1}Importe sua data de UCN na sua pasta do mod"
                },
            }
        },

        Voucher = { 
            v_fnaf_collection = {
                name = "Collection",
                text = {
                    "{C:attention}+#1#{} Espaço Booster",
                },
            },
            v_fnaf_starter_deck = {
                name = "Starter Deck",
                text = {
                    "Cartas de {C:tarot}Tarô{} podem",
                    "aparecer em qualquer um",
                    "dos {C:attention}Pacotes de Item",
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
                    "Immune a {C:green}debuffs",
                },
            },
            fnaf_guard_seal = {
                name = "Guard Seal",
                text = {
                    "Cria uma carta de {C:green}Item{}",
                    "quando {C:attention}descartada",
                    "{C:inactive}(Deve ter espaço)",
                },
            },
            p_fnaf_item_normal = {
                name = "Pacote de Item",
                text = {
                    "Escolha {C:attention}#1#{} de até",
                    "{C:attention}#2#{C:green} cartas de Item{}",
                },
            },
            p_fnaf_item_jumbo = {
                name = "Pacote de Item Jumbo",
                text = {
                    "Escolha {C:attention}#1#{} de até",
                    "{C:attention}#2#{C:green} cartas de Item{}",
                },
            },
            p_fnaf_item_mega = {
                name = "Pacote de Item Mega",
                text = {
                    "Escolha {C:attention}#1#{} de até",
                    "{C:attention}#2#{C:green} cartas de Item{}",
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
                name = "Não faça",
                text = {
                    "Não faça",
                },
            },
            fnaf_game_support = {
                name = "Supporte de Game Data",
                text = {
                    "Esse mod suporta",
                    "FNAF 1",
                    "UCN",
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
            k_item_pack = "Item Pack"
        },
    }
}
