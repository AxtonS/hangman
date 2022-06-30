# hangman  

hangman command line game built in ruby  

## plan  

-use google-10000-english-no-swears as a dictionary file  
-randomly load a word between 5 and 12 characters long from the dictionary file  
-display a stick figure to represent the number of incorrect guesses left  
-display the correct letters and positions of the random word after each guess 
-allow player to submit a case insensitive letter and then update display between turns or display loss if out of guesses  
-allow player to save the game on each turn  
-when the program first loads allow player to choose a save file  

## progress  

-Loaded the dictionary file and created an array out of the words between 5 and 12 letters long then used sample method to choose a random word  
-Built method for displaying the hangman with remaining guesses  