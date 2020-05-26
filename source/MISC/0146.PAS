{
LOU'S MAZE ALGORITHM

We all want to create mazes at some time or other; I devised one effective
maze-generating algorithm.  I will be discussing a rectangular maze, but
it should be possible to use the principles I describe to create mazes of
different shapes.  I will also be discussing mazes with no "islands" in
them or any other features that would make it impossible to walk the
entire maze with one hand against the wall.

First of all, you need to create a two-dimensional array to describe the
maze territory.  Each grid element should, at the very least, contain
a boolean to indicate whether or not there is a wall at that spot.  Your
grid should have *ODD* dimensions, so that you can maintain a wall /
corridor / wall / corridor / wall / etc. pattern.  Now flag the outside
edges of the grid as "walls", and the entire interior as non-walls.

Next, select an entrance and exit to the maze.  The entrance and exit
will be on the edges of the grid, but with *EVEN* coordinates (so they
will open up into a corridor and not a wall).  Flag the entrance and
exit as non-walls.

Now select several spots on the edges of the grid, from which to
start generating the insides of the maze.  All these spots must have
*ODD* coordinates, so that they will not ever grow into corridors.
What we will be doing is growing walls from these "seed points" to
fill the maze.  (Each seed point is a record that should just consist
of an x and y coordinate, indicating a maze location to grow a wall
segment from.)

You will need to set up a large array to accommodate a great number of
seeds: every time you add a wall segment, you add seed points.  By my
guesstimates, the maximum number of seeds you're ever going to need is:
(mazeheight - 3)*(mazewidth - 3) / 2.

Keep executing this loop until you run out of seeds:

  - Randomly select a seed.  Extend the wall in some valid direction
    from this seed point, by turning into walls the grid locations one
    unit and two units away from the seed.  To prevent the maze from
    closing off at any point, DO NOT EXTEND A WALL TO ANY POINT THAT
    IS ALREADY MARKED AS A WALL!  (With this rule, you never close off
    the maze; you simply complicate the path from beginning to end.)

  - Remove this seed.  It's done its job.

  - Add three seed points at this new location.  (The assumption is
    that the wall could grow in three directions from this new point;
    if you want to be more exacting, you can add as many seeds as there
    are directions that the wall could extend from that point.  It
    really doesn't matter much, except for the possibility of running
    out of seed point array elements if you always add 3.)

  - Seed maintenance: go through your list of seeds and eliminate any
    seeds that cannot extend in any valid direction.

Once you are out of seeds, the maze is complete.  You are done.
------------------------------------------------------------------------

As for traversing a maze: you are likely aware of the "right-hand rule"
for walking a maze, by starting at the entrance, keeping your right hand
on the wall at all times, and following your nose.  Sooner or later, you
will get to the exit.  I will suggest how to implement the right-hand
rule.  First, you will always need to keep track of what direction you're
walking.  Now to simulate the right hand on the wall: check the grid
location in the direction just clockwise to the direction you're walking.
In other words, if you're walking to the right, check the downward
direction.  Is there a wall there?  If not, go in that direction.  But if
there is a wall there, keep checking directions going counter-clockwise
until you find a spot that isn't a wall.  (Using the same example, if you
couldn't go down, check right, then up, then left until you find a
non-wall.)  As soon as you find a non-wall, go in that direction.
------------------------------------------------------------------------

There are probably all sorts of ways to solve a maze, but here is the
approach I use.  First of all, you will need to associate another
boolean variable with each maze location, indicating whether or not
you've passed that spot already while trying to solve the maze.  (Think
of leaving a trail of bread crumbs and you have the right idea.)  Set
all your "bread crumbs" to false.  Now start at the beginning of the
maze, and walk the maze via the right-hand rule.  Whenever you move to
a new location, check to see if there's a bread crumb there already.  If
there is not, put one there, *and also in the location you were just at*.
If there is already a bread crumb there, remove it, *and also remove the
bread crumb from the location you were just at*.  When you finally reach
the exit, the only bread crumbs remaining, will comprise the solution.
(All that bit about "the location you were just at", keeps bread crumbs
from appearing improperly at corners and dead ends.)
}