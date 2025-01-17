//
//  Patient.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation

enum PatientError: Error {
    case duplicateMedication(String)
}

//This is the struct that represents patient information.
struct Patient: Equatable, Hashable {
    let medicalRecordNumber: String
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    var heightInCm: Double
    var weightInKg: Double
    var bloodType: BloodType
    private(set) var medications: [Medication]
    
    init(medicalRecordNumber: String,
         firstName: String,
         lastName: String,
         dateOfBirth: Date,
         height: Double,
         weight: Double,
         bloodType: BloodType,
         medications: [Medication] = []) {
        
        self.medicalRecordNumber = medicalRecordNumber
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.heightInCm = height
        self.weightInKg = weight
        self.bloodType = bloodType
        self.medications = medications
    }
    
    // Function that returns the name and age of the patient based on their birthday
    func nameAndAge() -> String {
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
        return "\(lastName), \(firstName) (\(age))"
    }
    
    // Function that returns the medications the patient is taking sorted by perscription date
    func getCurrentMedications() -> [Medication] {
        return medications.filter { $0.isStillInUse() }.sorted { $0.datePrescribed > $1.datePrescribed }
    }
    
    // Function that adds medication to patients medication list. Throws error if medication is repeated
    mutating func prescribeMedication(_ newMedication: Medication) throws {
        if getCurrentMedications().contains(where: {
            $0.name == newMedication.name
        }) {
            throw PatientError.duplicateMedication(newMedication.name)
        }
        medications.append(newMedication)
    }
}

extension Patient: CustomStringConvertible {
    var description: String {
        return """
        Patient: \(nameAndAge())
        MRN: \(medicalRecordNumber)
        Blood Type: \(bloodType)
        Height: \(heightInCm) cm
        Weight: \(weightInKg) kg
        Active Medications: \(getCurrentMedications())
        """
    }
}
