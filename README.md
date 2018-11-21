# MPQueueBasedTicTacToe
A simple implementation of a multiplayer queue system using firebase and Github. 
This was done as an excercise in order to gain experience using simple databases. 

The queue itself will always pop the top value once two players are found and should only in edge cases have more than one player in it (as any other player will be a match)


Trying it out:
You'll need to build the pod file, as well as place your own GoogleService-Info.plist in the file itself.


Known Issues:
Needs better documentaiton,
Currently the lack of a timeout allows for dead players to exist in the queue, this leads to games where one player does not play forcing the other to leave,
Requires a firebase .plist file.
Has some issue with fast inputs
