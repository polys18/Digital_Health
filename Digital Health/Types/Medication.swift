//
//  Medication.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation

// A struct that contains information about medication that was perscribes to the patient.
struct Medication {
    let name: String
    let datePrescribed: Date
    let dose: Double
    let unit: String
    let route: String
    let frequencyPerDay: Int
    let durationInDays: Int
    
    init(name: String, datePrescribed: Date, dose: Double, unit: String, route: String, frequencyPerDay: Int, durationInDays: Int) {
        
        self.name = name
        self.datePrescribed = datePrescribed
        self.dose = dose
        self.unit = unit
        self.route = route
        self.frequencyPerDay = frequencyPerDay
        self.durationInDays = durationInDays
    }
    
    // Returns true if patient is still taking medication
    func isStillInUse() -> Bool {
        let endDate = Calendar.current.date(byAdding: .day, value: durationInDays, to: datePrescribed) ?? datePrescribed
        let today = Date()
        if today >= datePrescribed && today <= endDate {
            return true
        } else {
            return false
        }
    }
}

// Extension protocol for string representation.
extension Medication: CustomStringConvertible {
    var description: String {
        return """
        Medication: \(name)
        Prescribed: \(datePrescribed)
        Dose: \(dose)\(unit)
        Route: \(route)
        Frequency: \(frequencyPerDay) times per day
        Duration: \(durationInDays) days
        """
    }
}
