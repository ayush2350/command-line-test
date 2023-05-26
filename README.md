# Command Line Test Project using BASH
The project consists of a BASH script that allows users to register and the registered user to login. After login user can take a
test on shell and can view the test logs as well.

The question bank should be given by the user at the time of running the script.

## Functions Implemented

Project has been implemented  using n functions:
* main_screen
* sign_up
* read_password
* sign_in_screen
* sign_in
* take_test
* view_test

### main_screen() function
Provides a prompt for the user to:
* Signin
* Signup
* Exit

### sign_up() function
* Checks for the "users.db" file in the current directory, if the file is not there then it creates it.
* As soon as the user enters the desired user name, it checks if a user with the same username exists or not.
* If the desired username doesn't exist in the database then read_password() is called.

### read_password() function
* When called, it asks the user to enter the desired password 2 times to make sure the entered passwords match both time

### sign_in_screen() function
Provides a prompt for the user to:
* Take Test
* View Test
* Exit

### sign_in() function
* Asks for the username and checks if the username exists in the database or not.
* If the username exists then it asks for password otherwise it redirects the user for sign_up

### take_test() function
* This function prints the question from the question bank one-by-one
* It waits for a specified delay in the script for the user to give the answer else it moves on to the next question
* It creates the log file which records the question, the answer provided by the user, time & data of starting the test & Marks Obtained

### view_test() function
* This function prompts the user for all the stored test logs for the signed-in user
* User can choose and view the test-log of his choice

