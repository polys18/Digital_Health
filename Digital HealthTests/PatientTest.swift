//
//  PatientTest.swift
//  Digital HealthTests
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation
import Testing
@testable import Digital_Health


struct PatientTests {
    var testDate = Date()
    var testPatient = Patient(
        medicalRecordNumber: "MRN123",
        firstName: "John",
        lastName: "Doe",
        dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!,
        height: 175,
        weight: 70,
        bloodType: .aPositive
    )
    
    
    @Test("Patient initializes with correct values")
    func testPatientInitialization() {
        #expect(testPatient.medicalRecordNumber == "MRN123")
        #expect(testPatient.firstName == "John")
        #expect(testPatient.lastName == "Doe")
        #expect(testPatient.heightInCm == 175)
        #expect(testPatient.weightInKg == 70)
        #expect(testPatient.bloodType == .aPositive)
        #expect(testPatient.medications.isEmpty)
    }
    
    @Test("Patient name and age format correctly")
    func testNameAndAge() {
        #expect(testPatient.nameAndAge() == "Doe, John (30)")
    }
    
    @Test("Patient can receive new medication")
    mutating func testPrescribeMedication() throws {
        let medication = Medication(
            name: "Aspirin",
            datePrescribed: testDate,
            dose: 25.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 2,
            durationInDays: 7
        )
        
        do {
            try testPatient.prescribeMedication(medication)
        } catch {
            print(error)
        }
        
        #expect(testPatient.medications.count == 1)
        #expect(testPatient.getCurrentMedications().count == 1)
    }
    
    @Test("Patient cannot receive duplicate medication")
    mutating func testDuplicateMedication() throws {
        let medication = Medication(
            name: "Aspirin",
            datePrescribed: testDate,
            dose: 25.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 2,
            durationInDays: 7
        )
                
        do {
            try testPatient.prescribeMedication(medication)
        } catch let error as PatientError {
            switch error {
            case .duplicateMedication(let name):
                #expect(name == "Aspirin")
            }
        }
    }
    
    @Test("Current medications only shows current medications that the patient is still taking")
    mutating func testGetCurrentMedications() throws {
        // Add an expired medication
        let pastDate = Calendar.current.date(byAdding: .day, value: -10, to: testDate)!
        let expiredMed = Medication(
            name: "ExpiredMed",
            datePrescribed: pastDate,
            dose: 10.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 1,
            durationInDays: 5
        )
        
        // Add a current medication
        let currentMed = Medication(
            name: "CurrentMed",
            datePrescribed: testDate,
            dose: 20.0,
            unit: "mg",
            route: "oral",
            frequencyPerDay: 1,
            durationInDays: 10
        )
        
        try testPatient.prescribeMedication(expiredMed)
        try testPatient.prescribeMedication(currentMed)
        
        let currentMeds = testPatient.getCurrentMedications()
        #expect(currentMeds.count == 1)
        #expect(currentMeds.first?.name == "CurrentMed")
    }
}
