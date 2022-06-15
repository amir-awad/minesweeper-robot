type Cell = (Int,Int)
data MyState = Null | S Cell [Cell] String MyState deriving (Show,Eq)

-- up function takes as input a state and returns the state resulting from moving up
-- from the input state. If up will result in going out of the boundaries of the grid,
-- Null should be returned.
up :: MyState -> MyState
up Null = Null
up (S (x,y) l str s) | x <= 0 = Null
                     | otherwise = (S (x-1,y) l "up" (S (x,y) l str s))

-- down function takes as input a state and returns the state resulting from moving
-- down from the input state. If down will result in going out of the boundaries of the
-- grid, Null should be returned.
down :: MyState -> MyState
down Null = Null
down (S (x,y) l str s) | x >= 3 = Null
                       | otherwise = (S (x+1,y) l "down" (S (x,y) l str s))

-- left function takes as input a state and returns the state resulting from moving left
-- from the input state. If left will result in going out of the boundaries of the grid,
-- Null should be returned.
left :: MyState -> MyState
left Null = Null
left (S (x,y) l str s) | y <= 0 = Null
                       | otherwise = (S (x,y-1) l "left" (S (x,y) l str s))

-- right function takes as input a state and returns the state resulting from moving
-- right from the input state. If right will result in going out of the boundaries of the
-- grid, Null should be returned.
right :: MyState -> MyState
right Null = Null
right (S (x,y) l str s) | y >= 3 = Null
                        | otherwise = (S (x,y+1) l "right" (S (x,y) l str s))

-- collect function takes as input a state and returns the state resulting from collecting
-- from the input state. Collecting should not change the position of the robot, but
-- removes the collected mine from the list of mines to be collected. If the robot is not
-- in the same position as one of the mines, Null should be returned.
collect :: MyState -> MyState
collect Null = Null
collect (S (x,y) l str s) = if(check (x,y) l) then (S (x,y) (remove (x,y) l) "collect" (S (x,y) l str s)) else Null

-- check function takes as input cell and list of cells and returns True if the
-- cell exists in the list of cells, otherwise it returns False.
check :: Cell -> [Cell] -> Bool
check _ [] = False
check (x,y) ((x1,y1):xs) | x == x1 && y == y1 = True
                         | otherwise = check (x,y) xs
-- remove function takes as input cell and list of cells and returns the 
-- list after removing from it the input list.
remove :: Cell -> [Cell] -> [Cell]
remove _ [] = []
remove (x,y) ((x1,y1):xs) | x == x1 && y == y1 = xs
                          | otherwise = (x1,y1):(remove (x,y) xs)

-- nextMyStates function takes as input a state and returns the set of states resulting from
-- applying up, down, left, right, and collect from the input state. The output set
-- of states should not contain any Null states.

nextMyStates :: MyState -> [MyState]
nextMyStates Null = []
nextMyStates (S (x,y) l str s) =  removeNulls [up (S (x,y) l str s),down (S (x,y) l str s),left (S (x,y) l str s),right (S (x,y) l str s),collect (S (x,y) l str s)]

--- removeNulls function takes as input list of states and returns the list without Nulls.
removeNulls :: [MyState] -> [MyState]
removeNulls [] = []
removeNulls (Null:xs) = removeNulls xs
removeNulls (x:xs) = x:(removeNulls xs)

-- isGoal function takes as input a state, returns true if the input state has no more
-- mines to collect (the list of mines is empty), and false otherwise.
isGoal :: MyState -> Bool
isGoal (S (x,y) l str s) = if(l == []) then True else False

-- search function takes as input a list of states. It checks if the head of the input list
-- is a goal state, if it is a goal, it returns the head. Otherwise, it gets the next states
-- from the state at head of the input list, and calls itself recursively with the result of
-- concatenating the tail of the input list with the resulting next states.
search :: [MyState] -> MyState
search [] = Null
search (x:xs) | isGoal x =  x
              | otherwise = search (xs ++ (nextMyStates x))

-- constructSolution function takes as input a state and returns a set of strings representing actions
-- that the robot can follow to reach the input state from the initial state. The possible
-- strings in the output list of strings are only "up", "down", "left", "right", and
-- "collect".
constructSolution:: MyState ->[String]
constructSolution Null = []
constructSolution (S (x,y) l str s) =  (if(str/="") then ((constructSolution s) ++ [str]) else (constructSolution s))

-- solve function takes as input a cell representing the starting position of the robot,
-- a set of cells representing the positions of the mines, and returns a set of strings
-- representing actions that the robot can follow to reach a goal state from the initial
-- state
solve :: Cell -> [Cell] -> [String]
solve start mines = constructSolution (search ([S start mines "" Null]))