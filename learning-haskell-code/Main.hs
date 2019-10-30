module Main where

import System.IO
import Card

main :: IO ()
main = do 
    hSetBuffering stdout NoBuffering
    putStrLn "Welcome to the bussen command line game! \nPress ENTER to begin:"  
    name <- getLine
    putStrLn ("Who will be joining you during bussen today? \nPlease enter each name and press ENTER. \nOnce everyone's name has been entered, type 'done' and press ENTER.")
    playerNames <- getPlayerNames
    putStrLn "These players will play bussen: "
    printPlayerNames playerNames

    putStrLn "\nPress ENTER to start the game"
    input <- getLine
    let startState = makePlayersAndInventories playerNames fullDeck

    putStrLn "Round 1: "
    q1Answers <- (askQ1 startState) -- [(name, answer)] 
    q1Results <- givePlayersOneCard startState playerNames fullDeck
    let q1Deck = (fst $ q1Results)
    let q1State = (snd $ q1Results)
    compareAnswersQ1 q1State q1Answers

    putStrLn "Round 2: "
    q2Answers <- (askQ2 q1State) -- [(name, answer)] 
    q2Results <- givePlayersOneCard q1State playerNames q1Deck
    let q2Deck = (fst $ q2Results)
    let q2State = (snd $ q2Results)
    compareAnswersQ2 q2State q2Answers

    putStrLn "Round 3: "
    q3Answers <- (askQ3 q2State) -- [(name, answer)] 
    q3Results <- givePlayersOneCard q2State playerNames q2Deck
    let q3Deck = (fst $ q3Results)
    let q3State = (snd $ q3Results)
    compareAnswersQ3 q3State q3Answers

    putStrLn "Round 4: "
    q4Answers <- (askQ4 q3State) -- [(name, answer)] 
    q4Results <- givePlayersOneCard q3State playerNames q3Deck
    let q4Deck = (fst $ q4Results)
    let q4State = (snd $ q4Results)
    compareAnswersQ4 q4State q4Answers

    putStrLn "~~The end~~"
    input <- getLine
    

compareAnswersQ4 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ4 [] answers = return ()
compareAnswersQ4 ((pName, ((cardValue, cardHouse):cards)):otherPlayers) ((name, answer):otherAnswers) = do
    putStrLn (pName ++ " you guessed that your card would be a " ++ answer)
    putStrLn ("You got the card " ++ cardValue ++  " of " ++ cardHouse)
    if answer == "number"
        then if (cardValue == "2" || cardValue == "3" ||cardValue == "4" ||cardValue == "5" ||cardValue == "6" ||cardValue == "7" ||cardValue == "8" ||cardValue == "9" ||cardValue == "10")
            then putStrLn "Correct!"
            else putStrLn "Wrong! 1 sip for you!"
        else if (cardValue == "A" ||cardValue == "J" ||cardValue == "Q" ||cardValue == "K")
            then putStrLn "Correct"
            else putStrLn "Wrong! 1 sip for you!"
    input <- getLine
    compareAnswersQ4 otherPlayers otherAnswers

askQ4 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ4 [] = return []
askQ4 ( (name, cards) : otherPlayers) = do
    answer <- askQ4To name 
    otherAnswersWNames <- askQ4 otherPlayers
    return ((name, answer):otherAnswersWNames)


askQ4To :: String -> IO String
askQ4To name = do
    putStrLn (name ++ " do you think your next card will be a number or a letter?\nType number or letter and press ENTER.")
    input <- getLine
    if input == "number"
        then return input
        else if input == "letter"
            then return input
            else do
                putStrLn "The value you entered is invalid"
                askQ4To name


