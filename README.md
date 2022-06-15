# minesweeper-robot
In this project we were asked to implement the AI module for a minesweeper robot in
Haskell. The environment in which the robot operates is an 4 × 4 grid of cells. Initially,
a cell on the grid is either empty, contains the robot, or contains a mine. The robot can
move in all four directions and is able to collect a mine only if it is in the same cell as the
mine. The program will take as input the initial position of the robot and the positions
of all of the mines. The objective of the AI module is to compute a sequence of actions
that the robot can follow in order to go to all the mines and collect them. Below is an
example grid.

![Screenshot from 2022-06-15 02-37-02](https://user-images.githubusercontent.com/72989304/173712331-8f9b0064-e891-4180-85ed-4a926a81b950.png)

The robot R starts at (3,0) while the mines are at (2,2) and (1,2). One possible generated
sequence of actions is:
["up","right","right","collect","up","collect"]
