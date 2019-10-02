# learning-haskell
A repository made to document my haskell learning journey

## Local setup

## The project
### My goal
During the course ASD-APP it is required of the students to show that they posses the ability to learn a new programming language by themselves. During this process it is important to learn 2 things: how to learn an unfamiliar programming paradigm and how to share the attained knowledge with peers. 

So my goal for this journey is threefold:
1. Learning a new programming language.
2. Becoming familiar with a new programming paradigm.
3. Improving my ability to share my newly attained knowledge with peers.

### Why Haskell?
To attain my goals I had to make a choice as to which programming language I was going to learn. To make an educated decision I decided to sum up some criteria.
1. The programming language should be commonly used by developers and fit a clear purpose. (This would ensure that the knowledge I was getting would actually be useful for me in the future)
2. The language should have a decently active community and good documentation. (If I was going to learn a language it would be important to have these things)
3. The programming language is of a different paradigm than the object oriented or imperative paradigm.
4. I had no experience with the programming language prior to starting.

After gathering my criteria I decided to check the programming languages proposed by the school. Out of this list I figured that Haskell fit the list the best. It is a language I have heard about several times during my time at school, it's a functional language and it has an extensive [documentation](https://www.haskell.org/documentation/).

### The learning process
#### Choosing my learning resource
When I started to learn Haskell I was very happy with the extensive documentation the language has. This documentation is filled with books, courses, tutorials, online resources, manuals and even library documentation. 2 of these categories gained my interest. Books and courses. This is because both of these usually contain an incredibly high amount of information concerning the language. I decided to go with books because I have personally already tried some other courses in the past and have found that they weren't very successful for me. 
Out of all the books on the documentation page I decided to choose ["Learn you a haskell for great good!"](http://learnyouahaskell.com/). Because this book has a very down to earth vibe when skimming through it. Its target audience is also people who already have experience with imperative programming, but who have not worked with functional programming yet. Which fit my profile perfectly. 

#### The first steps
When I started reading the book I noticed the author would use the GHC (Glasgow Haskell Compiler) which is the most widely used Haskell compiler. The author uses the GHCi (the interactive version of the compiler)to test small snippets of code to start out the learning journey. I decided that I wanted a more serious setup than just my command prompt to start out so I set out on my own to find a more professional alternative. I decided to do my script editing in IntelliJ because this is an IDE that I am very familiar with and it has a [Haskell plugin](https://plugins.jetbrains.com/plugin/8258-intellij-haskell). 
After setting this up I wanted to make sure I used a professional Haskell build tool (like Maven which I have learned about in the OOSE-DEA course). After surfing the Internet I found [Stack](https://docs.haskellstack.org/en/stable/README/), which is used to install the GHC and package needed in your project, building, testing and benchmarking your project. Perfect!
Stack uses a directory setup similar to Maven. It uses an *app*, *source* and a *test* folder. Stack states the following about the folders:
- > The app directory should preferably contain only files related to executables. 
- > Edit files in the src/ directory. 

So the introduction of the only difference with Maven here is that the executables should be put in the app folder.

Looking at my hello world project there are 2 files. **app/Main.hs**:
```Haskell
module Main where

import Lib

main :: IO ()
main = putStrLn helloworld
```
and **src/Lib.hs**:
```Haskell
module Lib
    (
    helloworld
    ) where
    
helloworld = "Hello world!"
```
Looking at these 2 files there is already a lot that I learned.
- Haskell code is split up into several .hs files. Each file is a "module". 
- Modules can import each other to use their functions.
- Function declaration is a lot different than in imperative languages. The name of the function is followed by an `=`.
- Return types don't have to be declared. (in the helloworld function)
- Modules can declare which functions they export. This feels similar to private and public functions in imperative programming languages.
- Haskell has standard functions as well like `putStrln`.

Now with my setup done it was time to truly dive into the book.

#### Haskell is lazy and statically typed
The book began with explaining types (`int`, `bool`, 'char') lists and operators. This part was quite simple and obvious for people with programming experience so I won't go into detail here.
Some interesting things to mention here though is that Haskell is a **lazy** programming language. This means that Haskell won't execute functions and calculate tings unless it is really forced to. This allows you to use things like infinite lists in functions (because it will only use the values in that list that it needs). Haskell is also **statically typed**, which means that when you compile the program, Haskell knows which type each piece of information is. So we don't have to state types everywhere (like we have to do in Java for example), which means something like `a = 5 + 4` is possible.

#### Lists and tuples
Lists are very interesting in Haskell. Like I said infinite lists are actually a thing because Haskell is lazy. Creating lists can also be done much quicker than in imperative languages by using `..` in `[2..10]` for example. Haskell is smart enough to fill in the rest of the list. This also works in `[2,4..10 ]` which fills the list with only even ints.
An interesting aspect about Haskell's lists is **list comprehensions**. This allows you to perform a certain expression on each value in the list like this : `[x&#42;2 | x <- [1..10]]`