compareAnswersQ1 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ1 [] answers = return ()
compareAnswersQ1 ((pName, ((cardValue, cardHouse):otherCards)):otherPlayers) ((name, answer):otherAnswers) = do
    putStrLn (pName ++ " you guessed that your next card would be " ++ answer ++ " than 7")
    putStrLn ("You got the card " ++ cardValue ++  " of " ++ cardHouse)
    if answer == "lower"
        then if (cardValue == "A" || cardValue == "2" || cardValue == "3" || cardValue == "4" || cardValue == "5" || cardValue == "6")
            then putStrLn "Correct!"
            else putStrLn "Wrong! 1 sip for you!"
        else if (cardValue == "8" || cardValue == "9" || cardValue == "10" || cardValue == "J" || cardValue == "Q" || cardValue == "K")
            then putStrLn "Correct"
            else putStrLn "Wrong! 1 sip for you!"

    input <- getLine
    compareAnswersQ1 otherPlayers otherAnswers

compareAnswersQ3 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ3 [] answers = return ()
compareAnswersQ3 ((pName, ((cardValue, cardHouse):cards)):otherPlayers) ((name, answer):otherAnswers) = do
    putStrLn (pName ++ " you guessed that your card would be " ++ answer)
    putStrLn ("You got the card " ++ cardValue ++  " of " ++ cardHouse)
    if answer == "red"
        then if (cardHouse == "hearts" || cardHouse == "tiles")
            then putStrLn "Correct!"
            else putStrLn "Wrong! 1 sip for you!"
        else if (cardHouse == "clovers" || cardHouse == "spades")
            then putStrLn "Correct"
            else putStrLn "Wrong! 1 sip for you!"
    input <- getLine
    compareAnswersQ3 otherPlayers otherAnswers

askQ3 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ3 [] = return []
askQ3 ( (name, cards) : otherPlayers) = do
    answer <- askQ3To name 
    otherAnswersWNames <- askQ3 otherPlayers
    return ((name, answer):otherAnswersWNames)


askQ3To :: String -> IO String
askQ3To name = do
    putStrLn (name ++ " do you think your next card will be a red card or a black card?\nType red or black and press ENTER.")
    input <- getLine
    if input == "red"
        then return input
        else if input == "black"
            then return input
            else do
                putStrLn "The value you entered is invalid"
                askQ3To name


compareAnswersQ2 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ2 [] answers = return ()
compareAnswersQ2 ((pName, ((cardValue, cardHouse):cards)):otherPlayers) ((name, answer):otherAnswers) = do
    putStrLn (pName ++ " you guessed that your house would be " ++ answer)
    putStrLn ("You got the card " ++ cardValue ++  " of " ++ cardHouse)
    if answer == cardHouse
        then putStrLn "You guessed correct!"
        else putStrLn "Wrong, 1 sip for you!"
    input <- getLine
    compareAnswersQ2 otherPlayers otherAnswers


askQ1 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ1 [] = return []
askQ1 ( (name, cards) : otherPlayers) = do
    answer <- askQ1To name 
    otherAnswersWNames <- askQ1 otherPlayers
    return ((name, answer):otherAnswersWNames)


askQ1To :: String -> IO String
askQ1To name = do
    putStrLn (name ++ " do you think your next card will be higher or lower than 7?\nType higher or lower and press ENTER.")
    input <- getLine
    if input == "higher"
        then return input
        else if input == "lower"
            then return input
            else do
                putStrLn "The value you entered is invalid"
                askQ1To name

askQ2 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ2 [] = return []
askQ2 ( (name, cards) : otherPlayers) = do
    answer <- askQ2To name 
    otherAnswersWNames <- askQ2 otherPlayers
    return ((name, answer):otherAnswersWNames)
    

askQ2To :: String -> IO String 
askQ2To name = do
    putStrLn (name ++ " what house do you think your next card is from?\nType hearts, tiles, clovers or spades and press ENTER.")
    input <- getLine
    if input == "hearts" 
        then return input
        else if input == "tiles" 
            then return input
            else if input == "clovers"
                then return input
                else if input == "spades"
                    then return input
                    else do
                        putStrLn "The house you entered is invalid."
                        askQ2To name


printPlayerNames :: [String] -> IO ()
printPlayerNames [] = return ()
printPlayerNames (x:xs) = do
    putStr (x ++ ", ")
    printPlayerNames xs

    
getPlayerNames :: IO [String]
getPlayerNames = do
    input <- getLine
    if input == "done" 
        then return []
        else do 
            moreNames <- getPlayerNames
            return (input : moreNames)

            



