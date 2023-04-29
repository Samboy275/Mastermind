# Mastermind
_this is a part of the odin project projects_


## Overview
__Mastermind__ is a game in which there are two players one is __code breaker__ which has to guess a correct four colored out of 6 colors the code is made by the __code maker__  with each guess the code maker will rate the guess giving the correct color place a "perfect" rating and giving the color that exists in the code an "exists" rating the code breaker has to guess the right code within 12 tries if they fail the code maker wins.
___
## Structure
the game files are separated in four files:
* ### main.rb
    * this file contains the game instance in which it starts the game. this file needs to be run to start the game it acts as the main entry to the game loop.

* ### game_module.rb
    * the game module contains the main game loop and handles player input and instance instantiation of code_maker and code_breaker objects.

* ### code_breaker.rb
    * code breaker file contains the code breaker class which contains game logic in case the player is the code breaker and the CodeBreakerAI which has the game logic if the computer is the code breaker using a simplified version of the swaszek algorithm to guess the right code.

* ### code_maker.rb
    * same as code breaker files but contains game logic for computer and player mainly handles code generation and rating guesses.


to start the game simply run this command in the game files directory

    ruby main.rb
