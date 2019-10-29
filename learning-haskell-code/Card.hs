module Card 
(
    deck,
    makePlayersAndInventories
) where

deck :: [(String, String)]
deck = [("A", "Hearts"), ("2", "Hearts"), ("3", "Hearts"), ("4", "Hearts"), ("5", "Hearts"), ("6", "Hearts"), ("7", "Hearts"), ("8", "Hearts"), ("9", "Hearts"), ("10", "Hearts"), ("J", "Hearts"), ("Q", "Hearts"), ("K", "Hearts"), ("A", "Tiles"), ("2", "Tiles"), ("3", "Tiles"), ("4", "Tiles"), ("5", "Tiles"), ("6", "Tiles"), ("7", "Tiles"), ("8", "Tiles"), ("9", "Tiles"), ("10", "Tiles"), ("J", "Tiles"), ("Q", "Tiles"), ("K", "Tiles"), ("A", "Clovers"), ("2", "Clovers"), ("3", "Clovers"), ("4", "Clovers"), ("5", "Clovers"), ("6", "Clovers"), ("7", "Clovers"), ("8", "Clovers"), ("9", "Clovers"), ("10", "Clovers"), ("J", "Clovers"), ("Q", "Clovers"), ("K", "Clovers"), ("A", "Spades"), ("2", "Spades"), ("3", "Spades"), ("4", "Spades"), ("5", "Spades"), ("6", "Spades"), ("7", "Spades"), ("8", "Spades"), ("9", "Spades"), ("10", "Spades"), ("J", "Spades"), ("Q", "Spades"), ("K", "Spades")]

makePlayersAndInventories :: [String] -> [(String, String)] -> [(String, (String, String))]
makePlayersAndInventories [] _ = [] 
makePlayersAndInventories _ [] = []  
makePlayersAndInventories (x:xs) (y:ys) = (x, y):makePlayersAndInventories xs ys
