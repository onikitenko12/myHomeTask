//
//  Created by Oleksii Nikitenko on 7/12/2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

final class TasksUITests: BaseTest {
    
    func testLogging_empty_email_and_password() {
        XCTAssertTrue(isLoggingScreenVisible() , "Logging screen not visible")
        XCTAssertFalse(logging.loggingButton.isEnabled , "Login button should not be enabled")
    }
    
    func testLogging_incorrect_email_empty_password() {
        XCTAssertTrue(isLoggingScreenVisible() , "Logging screen not visible")
        logging.typeAndEnterEmail(Text: incorrectEmail)
        XCTAssertFalse(logging.loggingButton.isEnabled , "Login button should not be enabled")
    }

    func testLogging_incorrect_email_correct_password() {
        XCTAssertTrue(isLoggingScreenVisible() , "Logging screen not visible")
        logging.typeAndEnterEmail(Text: incorrectEmail)
        logging.typeAndEnterPassword(Text: password)
        XCTAssertTrue(logging.loggingButton.isEnabled , "Login button should be enabled")
        logging.loggingButton.tap()
        XCTAssertTrue(logging.alertMessage.element.waitForExistence(timeout: timeToWait) , "Incorrect email / password message not appered")
        logging.alertOkButton.tap()
        XCTAssertTrue(isLoggingScreenVisible() , "Logging screen not visible")
    }
    
