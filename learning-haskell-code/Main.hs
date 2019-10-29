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

    putStrLn "\nPress ENTER to continue"
    input <- getLine
    mapM_ print (makePlayersAndInventories playerNames deck)
    putStrLn "Round 1: "

    

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



