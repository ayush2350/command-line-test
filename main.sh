#!/bin/bash

# --- GLOBAL VAR DECLARATION START ---

TEST_SET=$1           # cmd line input: name of the file having questions
WAIT_TIME=1           # wait time between different user interface screens
WAIT_TIME_TEST=5      
WAIT_TIME_QUES=3      # wait time between each question
USER_DB="./users.db"  # user database file


# --- GLOBAL VAR DECLARATION OVER ---
# --- main_screen def start ---

main_screen () {

	# Main initial interface screen
	
	echo "Please Choose the Options:"
	echo "1. Sign In"
	echo "2. Sign Up"
	echo "3. Exit"
	
	read -p"Choice :" USER_OPTION 	
	
		
	if (($USER_OPTION  == 1)) || (($USER_OPTION  == 2)) || (($USER_OPTION  == 3))
	 then
		case $USER_OPTION in
			1)
				sign_in
			;;
			
			2)
				sign_up
			;;
			
			3)
				exit
			;;
		esac
				
	else
				
		echo " "
		echo "Warning: Please Choose Relevant Option."
		echo  "Redirecting..."
		
		while sleep $WAIT_TIME; do
			clear
			break
		done
		
		main_screen
	fi
}

# --- main_screen def over ---

# --- sign_up def start ---

sign_up () {
	
	
	if [[ -f "$USER_DB" ]]  # goes in IF only if users.db file exists
	then 
		while sleep $WAIT_TIME; do
			clear
			break
		done
		
		echo "My Command Line Test"
		echo "Sign Up Screen"
		echo ""
		read -p "Please choose your Username: " USER_NAME
		touch temp_users.db			# creating temporary username file
		cut -d= -f1 users.db > temp_users.db
						
		if grep -Fxq "$USER_NAME" temp_users.db  # check if username already ecists
		  then
			
			echo "The $USER_NAME already exists. Please Choose another username"
			echo "Redirecting..."
			sign_up
			
		else
			read_password     #
		fi
		rm -rf temp_users.db      # deleting temporary username file
	
	else
		touch users.db
		#echo "File Created"
		while sleep $WAIT_TIME; do
			clear
			break
		done
		
		echo "My Command Line Test"
		echo "Sign Up Screen"
		echo ""
		read -p "Please choose your Username: " USER_NAME
		touch temp_users.db			#creating temporary username file
		cut -d= -f1 users.db > temp_users.db
						
		if grep -Fxq "$USER_NAME" temp_users.db 
		  then
			
			echo "The $USER_NAME already exists. Please Choose another username"
			echo "Redirecting..."
			sign_up
			
		else
			read_password
		fi
		rm -rf temp_users.db      #deleting temporary username file
	fi
	
	echo "Redirecting ..."
	while sleep $WAIT_TIME; do
			clear
			break
	done
	main_screen	
}

# --- sign_up def End ---

# --- read_password def start ---
read_password () {

			read -s -p "Please Enter the Password: " USER_PASS1
			read -s -p "Please Re-enter the Password: " USER_PASS2
			
			if [[ $USER_PASS2 == $USER_PASS1 ]]
			 then 
			 	echo "Sign-Up Successful !"
			 	echo "$USER_NAME=$USER_PASS1" >> users.db
			 else 
			 	
			 	echo "."
			 	echo "."
			 	echo "Password Does not match. Please Try Again..."
			 	read_password
			 fi

}
# --- read_password def End ---



# --- sign_In_Screen def Start ---

sign_in_screen () {
	
	while sleep $WAIT_TIME; do
		clear
		break
	done
	
	echo "Please Choose the Options:"
	echo "1. Take Test"
	echo "2. View Your Test"
	echo "3. Exit"
	
	read -p"Choice :" USER_OPTION_SIGNIN 
	
	if (( $USER_OPTION_SIGNIN == 1)) || (($USER_OPTION_SIGNIN == 2)) || (($USER_OPTION_SIGNIN  == 3 ))
	 then
		case $USER_OPTION_SIGNIN in
			1)
				take_test
			;;
			
			2)
				view_test
			;;
			
			3)
				exit
			;;
		esac
	fi
}

# --- sign_In_Screen def End ---

# --- sign_In def Start ---

sign_in () {
	
	while sleep $WAIT_TIME; do
		clear
		break
	done
	
	if [[ -f "$USER_DB" ]]
	then
		echo "Please Enter Your Credentials"
		read -p "Username: " USER_NAME_SignIn

		touch temp1_users.db			# creating temporary username file
		cut -d= -f1 users.db > temp1_users.db
						
		if grep -Fxq "$USER_NAME_SignIn" temp1_users.db  # check if username already ecists
		  then
			read -s -p "Password: " USER_PASS_SignIn		  
		else
			echo "Please Sign Up before Signing In! Redirecting ..." # goes into else block if username
 			while sleep $WAIT_TIME; do
			clear
				break
			done	
			sign_up			
		fi
		rm -rf temp1_users.db

	
	
		if  grep -q "${USER_NAME_SignIn}=${USER_PASS_SignIn}" $USER_DB # check if username and pass entered are correct
		then
	 		echo -e "\nSignIn Successfull....."
	 		
	 		if [[ -d $USER_NAME_SignIn ]]; then
	 			echo "" > /dev/null
	 		else
	 			mkdir "$USER_NAME_SignIn" > /dev/null
	 			
	 		fi
	 		
			sign_in_screen
		else
	
			echo "You Entered Wrong Credentials! Redirecting ..." # If either password or username is wrong user is returned back to sign in screen
			while sleep $WAIT_TIME; do
			clear
				break
			done
			sign_in
		fi
		
	fi
}


