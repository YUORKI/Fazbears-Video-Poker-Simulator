Lets quickly explain how to import you save files to the mod.

Go to %APPDATA%\Roaming\MMFApplications, and open up the files in there and 
copy and past a variable (line of text, like level=0 ) that is in on the file, and paste it on to a text file in the mods folder
(we go over which file belongs to which later).

Here's a example on how you will copy and past the content of the file

MMFApplications file ---------- Mod file
level=0
beatgame=1                      beatgame=0
beat6=1                         beat6=0
beat7=0                         beat7=0

VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

MMFApplications file ---------> Mod file
level=0 -----------X---------->
beatgame=1 -------------------> beatgame=1
beat6=1 ----------------------> beat6=1
beat7=0 ----------------------> beat7=0

(THE TEXT MUST MATCH THE EQUIVILANT OF WHAT IS ON THE MOD FILE OR ELSE IT WON'T WORK)
(also if you don't have a save file or you just filling funny that day you can just change the value of the file, I don't care,
as long you don't delete it its fine)

------------------------------------------

Heres the list of what file corresponds to what game
FNAF 1:
freddy -> FNAF1.txt

UCN:
CN -> UCN.txt

