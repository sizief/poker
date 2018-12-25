[![CircleCI](https://circleci.com/gh/sizief/poker/tree/master.svg?style=svg)](https://circleci.com/gh/sizief/poker/tree/master)


# Poker

Very simple poker hand evaluation program


## Run and play!

- Download the project

`git clone git@github.com:sizief/poker.git`

- Go to poker project directory (`cd poker`)

- Run interactive shell 

`iex -S mix`

- Pass the poker hand to the program and see the result!

`Poker.run("Alice 2S 3H 4S 8C 6H", "Bob 2S 2H 4S 8C 6H") #=> {"black", "one pair"}`