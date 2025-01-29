--- STEAMODDED HEADER
--- MOD_NAME: Meg Of Spades
--- MOD_ID: mos_card
--- PREFIX: mos
--- MOD_AUTHOR: [Crossu]
--- MOD_DESCRIPTION: Meg jokersona
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0.0
--- BADGE_COLOR: 8839ef

SMODS.Atlas {
    key = "MegOfSpades",
    path = "MegOfSpades.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'meg',
    loc_txt = {
        name = 'Bunny',
        text = {
            'When a {C:attention}Flush{} is played with',
            '{C:spades}Spade{} cards, {X:mult,C:white} X#1# {} Mult per',
            '{C:spectral}Spectral{} card used this run',
            '{C:inactive}(Currently {X:mult,C:white} X#2# {}{C:inactive} Mult){}'
        }
    },
    config = { extra = { XmultGain = 2, Xmult = 1, containsSpade = false } },
    rarity = 3,
    atlas = 'MegOfSpades',
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.XmultGain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == "Spectral" then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.XmultGain
                return { message = "Upgraded!" }
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                card.ability.extra.containsSpade = true
            end
        end
        if context.joker_main then
            if context.poker_hands['Flush'] and card.ability.extra.containsSpade then
                card.ability.extra.containsSpade = false
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end
}
