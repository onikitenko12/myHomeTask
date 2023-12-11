## Greetings %username% !

This is a quick manual on what we expect from you during performing the test task.

This will be a simple app that contains two features: Login & Checklist.

* First of all, get to know with the application under test, build the test app and check out its possibilities and bugs. 

* Second of all, we need to evaluate your qa manual background, so create down below:
 - short testplan 
 - list of the testcases
 - list of discovered issues
 
* Third of all, write test automation according test automation purposes  

* And fourth of all, push the whole project to github.com and notice us with a link to your repo on completion. 

Please reachout Yuliia (yvolkova@readdle.com) if you have any questions.

## Good Luck!
* p.s. Do not tamper codebase of application

#YOUR TASK STARTS HERE: 


# TEST PLAN: 

- Environment:
    OS iOS 17 latest 
    devices iPhone Pro/Pro Max , iPad mini latest , iPad Pro (11-inch , 12.9-inch)

- What parts of app will be tested:
    a. Login and Logout of application (email/password validation)
    b. Tasks checklist
    c. Sorting 
    d. Alerts
    e. UI/UX (Lock/Unlock , App orientation - Vertical/Horizontal)

- Additional check app Accessibility support (Bold/Large text)

- Features not to be tested:
    a. Testing on the Production
    b. Localizations testing
    c. Performance testing
    d. Updating testing
    e. User registration


# LIST OF TEST CASES: 
// Only summaries of tests: e.g. 
    Logging 
- Perform login with empty email and password field 
- Perform login with incorrect entered email (password field empty) 
- Perform login with incorrect entered email (password entered) 
- Perform login with correct entered email (password field empty)
- Perform login with correct entered email (correct password entered)
- Perform relogin after logout (No tasks are finished)
- Perform relogin after logout (All tasks finished)
- Cancel logout from app

    Tasks checklist
- Select/Unselect random task checkbox
- Selecte all task checkboxes
- Select/Unselect all tasks with 'Complete all'/'Cancel all' button
- Select all not finished tasks with 'Complete all' button when some tasks were already completed 
- Complete/Cancel 'Sleep' checkbox
- Complete/Cancel 'Sleep' nested checklist checkboxes
- Complete/Cancel 'Sleep' nested checklist with 'Complete all'/'Cancel all' button
- Sort Tasks checklist 
- Sort 'Sleep' sub tasks 




# LIST OF DISCOVERED ISSUES:
// Only summaries of bug reports: e.g.
- Login can be performed with any entered password 
- Error when login after logout (no tasks were finished before logout)'
- Unexpected task completed on checkbox tap
- Unexpected task uncompleted on checkbox tap
- 'Complete all' button does not change to 'Cancel all' when all tasks selected one by one
- 'Complete all' button does not change to 'Cancel all' when tap button (some checkboxes selected)
- 'Cancel all' button button does not change to 'Complete all' when all tasks deselected one by one
- 'Sleep' stats does not change to not finished when unfinish random nested checkbox 
- 'Sorting by Name' reversed to default when moving back and forth from Tasks to 'Sleep' nested checklist
- 'Sorting by Name' button unexpectedly selects all checkboxes
- Can't restore default sorting method
