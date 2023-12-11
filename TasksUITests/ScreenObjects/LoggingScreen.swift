//
//  Created by Oleksii Nikitenko on 7/12/2023.
//  Copyright © 2023 Cultured Code. All rights reserved.
//

import XCTest

class Logging {
    let emailTextField: XCUIElement = XCUIApplication().textFields["password-text-field"]
    let passwordTextField: XCUIElement = XCUIApplication().secureTextFields["Password"]
    let loggingButton: XCUIElement = XCUIApplication().buttons["login-button"]
    let alertMessage: XCUIElementQuery = XCUIApplication().alerts["Error"].scrollViews.otherElements
    let alertOkButton: XCUIElement = XCUIApplication().alerts["Error"].scrollViews.otherElements.buttons["Ok"]
    
    func typeAndEnterEmail(Text:String) -> Void {
        emailTextField.tap()
        emailTextField.typeText(Text)
        XCUIApplication().buttons["Return"].tap()
    }
    
    func typeAndEnterPassword(Text:String) -> Void {
        passwordTextField.tap()
        passwordTextField.typeText(Text)
        XCUIApplication().buttons["Return"].tap()
    }
}
