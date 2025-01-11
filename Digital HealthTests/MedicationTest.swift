//
//  MedicationTest.swift
//  Digital HealthTests
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation
import Testing
@testable import Digital_Health

struct MedicationTests {
    let testDate = Date()
    
    @Test("Medication initializes with correct values")
    func testMedicationInitialization() {
        let medication = Medication(
            name: "Aspirin",
            datePrescribed: testDate,
            dose: 25.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 2,
            durationInDays: 7
        )
        
        #expect(medication.name == "Aspirin")
        #expect(medication.dose == 25.0)
        #expect(medication.unit == "mg")
        #expect(medication.route == "oral")
        #expect(medication.frequencyPerDay == 2)
        #expect(medication.durationInDays == 7)
    }
    
    @Test("Current medication shows as still in use")
    func testActiveMedication() {
        let medication = Medication(
            name: "Aspirin",
            datePrescribed: testDate,
            dose: 25.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 2,
            durationInDays: 7
        )
        
        #expect(medication.isStillInUse())
    }
    
    @Test("Expired medication shows as not in use")
    func testExpiredMedication() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        let medication = Medication(
            name: "Aspirin",
            datePrescribed: pastDate,
            dose: 25.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 2,
            durationInDays: 7
        )
        
        #expect(!medication.isStillInUse())
    }
}