    func testLogging_correct_email_empty_password() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        XCTAssertFalse(logging.loggingButton.isEnabled , "Login button should not be enabled")
    }
    
    func testLogging_correct_email_and_password() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        XCTAssertTrue(logging.loggingButton.isEnabled , "Login button should be enabled")
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
    }
    
    func testRelogging_zero_tasks_finished() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.logoutButton.tap()
        XCTAssertTrue(tasks.alertLogoutButton.waitForExistence(timeout: timeToWait) , "Can't logout")
        tasks.alertLogoutButton.tap()
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
    }
    
    func testRelogging_all_tasks_finished() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.toolbarCompleteCancelButton.tap()
        tasks.logoutButton.tap()
        XCTAssertTrue(tasks.alertLogoutButton.waitForExistence(timeout: timeToWait) , "Can't logout")
        tasks.alertLogoutButton.tap()
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
    }
    
    func testCancelLogout() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.logoutButton.tap()
        XCTAssertTrue(tasks.alertCancelButton.waitForExistence(timeout: timeToWait) , "Cancel button not visible")
        tasks.alertCancelButton.tap()
        XCTAssertFalse(tasks.alertCancelButton.waitForExistence(timeout: timeToWait) , "Alert should be closed")
        XCTAssert(tasks.tasksScreen.exists , "Tasks screen not visible")
    }
    
    func testSelectRandomCheckbox() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        XCTAssertTrue(tasks.tapRandomTask() , "Selected task not completed , checkbox status not changed")  // Selected Image / Not selected Image
        
    }
    
    func testCompleteUncompleteAllTasks() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        // Complete all tasks one by one
        tasks.tapTask(0)
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(1)
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(2)
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(3)
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(4)
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        // Uncomplete all tasks one by one
        tasks.tapTask(4)
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(3)
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(2)
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(1)
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(0)
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
    }
    
    func testCompleteUncompleteAllTasksWithButton() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        // Complete all tasks with button tap
        tasks.toolbarCompleteCancelButton.tap()
        XCTAssertEqual(tasks.toolbarCompleteCancelButton.label , "Cancel All" , "Button name not changed after tap")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        // Uncomplete all tasks with button tap
        tasks.toolbarCompleteCancelButton.tap()
        XCTAssertEqual(tasks.toolbarCompleteCancelButton.label , "Complete All" , "Button name not changed after tap")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Not selected" , "Incorrect checkbox status for selected task")
    }
    
    func testCompleteAllNotFinishedTasksWithButton() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        XCTAssertTrue(tasks.tapRandomTask() , "Selected task not completed , checkbox status not changed")
        // Complete all not finished tasks with button tap
        tasks.toolbarCompleteCancelButton.tap()
        XCTAssertEqual(tasks.toolbarCompleteCancelButton.label , "Cancel All" , "Button name not changed after tap")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Selected" , "Incorrect checkbox status for selected task")
    }
    
    func testCompleteSleepTask() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.tapTask(3)
        tasks.taskTable.buttons["More Info"].tap()
        XCTAssertTrue(tasks.sleepTaskNestedScreen.waitForExistence(timeout: timeToWait) , "Sleep subscreen not visible")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for selected task")
    }
    
    func testCompleteSleepSubtasks() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox default status for sleep task")
        tasks.taskTable.buttons["More Info"].tap()
        XCTAssertTrue(tasks.sleepTaskNestedScreen.waitForExistence(timeout: timeToWait) , "Sleep subscreen not visible")
        tasks.tapTask(0)
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(1)
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(2)
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.tapTask(3)
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for selected task")
        tasks.backToTasksNavigation.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not navigated to Tasks")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for sleep task with all completed subtasks")
    }
    
    func testCompleteAllTasksFromSleepWithButton() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox default status for sleep task")
        tasks.taskTable.buttons["More Info"].tap()
        XCTAssertTrue(tasks.sleepTaskNestedScreen.waitForExistence(timeout: timeToWait) , "Sleep subscreen not visible")
        // Complete all tasks with button tap
        tasks.toolbarCompleteCancelButton.tap()
        XCTAssertEqual(tasks.toolbarCompleteCancelButton.label , "Cancel All" , "Button name not changed after tap")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for checked task")
        tasks.backToTasksNavigation.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not navigated to Tasks")
        // Check that sleep task completed , rest tasks remain uncompleted
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Selected" , "Incorrect checkbox status for sleep task")
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
    }
    
    func testTasksSortByNames() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.toolbarSortingButton.tap()
        // Check that tasks checkboxes statuses not changed
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(4).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        // Check order of tasks after sorting
        XCTAssertEqual(tasks.getTaskText(0), tasks.getNames(.Buy_milk), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(1), tasks.getNames(.Change_tires), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(2), tasks.getNames(.Dance), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(3), tasks.getNames(.Pay_rent), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(4), tasks.getNames(.Sleep), "Incorrect order of tasks in table")
    }
    
    func testSleepSubTasksSortByNames() {
        XCTAssertTrue(isLoggingScreenVisible())
        logging.typeAndEnterEmail(Text: correctEmail)
        logging.typeAndEnterPassword(Text: password)
        logging.loggingButton.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not redirected to Tasks, Logging not succesfull")
        tasks.taskTable.buttons["More Info"].tap()
        XCTAssertTrue(tasks.sleepTaskNestedScreen.waitForExistence(timeout: timeToWait) , "Sleep subscreen not visible")
        tasks.toolbarSortingButton.tap()
        // Check that sleep subtasks checkboxes statuses not changed
        XCTAssertEqual(tasks.getTaskCheckBox(0).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(1).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(2).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        XCTAssertEqual(tasks.getTaskCheckBox(3).value as! String, "Not selected" , "Incorrect checkbox status for checked task")
        // Check order sleep subtasks after sorting
        XCTAssertEqual(tasks.getTaskText(0), tasks.getNames(.Close_eyes), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(1), tasks.getNames(.Find_a_bed), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(2), tasks.getNames(.Lie_down), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(3), tasks.getNames(.Wait), "Incorrect order of tasks in table")
        // Check sorting type saved when move back on app screens
        tasks.backToTasksNavigation.tap()
        XCTAssertTrue(tasks.tasksScreen.waitForExistence(timeout: timeToWait) , "User not navigated to Tasks")
        tasks.taskTable.buttons["More Info"].tap()
        XCTAssertTrue(tasks.sleepTaskNestedScreen.waitForExistence(timeout: timeToWait) , "Sleep subscreen not visible")
        XCTAssertEqual(tasks.getTaskText(0), tasks.getNames(.Close_eyes), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(1), tasks.getNames(.Find_a_bed), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(2), tasks.getNames(.Lie_down), "Incorrect order of tasks in table")
        XCTAssertEqual(tasks.getTaskText(3), tasks.getNames(.Wait), "Incorrect order of tasks in table")
    }
}
