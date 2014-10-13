Codeception-Starter-Kit
=======================

A starter kit for Codeception, complete with Selenium Web driver (including Chrome) 

What's included?
================
* Codeception testing framework for PHP (unit, functional and acceptance tests)
* Codeception Verify and Specify libraries for BDD style annotation of Unit tests
* Selenium web driver with the Chrome driver (note: only tested on Mac) for browser automation used with Acceptance tests
* BONUS - a script for automatically updating configs for different environements (e.g. dev and test)

How to install and configure it?
================================
* First clone the repo: git clone https://github.com/mitni455/Codeception-Starter-Kit/
* cd into /codecepetion-starter-kit or rename codeception (mv codecepetion-starter-kit codecpetion)
* Update your config files for the dev and test environments, including:
** codeception.yml.dev and codeception.yml.test
** tests/acceptance.suite.yml.dev and tests/acceptance.suite.yml.test
** tests/unit.suite.yml.dev and tests/unit.suite.yml.test

** note - functional not used for simplicity, but I could add that too

How to Running tests?
=====================
* Run the SuperLogical Tests script (./sl_tests.sh)
* Choose the environment you are running on. This will overwrite the *.yml configs with the *.yml.dev or *.yml.test appropriately
* This will run all the unit tests
* This will load selenium in the background and then run the acceptance tests

Good luck, email me on nick [at] superlogical [dot] org with any issues 

