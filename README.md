# learning-haskell
A repository made to document my haskell learning journey

## The product
### Local setup
1. Download the [Glasgow Haskell Compiler](https://www.haskell.org/ghc/) (GHC).
2. Clone this repository.
3. Open command prompt at learning-haskell/learning-haskell-code and run `cabal install random`.
4. run `runhaskell Main.hs` at the same location.
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
When I started reading the book I noticed the author would use the GHC (Glasgow Haskell Compiler) which is the most widely used Haskell compiler. The author uses the GHCi (the interactive version of the compiler)to test small snippets of code to start out the learning journey. I decided that I wanted to use a code editor right from the start because that is what I am most familiar with and I dislike trying out code snippets in the command line.
I decided to use Visual studio code with the [haskell plugin](https://marketplace.visualstudio.com/items?itemName=justusadam.language-haskell) to make my haskell files (.hs).

Looking at some hello world setups online there were a lot of things I learned about Haskell projects.
- Haskell code is split up into several .hs files. Each file is a "module". 
- Modules can import each other to use their functions.
- Function declaration is a lot different than in imperative languages. The name of the function is followed by an `=`.
- Return types don't have to be declared. (in the helloworld function)
- Modules can declare which functions they export. This feels similar to private and public functions in imperative programming languages.
- Haskell has standard functions as well like `putStrln`.

So with my visual studio code and GHC ready it was time to truly dive into the book.

#### Haskell is lazy and statically typed
The book began with explaining types (`Int`, `Bool`, 'Char') lists and operators. This part was quite simple and obvious for people with programming experience so I won't go into detail here.
Some interesting things to mention here though is that Haskell is a **lazy** programming language. This means that Haskell won't execute functions and calculate tings unless it is really forced to. This allows you to use things like infinite lists in functions (because it will only use the values in that list that it needs). Haskell is also **statically typed**, which means that when you compile the program, Haskell knows which type each piece of information is. So we don't have to state types everywhere (like we have to do in Java for example), which means something like `a = 5 + 4` is possible.

#### Lists and tuples
Lists are very interesting in Haskell. Like I said infinite lists are actually a thing because Haskell is lazy. Creating lists can also be done much quicker than in imperative languages by using `..` in `[2..10]` for example. Haskell is smart enough to fill in the rest of the list. This also works in `[2,4..10 ]` which fills the list with only even ints.
An interesting aspect about Haskell's lists is **list comprehensions**. This allows you to perform a certain expression on each value in the list like this : `[x`<code>&ast;</code>`2 | x <- [1..10]]` where each value in the list is multiplied by 2. Because Haskell is statically typed this produces a new list of ints with each result.

An alternative to lists in Haskell are **tuples**. Tuples are like lists and they are defined by parentheses like this: `(11, 'A')`. However they follow some different rules than lists: 
1. Tuples have a predefined length that cannot be changed.
2. Tuples can contain multiple values of different types.
It is also possible to have lists of tuples, but because lists can only contain values of the same type each tuple in the list will need to have the same amount of values that are of the same type(s). So while this is allowed: `[('A', 11, 12), ('G', 45, 74), ('Y', 1, 91)]`, this is not: `[('A', 11, 12), ('G', 45), (23)]` because the tuples are of different types.

#### Types and typeclasses
When defining functions in Haskell, types are defined on a line above our function like this:
```Haskell
addThree :: Int -> Int -> Int -> Int
```
Meaning that this functions takes 3 Ints as parameters and returns an Int because it is the last in the line and a functions can only be of (e.g. return) one type.

A typeclass is a kind of interface that defines some behavior. Types in Haskell can be a part of a typeclass. If it is a part of that typeclass it will support the behaviour that that typeclass describes. So the bool type is a part of the Eq typeclass. The Eq typeclass provides an interface for testing for equality. So all standard types in Haskell are a part of the Eq typeclass. If we look at the function declaration for the `==` function 
```Haskell
(==) :: (Eq a) => a -> a -> Bool
```
We see that this functions takes 2 parameters that are of a type that adheres to the Eq typeclass (the 2 a's) and it returns a Bool. So typeclasses are very useful for defining functions that can take parameters that need to support a specific kind of behavior, but don't have to be of a specific type. 

#### Pattern matching
Pattern matching is a very useful functionality within Haskell.
```Haskell
length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs
```
There is a lot of information to gather from this code block. This is a function that return the length of a list. The function is of a type that is a part of the `Num` typeclass (the `b` is the last parameter). It also gets an `[a]` as parameter, which is a list with values that can be of any type because `a` is not a part of any typeclass here.
By using pattern matching several scenarios can be handled with minimal text in Haskell. In this code block: 
- If `[a]` is an `[]` (empty list) then `b` will be 0 (e.g. length' will be 0. 0 is an int which is a part of the Num typeclass).
- It is important to understand that `(_:xs)` is the same as `[a]`. Because `(_:xs)` is the first parameter just like `[a]`. Doing `:` in between a value and a list means to append that value to the front of a list in Haskell. `_` means that it doesn't matter what that part is. So `(_:xs)` means that we turn `[a]` into a tuple, the first value (it doesn't matter what type it is) is on the `_` spot and the rest of the list is after the `:` in the `xs`. This `xs` we can use in a later part of our function like we do here.
- If `[a]` is a list then `b` will be `1 + length' xs`. 

#### Recursion
Because Haskell is a functional programming language it does not use for or while loops like in imperative languages. To make sure a function runs for a certain amount of iterations recursion has to be used. An example of a Haskell recursive function that uses the quicksort algorithm:
```Haskell
quicksort :: (Ord a) => [a] -> [a]  
quicksort [] = []  
quicksort (x:xs) =   
    let smallerSorted = quicksort [a | a <- xs, a <= x]  
        biggerSorted = quicksort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted
```
Like in all recursive functions the edge scenario `[]` is defined first. After that the actually quicksorting is defined. The `smallerSorted` (which is an list of all items smaller than `x` in `(x:xs)`) is added to `[x]` which in turn is added to `biggerSorted` (which is an list of all items bigger than `x` in `(x:xs)`). To get all items smaller/bigger quicksort is performed recursively on the `xs` in `(x:xs)`. 
`let` bindings are used in Haskell to bind expressions to variables. They are always followed by an `in` which defines the scope of this variable.

#### Input and output 
In imperative programming I have learned that your program is essentially a list of steps for your computer to execute. These steps usually involve changing what the value of some variable is. Since Haskell is a functional programming language, you can't change the state of variables. What you can do is run functions that always give back the same result based on the parameter that we give it. 
The fact that functions can't change is a good thing because it makes it easier to reason about the programs. However, if the function can't change anything, how can it tell you what it has calculated? 
Haskell has a nice separation of the "impure" part (the part that communicates with the keyboard and the screen) and the "pure" part (the part that has all the advantages purity offers like laziness, robustness and modularity), so that we can use the best of both worlds.
To handle input and output (the "impure" part of programs in Haskell) Haskell uses **I/O actions**. An I/O action is something that carries out an action with a side-effect (printing stuff to or reading from the screen) and that has a return value. If an I/O action doesn't have a meaningful return value, the empty tuple `()` is used. An example of an I/O action with a valid return value is the `getLine` action using the `:t` functions we can check out its return type:
```Haskell
Prelude> :t getLine
getLine :: IO String
```
I/O action will be performed when we give it to the function called `main` and we run the program. To perform multiple I/O actions in a main function you need to use the `do` syntax to glue several functions together.
```Haskell 
main = do  
    putStrLn "Hello, what should I call you?"  
    name <- getLine  
    putStrLn ("Hey " ++ name ++ ", how are you doing?")
```
An interesting line in this piece of code is the `name <- getLine` line. getLine is an I/O action with a return type of `String` (basically `[Char]` in Haskell). You can bind the return value out of an I/O action to name using the `<-` construct. If you take data out of an I/O action you always need to use the `<-` construct. 

#### Input arguments
In Haskell you can use input arguments to make sure Haskell knows what values parameters should have without needing to ask you once it is already running. 	The `System.Environment` has useful I/O actions for this purpose:
```Haskell
Prelude> :t getLine
getArgs :: IO [String]
Prelude> :t getProgName
getProgName :: IO String
```
`getArgs` is a function that returns a `IO [String]` of all the Strings that were given as arguments after the program has been called.
`getProgName` is a function that returns a `IO String`, this `String` is the program name.
















