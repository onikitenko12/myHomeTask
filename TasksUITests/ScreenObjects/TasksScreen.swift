//
//  Created by Oleksii Nikitenko on 7/12/2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class TasksScreen {
    let tasksScreen = XCUIApplication().navigationBars["Tasks"]
    let taskTable = XCUIApplication().tables
    let toolbarCompleteCancelButton = XCUIApplication().toolbars["Toolbar"].buttons.element(boundBy: 0)
    let toolbarSortingButton = XCUIApplication().toolbars["Toolbar"].buttons.element(boundBy: 1)
    
    let logoutButton = XCUIApplication().buttons["Logout"]
    let alertCancelButton = XCUIApplication().alerts.scrollViews.otherElements.buttons["Cancel"]
    let alertLogoutButton = XCUIApplication().alerts.scrollViews.otherElements.buttons["Logout"]
    
    let sleepTaskNestedScreen = XCUIApplication().navigationBars["Sleep"]
    let backToTasksNavigation = XCUIApplication().navigationBars["Sleep"].buttons["Tasks"]
    
    enum tasksNames{
        case Buy_milk
        case Change_tires
        case Dance
        case Pay_rent
        case Sleep
        case Close_eyes
        case Find_a_bed
        case Lie_down
        case Wait
    }
    
    func getNames(_ taskName: tasksNames) -> String{
        switch taskName {
        case .Buy_milk:
            return "Buy milk"
        case .Change_tires:
            return "Change tires"
        case .Dance:
            return "Dance"
        case .Pay_rent:
            return "Pay rent"
        case .Sleep:
            return "Sleep"
        case .Close_eyes:
            return "Close eyes"
        case .Find_a_bed:
            return "Find a bed"
        case .Lie_down:
            return "Lie down"
        case .Wait:
            return "Wait"
        }
    }
    
    func tapRandomTask() -> Bool {
        let randomInt = Int.random(in: 0..<5)
        taskTable.cells.element(boundBy: randomInt).tap()
        return taskTable.cells.element(boundBy: randomInt).images["cell_image_view"].value as! String == "Selected"
    }
    
    func tapTask(_ rowNumber: Int) -> Void {
        taskTable.cells.element(boundBy: rowNumber).tap()
    }
    
    func getTaskCheckBox(_ rowNumber: Int) -> XCUIElement {
        return taskTable.cells.element(boundBy: rowNumber).images["cell_image_view"]
    }
    
    func getTaskText(_ rowNumber: Int) -> String {
        return taskTable.cells.staticTexts.element(boundBy: rowNumber).label
    }
    
}
