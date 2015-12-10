//
//  VoltageUITests.swift
//  VoltageUITests
//
//  Created by Josh Rosenzweig & Adrian Picahrdo on 12/2/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import XCTest
@testable import Voltage

class VoltageUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //UI Test for Make from front page, without scrolling(front page)
    func testChooseBugattiVeyron164(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
       
        //Assert statement returns true if Bugatti can be chosen
        XCTAssert(tablesQuery.staticTexts["Bugatti"].exists)
        let bugattiStaticText = tablesQuery.staticTexts["Bugatti"]
        bugattiStaticText.tap()
        
        // Assert statement, returns true if the only
        // model,Veyron 16.4 is displayed
        XCTAssert(tablesQuery.staticTexts["Veyron 16.4"].exists)
        
    }
    
    //UI Test for Make, Model and Year with scrolling
    func testChooseHondaCRV2000(){
        
        let tablesQuery = XCUIApplication().tables
        
        //Assert statement returns true if Honda exists
        XCTAssert(tablesQuery.staticTexts["Honda"].exists)
        tablesQuery.staticTexts["Honda"].tap()
        
        //Assert statement returns true if Honda CR-V exists
        XCTAssert(tablesQuery.staticTexts["CR-V"].exists)
        tablesQuery.staticTexts["CR-V"].tap()
        
        //Assert statement returns true if Honda CR-V 2000 exists
        XCTAssert(tablesQuery.staticTexts["2000"].exists)
        
    }
    
    // UI Test for the make back button
    func testChooseAcuraBackAlfaRomeo(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Acura"].tap()
        
        //Assert statement, returns true if the Back make button exists
        XCTAssert(app.buttons["< Make"].exists)
        app.buttons["< Make"].tap()
        tablesQuery.staticTexts["Alfa Romeo"].tap()
        
        //Assert statements for all Alfa Romeo models
        XCTAssert(tablesQuery.cells.staticTexts["4C"].exists)
        XCTAssert(tablesQuery.cells.staticTexts["4C Spider"].exists)
        XCTAssert(tablesQuery.cells.staticTexts["Giulia"].exists)
        
    }
    
    // UI Test for the model back button using BMW
    func testChooseBMW1sBackBMW2s(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["BMW"].tap()
        tablesQuery.staticTexts["1 Series"].tap()
        
        //Assert statement, returns true if the back model button exists
        XCTAssert(app.buttons["< Model"].exists)
        app.buttons["< Model"].tap()
        tablesQuery.staticTexts["2 Series"].tap()
        
        //Assert statement, returns true if the back model button continues
        //to exist
        XCTAssert(app.buttons["< Model"].exists)
    }
    
    // UI Test for the year back button using Bentley Arnage
    func testChooseBentArn2000BackBentArn2001(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Bentley"].tap()
        tablesQuery.staticTexts["Arnage"].tap()
        tablesQuery.staticTexts["2001"].tap()
        
        //Assert statement, returns true if the year back button exists
        XCTAssert(app.buttons["< Year"].exists)
        app.buttons["< Year"].tap()
        tablesQuery.staticTexts["2002"].tap()
        
        //Assert statement, returns true if the year back button continues
        //to exist after choosng a new yr
        XCTAssert(app.buttons["< Year"].exists)
    }
    
    //UI Test for Continue button after Make, Model, and Year have been chosen
    func testContinue(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        
        //Assert statement, returns true if the continue button is available
        //after choosing a Make, Model, and Year
        XCTAssert(app.buttons["Continue"].exists)
    }
    
    //UI Test for the Info button after the continue button is selected
    func testInfoButton(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if Info button appears after the
        //continue button is selected
        XCTAssert(app.buttons["Info"].exists)
    }
    
    //UI Test for Back button after Info is selected
    func testInfoBack(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["Info"].tap()
        
        //Assert statement, returns true if back button exists
        XCTAssert(app.buttons["Back"].exists)
    }
    
    //UI Test for Info after Back button is selected
    func testInfoBackInfo(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["Info"].tap()
        app.buttons["Back"].tap()
        
        //Assert statement, returns true if back button exists
        XCTAssert(app.buttons["Info"].exists)
        
    }
    
    //UI Test for charging station button
    func testChagingStation(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if charging station button exists
        XCTAssert(app.buttons["CharginStation"].exists)
        
    }
    
    //UI Test for Map button
    func testMap(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if Map button exists
        XCTAssert(app.buttons["Maps"].exists)
        
    }
    
    //UI Test for Accesories button
    func testAccesories(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if Accessories button exists
        XCTAssert(app.buttons["Accessories"].exists)
        
    }
    
    //UI Test for Certified Mechanic button
    func testMech(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if Machanic button exists
        XCTAssert(app.buttons["Mechanic"].exists)
        
    }
    
    //UI Test for Gas station button
    func testGasStation(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        
        //Assert statement, returns true if gas station button exists
        XCTAssert(app.buttons["GasStation"].exists)
        
    }
    
    //UI Test for charging station back button
    func testChargingStationBack(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["CharginStation"].tap()
        
        //Assert statement, returns true if charging station button exists
        XCTAssert(app.buttons["Back"].exists)
        
    }
    
    //UI Test for Map back button
    func testMapBack(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["Maps"].tap()
        
        //Assert statement, returns true if Map back button exists
        XCTAssert(app.buttons["Back"].exists)
        
    }
    
    //UI Test for Accesories backbutton
    func testAccesoriesBack(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["Accessories"].tap()
        
        //Assert statement, returns true if Accessories back button exists
        XCTAssert(app.buttons["Back"].exists)
        
    }
    
    //UI Test for Gas station back button
    func testGasStationBack(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["AM General"].tap()
        tablesQuery.staticTexts["Hummer"].tap()
        tablesQuery.staticTexts["1998"].tap()
        tablesQuery.staticTexts["Hard Top 2dr SUV AWD"].tap()
        app.buttons["Continue"].tap()
        app.buttons["GasStation"].tap()
        
        //Assert statement, returns true if gas station back button exists
        XCTAssert(app.buttons["Back"].exists)
        
    }
    
    //UI Tests main page after random assortment of commands
    func testRandomCommands(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Infiniti"].tap()
        tablesQuery.staticTexts["M56"].tap()
        tablesQuery.staticTexts["2011"].tap()
        app.buttons["< Year"].tap()
        app.buttons["< Model"].tap()
        tablesQuery.staticTexts["G Convertible"].tap()
        tablesQuery.staticTexts["2013"].tap()
        tablesQuery.staticTexts["IPL 2dr Convertible (3.7L 6cyl 7A)"].tap()
        app.buttons["Continue"].tap()
        app.buttons["Info"].tap()
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        app.buttons["CharginStation"].tap()
        backButton.tap()
        app.buttons["Settings"].tap()
        tablesQuery.buttons["Back"].tap()
    
        //Assert statement, returns true if all 7 buttons on the main page exist after
        //going back and forth through pages and ending on the main page
        XCTAssert(app.buttons["Info"].exists)
        XCTAssert(app.buttons["CharginStation"].exists)
        XCTAssert(app.buttons["Maps"].exists)
        XCTAssert(app.buttons["Accessories"].exists)
        XCTAssert(app.buttons["Mechanic"].exists)
        XCTAssert(app.buttons["GasStation"].exists)
        //first time Settings button is being tested
        XCTAssert(app.buttons["Settings"].exists)
        
    }
    
}
