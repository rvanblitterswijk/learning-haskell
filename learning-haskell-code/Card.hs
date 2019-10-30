module Card 
(
    fullDeck,
    makePlayersAndInventories,
    givePlayerCard,
    givePlayersOneCard
) where

import System.Random

fullDeck :: [(String, String)]
fullDeck = [("A", "hearts"), ("2", "hearts"), ("3", "hearts"), ("4", "hearts"), ("5", "hearts"), ("6", "hearts"), ("7", "hearts"), ("8", "hearts"), ("9", "hearts"), ("10", "hearts"), ("J", "hearts"), ("Q", "hearts"), ("K", "hearts"), ("A", "tiles"), ("2", "tiles"), ("3", "tiles"), ("4", "tiles"), ("5", "tiles"), ("6", "tiles"), ("7", "tiles"), ("8", "tiles"), ("9", "tiles"), ("10", "tiles"), ("J", "tiles"), ("Q", "tiles"), ("K", "tiles"), ("A", "clovers"), ("2", "clovers"), ("3", "clovers"), ("4", "clovers"), ("5", "clovers"), ("6", "clovers"), ("7", "clovers"), ("8", "clovers"), ("9", "clovers"), ("10", "clovers"), ("J", "clovers"), ("Q", "clovers"), ("K", "clovers"), ("A", "spades"), ("2", "spades"), ("3", "spades"), ("4", "spades"), ("5", "spades"), ("6", "spades"), ("7", "spades"), ("8", "spades"), ("9", "spades"), ("10", "spades"), ("J", "spades"), ("Q", "spades"), ("K", "spades")]

makePlayersAndInventories :: [String] -> [(String, String)] -> [(String, [(String, String)])]
makePlayersAndInventories [] _ = [] 
makePlayersAndInventories (x:xs) (y:ys) = (x, []):makePlayersAndInventories xs ys

givePlayerCard :: [(String, [(String, String)])] -> (String, String) -> String -> [(String, [(String, String)])]
givePlayerCard [] _ _ = []
givePlayerCard  (  ( name, cards )  : otherPlayers ) cardToAdd nameToAdd = 
    if (name == nameToAdd)
        then
            ( name, cardToAdd:cards ):(givePlayerCard otherPlayers cardToAdd nameToAdd )
        else
           (name, cards):(givePlayerCard otherPlayers cardToAdd nameToAdd)

pullRandomCard :: [(String, String)] -> IO ((String, String), [(String, String)])
pullRandomCard deck = do
    randomCardIndex <- randomRIO (0, length deck - 1)
    let pulledCard = deck !! randomCardIndex
        deckPartBefore = take randomCardIndex deck
        deckPartAfter = drop (randomCardIndex + 1) deck
    let newDeck = deckPartBefore ++ deckPartAfter
    return (pulledCard, newDeck)

givePlayersOneCard :: [(String, [(String, String)])] -> [String] -> [(String, String)] -> IO ([(String, String)], [(String, [(String, String)])]) --Returns (Deck, State)
givePlayersOneCard state [] deck = return (deck, state)
givePlayersOneCard state (player:otherPlayers) deck = do
    pulledCardAndDeck <- pullRandomCard deck
    let newDeck = (snd pulledCardAndDeck)
    let pulledCard = (fst pulledCardAndDeck)
    let newState = givePlayerCard state pulledCard player
    givePlayersOneCard newState otherPlayers newDeck

