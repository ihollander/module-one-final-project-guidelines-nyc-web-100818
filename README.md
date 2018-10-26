# Harry Potter Dating / Dueling Game

Welcome to the unofficial Harry Potter Dating / Dueling Game! This is a group project for the 10/08/18 Module Project at Flatiron.

The goal of this game was to explore CLI capabilities using ActiveRecord and Ruby.

## The Game

Your goal in this game is to conquer the school of Hogwarts - either through love or power! You begin as a new student being sorted into a house, bright eyed and bushy tailed. Every round, you'll wander the hallways, encountering familiar characters from the Harry Potter world.

Through the CLI you'll engage these characters, either in lighthearted flirting or dangerous wizard battle. After each encounter, the leaderboard will update and you'll see how close you are to victory and who to watch out for.

### Setup Instructions

To play this game, first clone the files to your local hard drive. Afterwards,
navigate to the file and run rake db:migrate followed by rake db:seed.

Once done, run the program from the file bin/run.rb and enjoy yourself!

### Gameplay Video

TODO - Add link

## API's Used

This game makes use of two Harry Potter APIs.

The first is http://hp-api.herokuapp.com/ which made use of their characters database.

The second is https://www.potterapi.com/ which has detailed lists of EVERYTHING. We used this specifically for its extensive list of spells.

## Challenges

We built this project over the course of 3 days and faced a few difficult challenges.

Firstly, this was the first group project any of us had done on GitHub and getting
used to regular pushes and branching presented a few issues. After a few messy commits
we started to understand exactly how to create a useful workflow and communicated
about our commits and branches.

Secondly, our file structure ended up being messy since we didn't delineate exact
roles for files at the beginning. We tried to get around this with flowcharts and
short production meetings. In the end even after hours of heavy refactoring, we're
still aware of ways we can improve this.
