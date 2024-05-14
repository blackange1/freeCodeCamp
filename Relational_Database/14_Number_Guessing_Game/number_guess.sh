#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c" 

SELECT_NUM() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
    read NUMBER
    RE='^[0-9]+$'
    if [[ $NUMBER =~ $RE ]]
    then
      (( NUMBER_OF_GUESSES++ ))
      if [ $NUMBER -lt $SECRET_NUMBER ]
      then
        SELECT_NUM "It's lower than that, guess again:"
      else
        if [ $NUMBER -gt $SECRET_NUMBER ]
        then
          SELECT_NUM "It's higher than that, guess again:"
        else
          echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        fi
      fi
    else
      SELECT_NUM "That is not an integer, guess again:"
    fi
  fi
}


echo Enter your username:
read USERNAME

DATA_USER=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'") 

R_MIN=1
R_MAX=1000

SECRET_NUMBER=$(($RANDOM%($R_MAX-$R_MIN+1)+$R_MIN))
NUMBER_OF_GUESSES=0

if ! [[ -z $DATA_USER ]]
then
  echo "$DATA_USER" | while read ID BAR NAME BAR GAMES_PLAYED BAR BEST_GAME
  do
    echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
  SELECT_NUM "Guess the secret number between 1 and 1000:"
    
else
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  SELECT_NUM "Guess the secret number between 1 and 1000:"
  RES=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, 1000)")
fi

DATA_USER=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'") 
echo "$DATA_USER" | while read ID BAR NAME BAR GAMES_PLAYED BAR BEST_GAME
do
  RES=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED + 1 WHERE user_id=$ID")

  if [ $BEST_GAME -gt $NUMBER_OF_GUESSES ]
  then
    BEST_RES=$($PSQL "UPDATE users SET best_game=$NUMBER_OF_GUESSES WHERE user_id=$ID")
  fi
done