//
//  Digital_HealthUITests.swift
//  Digital HealthUITests
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import XCTest

final class Digital_HealthUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddPatientWorks() {
        let addPatientsButton = app.buttons["addPatientButton"]
        XCTAssert(addPatientsButton.exists)
        addPatientsButton.tap()
            
        let firstNameField = app.textFields["firstNameField"]
        let lastNameField = app.textFields["lastNameField"]
        let MRNField = app.textFields["MRNField"]
            
        let heightSlider = app.sliders["heightSlider"]
        let weightSlider = app.sliders["weightSlider"]
        let addPatientButton = app.buttons["confirmAddPatient"]
            
        let heightExists = heightSlider.waitForExistence(timeout: 2)
        XCTAssertTrue(heightExists, "Height slider should exist")
            
        print("Height Slider:", heightSlider.debugDescription)
            
        firstNameField.tap()
        firstNameField.typeText("John")
            
        lastNameField.tap()
        lastNameField.typeText("Doe")
            
        MRNField.tap()
        MRNField.typeText("skata")
        app.keyboards.buttons["Return"].tap()
            
        heightSlider.adjust(toNormalizedSliderPosition: 0.5)
        sleep(1)
        weightSlider.adjust(toNormalizedSliderPosition: 0.4)
            
        addPatientButton.tap()
            
        let patientCell = app.staticTexts["Doe, John (0)"]
        XCTAssert(patientCell.exists)
    }
    
    
    func testAddMedication() throws {
            testAddPatientWorks()
            app.staticTexts["Doe, John (0)"].tap()
            
            app.buttons["addMedicationButton"].tap()
            
            let nameField = app.textFields["medicationNameField"]
            let doseField = app.textFields["medicationDoseField"]
            let unitField = app.textFields["medicationUnitField"]
            let routeField = app.textFields["medicationRouteField"]
            let frequencyField = app.textFields["medicationFrequencyField"]
            let durationField = app.textFields["medicationDurationField"]
            
            XCTAssert(nameField.exists)
            XCTAssert(doseField.exists)
            XCTAssert(routeField.exists)
            XCTAssert(frequencyField.exists)
            XCTAssert(durationField.exists)
            
            nameField.tap()
            nameField.typeText("Aspirin")
            
            doseField.tap()
            doseField.typeText("25")
    
            unitField.tap()
            unitField.typeText("mg")
        
            
            routeField.tap()
            routeField.typeText("Oral")
            
            frequencyField.tap()
            frequencyField.typeText("2")
            
            durationField.tap()
            durationField.typeText("7")
            
            app.buttons["confirmAddMedication"].tap()
            
            XCTAssert(app.staticTexts["Aspirin"].exists)
        }
        
        func testCancelAddMedication() throws {
            testAddPatientWorks()
            
            app.staticTexts["Doe, John (0)"].tap()
            
            app.buttons["addMedicationButton"].tap()
            
            app.buttons["cancelAddMedication"].tap()
            
            XCTAssert(app.staticTexts["No Medications"].exists)
        }
        
        func testMedicationValidation() throws {
            testAddPatientWorks()
            app.staticTexts["Doe, John (0)"].tap()
            
            app.buttons["addMedicationButton"].tap()
            
            app.buttons["confirmAddMedication"].tap()
            
            XCTAssert(app.textFields["medicationNameField"].exists)
        }
        
        func testSearch() throws {
            let addPatientsButton = app.buttons["addPatientButton"]
            addPatientsButton.tap()
                
            let firstNameField = app.textFields["firstNameField"]
            let lastNameField = app.textFields["lastNameField"]
            let MRNField = app.textFields["MRNField"]
            let heightSlider = app.sliders["heightSlider"]  // Slider is directly accessible
            let weightSlider = app.sliders["weightSlider"]
            let savePatientButton = app.buttons["confirmAddPatient"]
            
            firstNameField.tap()
            firstNameField.typeText("John")
            lastNameField.tap()
            lastNameField.typeText("Doe")
            MRNField.tap()
            MRNField.typeText("MRN234")
            app.keyboards.buttons["Return"].tap()
            heightSlider.adjust(toNormalizedSliderPosition: 0.6)
            sleep(1)
            weightSlider.adjust(toNormalizedSliderPosition: 0.3)
            savePatientButton.tap()
            
            addPatientsButton.tap()
            firstNameField.tap()
            firstNameField.typeText("John")
            lastNameField.tap()
            lastNameField.typeText("Adams")
            MRNField.tap()
            MRNField.typeText("MRN678")
            app.keyboards.buttons["Return"].tap()
            heightSlider.adjust(toNormalizedSliderPosition: 0.5)
            sleep(1)
            weightSlider.adjust(toNormalizedSliderPosition: 0.4)
            savePatientButton.tap()
            
            let searchField = app.searchFields["Search by last name"]
            XCTAssert(searchField.exists)
                
            searchField.tap()
            searchField.typeText("Ad")
                
            XCTAssert(app.staticTexts["Adams, John (0)"].exists)
            XCTAssertFalse(app.staticTexts["Doe, John (0)"].exists)
                
            searchField.buttons["Clear text"].tap()
                
            sleep(1)
            XCTAssert(app.staticTexts["Doe, John (0)"].exists)
            XCTAssert(app.staticTexts["Adams, John (0)"].exists)
    }
}