# --- sign_In def End ---


# --- take_test def Start ---
take_test () {
        
        CURR_DATE=$(date)
        DATE_TIME=$(date +%Y_%m_%d_%H_%M_%S)
        CURR_LOG=(${USER_NAME_SignIn}_${DATE_TIME}_result.log)

	touch "./$USER_NAME_SignIn/$CURR_LOG"
	
	echo "NOTE: You have to answer each question within 5 seconds! Test is starting..."
	while sleep $WAIT_TIME_TEST; do
	clear
		break
	done
	
	NUM_QUES=$( wc -l "$TEST_SET" | cut -d " " -f1 )
	RES_SCORE=0
	MAX_SCORE=$NUM_QUES

	for (( c=1; c<=$NUM_QUES; c++ ))
		do 

			sed -n "$c"p "$TEST_SET" | cut -d "," -f1 
			sed -n "$c"p "$TEST_SET" | cut -d "," -f1 >> ./$USER_NAME_SignIn/$CURR_LOG
			
			sed -n "$c"p "$TEST_SET" | cut -d "," -f2
			sed -n "$c"p "$TEST_SET" | cut -d "," -f2 >> ./$USER_NAME_SignIn/$CURR_LOG
			
			sed -n "$c"p "$TEST_SET" | cut -d "," -f3
			sed -n "$c"p "$TEST_SET" | cut -d "," -f3 >> ./$USER_NAME_SignIn/$CURR_LOG
			
			sed -n "$c"p "$TEST_SET" | cut -d "," -f4
			sed -n "$c"p "$TEST_SET" | cut -d "," -f4 >> ./$USER_NAME_SignIn/$CURR_LOG
			
			echo ""
			echo "Enter Choice: "
			read -t $WAIT_TIME_TEST USER_ANS
			
			echo "Your Choice: $USER_ANS" >> ./$USER_NAME_SignIn/$CURR_LOG
			echo "" >> ./$USER_NAME_SignIn/$CURR_LOG
			
			sed -n "$c"p "$TEST_SET" | cut -d "," -f5 | grep -oP '(?<=ans=\[)[abcd](?=\])' > temp_test_ans.txt
			
			#grep -oP '(?<=ans=\[)[a-d](?=\])' #regex to match the correct option
			
			CORRECT_ANS=$(head -n 1 temp_test_ans.txt)

			if [[ "$USER_ANS" == "$CORRECT_ANS" ]] 
			then
				((RES_SCORE=RES_SCORE+1))

			fi
			
			REM_QUES=$((NUM_QUES- c))
			if [[ $REM_QUES != 0 ]]
			then
				echo ""
				echo "Total Questions: $NUM_QUES | Remaining: $REM_QUES"
				echo "Next question will be visible in $WAIT_TIME_QUES seconds! Be Ready..."
				while sleep $WAIT_TIME_QUES; do
				clear
					break
				done			
		         
		         else
		         	
		         	echo "" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "///////////////////////////////////" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "/" >> ./$USER_NAME_SignIn/$CURR_LOG

		         	echo "/ MARKS OBTAINED: $RES_SCORE  ||  MAXIMUM MARKS: $MAX_SCORE" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "/ TEST TAKEN @ $CURR_DATE" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "/" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "//////////////////////////////////" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	echo "" >> ./$USER_NAME_SignIn/$CURR_LOG
		         	
		         	
		         	clear
		         	echo "Thanks for giving the test. You can view the current test results in $CURR_LOG file"
		         	rm -rf temp_test_ans.txt
				while sleep $WAIT_TIME_QUES; do
				clear
					break
				done	
				sign_in_screen	         	
		         fi
		done

	
	

}



# --- take_test def END ---


# --- view_test def Start ---
view_test() {


	 		
if [[ "$( ls -A $USER_NAME_SignIn )" ]]; then

	 echo "Please choose the test file you want to view: "
	 #echo "Exists" 
	 find ./$USER_NAME_SignIn/ -type f | sed 's/^..//' | nl > temp_tests_taken.txt
	 cat temp_tests_taken.txt
	 read -p"Enter your choice: " VIEW_TEST_CHOICE
	 sed -n "$VIEW_TEST_CHOICE"p "temp_tests_taken.txt" | cut -f2 > temp2_tests_taken.txt
	 LOG_CHOICE=$(head -n 1 temp2_tests_taken.txt)
	 #echo $LOG_CHOICE
	 vi "$LOG_CHOICE"
	 rm -rf temp_tests_taken.txt temp2_tests_taken.txt
	 sign_in_screen
else
	 echo "You have not given any tests. Please give a test first!"		
	 echo "Redirecting to the previous MENU..."
		
		while sleep $WAIT_TIME; do
		clear
			break
		done
		
	 sign_in_screen	 	
fi

}

# --- view_test def END ---


#Function Calling
main_screen
