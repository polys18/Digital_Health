//
//  PatientViewModel.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 16/01/2025.
//

import SwiftUI

// This class holds the patients list. It is accessed by the views and is the "grouns truth" patients list. Is also contains methods
// to modify the patiets list
@Observable
class PatientViewModel {
    var patients: [Patient] = []
    
    
    func addMedicationCentral(_ medication: Medication, to patient: Patient) throws {
        if let index = patients.firstIndex(where: { $0.medicalRecordNumber == patient.medicalRecordNumber }) {
            var updatedPatient = patients[index]
            try updatedPatient.prescribeMedication(medication)
            patients[index] = updatedPatient
        }
    }


    func addPatient(_ patient: Patient) {
        patients.append(patient)
    }
}
