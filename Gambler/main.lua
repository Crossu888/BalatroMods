SMODS.Atlas {
    key = "gamblerJokers",
    path = "gambler.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'blackjack',
    loc_txt = {
        name = 'Blackjack',
        text = {
            "{X:mult,C:white} X#1# {} Mult if combined",
            "scored card values equal {C:attention}21{}"
        }
    },
    config = { extra = { Xmult = 5, scoreLow = 0, scoreHigh = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    rarity = 3,
    atlas = 'gamblerJokers',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.scoreLow = 0
            card.ability.extra.scoreHigh = 0
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() <= 10 and context.other_card:get_id() >= 2 then
                card.ability.extra.scoreLow = card.ability.extra.scoreLow + context.other_card:get_id()
                card.ability.extra.scoreHigh = card.ability.extra.scoreHigh + context.other_card:get_id()
            elseif context.other_card:get_id() > 10 and context.other_card:get_id() < 14 then
                card.ability.extra.scoreLow = card.ability.extra.scoreLow + 10
                card.ability.extra.scoreHigh = card.ability.extra.scoreHigh + 10
            elseif context.other_card:get_id() == 14 then
                card.ability.extra.scoreLow = card.ability.extra.scoreLow + 1
                card.ability.extra.scoreHigh = card.ability.extra.scoreHigh + 11
            end
        end
        if context.joker_main then
            if card.ability.extra.scoreLow == 21 or card.ability.extra.scoreHigh == 21 then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end
}
