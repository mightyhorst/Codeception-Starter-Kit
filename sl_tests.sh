#!/bin/bash

clear
SPACE=$'\n\n========================'
GAP=$'========================'


read -p "Which environment are you on? (d for Dev | t for Test | c for cancel) " RESP


if [ "$RESP" = "c" ]; then
  echo "later bro."
  exit 0
fi 

# --------- Codeception Configs --------------
echo "$SPACE Update Codeception Configs $GAP"

if [ "$RESP" = "d" ]; then
  echo "Hi There fellow developer friend. Preparing your test configs now..." 
  
  # echo "$SPACE TESTS $GAP"
  echo "[1] Updating the Codeception config (codeception.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/codeception.yml.dev /var/www/html/admin/_superlogical/codeception/codeception.yml
  
  echo "[2] Updating the Codeception Acceptance Tests config (acceptance.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/tests/acceptance.suite.yml.dev /var/www/html/admin/_superlogical/codeception/tests/acceptance.suite.yml
  
  echo "[3] Updating the Codeception Unit Tests config (unit.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/tests/unit.suite.yml.dev /var/www/html/admin/_superlogical/codeception/tests/unit.suite.yml
  
  
elif [ "$RESP" = "t" ]; then
  echo "Welcome to the test environment. Preparing your test configs now..."  
  
  echo "[1] Updating the Codeception config (codeception.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/codeception.yml.test /var/www/html/admin/_superlogical/codeception/codeception.yml
  
  echo "[2] Updating the Codeception Acceptance Tests config (acceptance.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/tests/acceptance.suite.yml.test /var/www/html/admin/_superlogical/codeception/tests/acceptance.suite.yml
    
  echo "[3] Updating the Codeception Unit Tests config (unit.yml) ..."
  cp -f /var/www/html/admin/_superlogical/codeception/tests/unit.suite.yml.test /var/www/html/admin/_superlogical/codeception/tests/unit.suite.yml

elif [ "$RESP" = "p" ]; then
  echo "Welcome to the production environment. No tests will be run in this environment..." 
        
else
  echo "I don't understand: $RESP"
fi







# --------- Run tests --------------
if [ "$RESP" = "p" ]; then
	echo "Great. Since you're on the production server can you please click around and make sure nothing's broken and login to the CMS, blog and so on to make sure that that is working correctly. Happy coding!"
	
else
	
	
	# --------- Unit tests --------------
	echo "$SPACE Unit Tests $GAP"
	read -p "Do you want to run your unit tests now? (y/n)" UNIT_TEST_RESP
	
	if [ "$UNIT_TEST_RESP" = "y" ]; then 
	
		echo "Changing directories and Running unit tests (from admin/_superlogical/codeception/tests/unit) now..."
		php codecept.phar run unit --steps --debug
		
	else
		echo "OK, please run them before patching the production server though ... "
	fi
	
	
	
	
	
	# --------- Acceptance tests --------------
	echo "$SPACE Acceptance Tests $GAP"
	read -p "Do you want to run your acceptance tests now? (y/n)" ACCEPTANCE_TEST_RESP
	
	if [ "$ACCEPTANCE_TEST_RESP" = "y" ]; then 
	
		echo "Running unit tests (from admin/_superlogical/codeception/tests/acceptance) now..."

		cd selenium/		
		# java -Dwebdriver.chrome.driver=./chromedriver -jar /var/www/html/admin/_superlogical/codeception/selenium/sel.jar & 
		java -Dwebdriver.chrome.driver=chromedriver -jar sel.jar > /dev/null & 
		
		echo "Running webserver .... please wait 5 secs to boot up and the Acceptance tests will run automatically... "
		sleep 5
		cd ..
		php codecept.phar run acceptance --steps
		
		killall java
		
	else
		echo "OK, please run them before moving to the production server though. Preferably on local dev bfore moving to test environment ... "
	fi
	
	
	
fi	