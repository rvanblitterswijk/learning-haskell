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

    -- Round 1:
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




compareAnswersQ2 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ2 [] answers = return ()
compareAnswersQ2 ((pName, ((cardValue, cardHouse):otherCards)):otherPlayers) ((name, answer):otherAnswers) = do
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
    compareAnswersQ2 otherPlayers otherAnswers


compareAnswersQ1 :: [(String, [(String, String)])] -> [(String, String)] -> IO() --State, Answers 
compareAnswersQ1 [] answers = return ()
compareAnswersQ1 ((pName, ((cardValue, cardHouse):cards)):otherPlayers) ((name, answer):otherAnswers) = do
    putStrLn (pName ++ " you guessed that your house would be " ++ answer)
    putStrLn ("You got the card " ++ cardValue ++  " of " ++ cardHouse)
    if answer == cardHouse
        then putStrLn "You guessed correct!"
        else putStrLn "1 sip for you!"
    input <- getLine
    compareAnswersQ1 otherPlayers otherAnswers


askQ2 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ2 [] = return []
askQ2 ( (name, cards) : otherPlayers) = do
    answer <- askQ2To name 
    otherAnswersWNames <- askQ2 otherPlayers
    return ((name, answer):otherAnswersWNames)


askQ2To :: String -> IO String
askQ2To name = do
    putStrLn (name ++ " do you think your next card will be higher or lower than 7?\nType higher or lower and press ENTER.")
    input <- getLine
    if input == "higher"
        then return input
        else if input == "lower"
            then return input
            else do
                putStrLn "The value you entered is invalid"
                askQ2To name

askQ1 :: [(String, [(String, String)])] -> IO [(String, String)]
askQ1 [] = return []
askQ1 ( (name, cards) : otherPlayers) = do
    answer <- askQ1To name 
    otherAnswersWNames <- askQ1 otherPlayers
    return ((name, answer):otherAnswersWNames)
    

askQ1To :: String -> IO String 
askQ1To name = do
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
                        askQ1To name


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

            



