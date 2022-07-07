# hangman  

hangman command line game built in ruby  
if you don't have ruby installed you can try the game at https://replit.com/@AxtonSmith/hangman#.replit  

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
-Built method to compare the guess against the secret and save the current guesses  
-Add game logic to end the game when you win or lose  
-Fix guess accepting non alphabet characters and coerced all letters to downcase  
-Implement a save feature that serializes the current game state to JSON format  
-Built the logic to display and let user choose from one of the save files to load and play from  