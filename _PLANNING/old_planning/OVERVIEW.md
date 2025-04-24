
# PLANNING:

## OVERVIEW:
Simple deckbuilder game.

Keep scope TINY.

Plan EVERYTHING before implementing.


---

# GAME DESIGN:

Currencies:
- mana: reset to 4 every turn
- doubloons: persistent currency

## OBJECTS:
2 types of cards:
- Unit cards. These spawn units
- Ability cards. These have arbitrary effects 

Trinkets:
Provide permanent upgrades for runs

----

<br/>
<br/>
<br/>

# GAME LOOP:
- Player does battle-phase
- Player travels map (like Binding of Isaac level)
- Player does shop-phase

## BATTLE-LOOP:
- Player plays cards
- Player's units attack
- Player plays cards
- Enemy units attack
- (repeat until either side has no cards left)

----

<br/>
<br/>
<br/>


## BOARD:
Board is a 4x8 board; total of 32 card slots.  
(Player's side is 2x8 board, opponent's side is 2x8 board)


## DECKS:
The player has multiple decks:
- Special deck (Cannot be drawn from easily)
    - contains stronger cards, that have big impact
    - (Special deck starts off with only 2 cards)
- Normal deck (contain majority of the player's cards)
    - The player can click the normal-deck to draw a card into hand.
    - (works 3x per turn.)

The player's normal deck always starts with one strong `UNIT` card,
and always contains 2 `SHUFFLE` cards at the end. (To reshuffle discard pile into draw-pile)

When not in battle, there are 3 card-piles:
- Shop deck
- Normal deck
- Special deck
During battle, there are more card-piles:
- Current hand
- Normal Draw pile
- Discard pile
- Special Draw pile
- Special Discard pile
During shop-phase, there are other card-piles:
- Shop Draw pile
- Shop discard pile



## CARDS:
Cards have MANY different components:

### Card-target:
Every playable card has a target.  Possible targets:
- ally
- enemy
- random-ally
- random-enemy
- all-allies
- all-enemies
- all-units
- card in hand

### Card traits:
- TOP-DRAW: When shuffled, placed at the top of the draw pile
- LAST-DRAW: When shuffled, placed at the bottom of the draw pile
- FOOD: When played, removed for the rest of the battle
- DOOMED: When played, removed from the deck forever
- ETERNAL: When played, move to draw pile instead of draw pile
- ETHEREAL: Automatically discarded if it is in the hand at the end of turn
- GUARDED: (units only) Retains BLOCK across turns
- WILLPOWER: (units only) When killed, revive, and move to discard-pile
- INVINCIBLE: (units only) When killed, revive, and move to draw-pile

### Card costs:
Cards can cost mana XOR doubloons to play.
Generally, players will prefer to play with mana.

### Unit cards:
Unit-cards have extra properties:
- Health
- Attack
- Block
When attacking, unit-cards will prioritize opponent-cards at the front;
then, they will prioritize cards that are closest to them in the X direction.

---

# TECHNICAL DETAILS:
Define cards/effects just like how you would for lootplot.

Art should be a limited-pallete, just like downwell.
Should be able to swap out palletes.

The base-card-class should have a "target" table, that denotes how the card is supposed to be played.
For example; `target = "ANY_CARD"`, we can target any other card with this card.
`target = "EMPTY_ALLY_SPACE"`, used for ally-units. We can target 

Use ev/qbuses.
There should be a special kind of events/questions, known as "tags".
"tags" are the same as questions/events, HOWEVER, they automatically call functions on every active-unit, every card in hand, and every trinket.

