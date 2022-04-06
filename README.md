# Instructions
1. Install python if not installed in your machine
2. Checkout this repo
3. Create a virtual environment python -m venv venv (using command line)
4. Enter virtual environment source venv/bin/activate (Darwin) or venv\Scripts\activate.bat (Windows)
5. Install requirements: pip install -r requirements.txt
6. Go to the project folder from command line e.g. cd /Users/Something/Projects/EarthlinkTestProject
7. Check your chrome browser's version and download the chromedriver from site: https://chromedriver.chromium.org/downloads
8. Put the chromedriver file inside EarthlinkTestProject/Driver folder
9. Run command:  
	i) For SwagLab:  robot --outputdir Report/SwagLab/ TestCases/SwagLab.robot
	ii) For Gmail: 	 robot --outputdir Report/Gmail/ TestCases/GmailLogin.robot
10. After completion,open report.html to see the detail report.

NOTE: For Gmail test cases to run, you need to setup environmemt for Appium automation with Robot Framework e.g. Appium, Android studio, Android sdk, Java etc.
