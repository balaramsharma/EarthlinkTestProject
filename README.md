# Instructions
1. Install python if not installed in your machine
2. Checkout this repo
3. Create a virtual environment python -m venv venv (using command line)
4. Enter virtual environment source venv/bin/activate (Darwin) or venv\Scripts\activate.bat (Windows)
5. Go to the project folder from command line e.g. cd /Users/Something/Projects/EarthlinkTestProject
6. Install requirements: pip install -r requirements.txt
7. Check your chrome browser's version and download the chromedriver from site: https://chromedriver.chromium.org/downloads
8. Put the chromedriver file inside EarthlinkTestProject/Driver folder
9. Run command:  robot --outputdir Report/ TestCases/SwagLab.robot
10. After completion,open report.html to see the detail report.
