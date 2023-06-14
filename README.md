# lua_programming

Instructions
This will be an object oriented Lua program with the following behavior:

At the program's start, it will prompt for the name of a company.
The program will attempt to load the company's data from the file "name.dat". For example, if you enter "acme" it will try to load from "acme.dat". If the file does not exist, the program will create a blank one.
The program will then present a menu that lets the user do the following:
View/Add Employees
View/Add Sales and Customers
Exit
Upon program exit, it will save the contents of the company database to the file specified above.
IMPORANT
You need to match the I/O in the sample runs very closely in order to receive full credit fo this program. I tried to make the grading script as generous as possible, but you are still being graded by an automated system because of the sheer size of this class. Pay close attention to keywords in the prompts, especially "choice" and "menu". These are what the script looks for when processing your file. Also, note that the input expectations must match exactly. Pay close attention to when the menu systems use letters and numbers. The sample run listed below shows the exact test which the script runs. Be sure you can match that IO scheme!

Lua Notes and Resources
First, here are some resources to help you learn lua:

Lua in One VideoLinks to an external site.
Learn Lua in Y MinutesLinks to an external site.
Lua Offical Homepage (I am using lua 5.3)Links to an external site.
Second, lua is not, strictly speaking, an object oriented language. It does have the raw materials of performing object oriented programming, however. I recommend that you also read this article: Trick Lua into becoming an object-oriented languageLinks to an external site.. If you follow the recommendations in that article, you shoudl be able to implement the object hierarchy shown below. That being said, you will need  to modify the design slightly as lua has nothing like iterators. 
