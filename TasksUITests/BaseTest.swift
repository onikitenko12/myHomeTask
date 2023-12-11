//
//  Created by Oleksii Nikitenko on 7/12/2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class BaseTest:XCTestCase {
    let app = XCUIApplication()
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let logging = Logging()
    let tasks = TasksScreen()
    
    // Constants
    let timeToWait = TestData().timeToWait
    let incorrectEmail = TestData().incorrectEmail
    let correctEmail = TestData().correctEmail
    let password = TestData().password
    
    
    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app.launch()
        app.launchArguments = ["-StartFromCleanState", "YES"] // Would be great that dev added parsing such arguments;)
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
    
    override class func tearDown() {
        // Delete app after Test Suit run
        BaseTest().deleteMyApp()
        super.tearDown()
    }
    
    func deleteMyApp() {
        let bundleDisplayName = "Tasks"
        
        let icon = springboard.icons[bundleDisplayName]
        if icon.exists {
            icon.press(forDuration: 1)
            
            let buttonRemoveApp = springboard.buttons["Remove App"]
            if buttonRemoveApp.waitForExistence(timeout: 5) {
                buttonRemoveApp.tap()
            } else {
                XCTFail("Button \"Remove App\" not found")
            }
            
            let buttonDeleteApp = springboard.alerts.buttons["Delete App"]
            if buttonDeleteApp.waitForExistence(timeout: 5) {
                buttonDeleteApp.tap()
            } else {
                XCTFail("Button \"Delete App\" not found")
            }
            
            let buttonDelete = springboard.alerts.buttons["Delete"]
            if buttonDelete.waitForExistence(timeout: 5) {
                buttonDelete.tap()
            } else {
                XCTFail("Button \"Delete\" not found")
            }
        }
    }
    
    func isLoggingScreenVisible() -> Bool {
        if tasks.logoutButton.exists {
            tasks.logoutButton.tap()
            XCTAssertTrue(tasks.alertLogoutButton.waitForExistence(timeout: 2) , "Can't logout")
            tasks.alertLogoutButton.tap()
        }
        return logging.emailTextField.waitForExistence(timeout: 2)
    }
}
