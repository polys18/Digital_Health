//
//  BloodType.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation

// Enum of all possible blood types.
enum BloodType: String, CaseIterable {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+"
    case oNegative = "O-"
    
    // Returns a list of blood types that patient can donate blood to.
    func canDonateTo() -> [BloodType] {
        switch self {
        case .aPositive:
            return [BloodType.aPositive, BloodType.abPositive]
        case .aNegative:
            return [BloodType.aPositive, BloodType.abPositive, BloodType.aNegative, BloodType.abNegative]
        case .bPositive:
            return [BloodType.bPositive, BloodType.abPositive]
        case .bNegative:
            return [BloodType.bPositive, BloodType.abPositive, BloodType.bNegative, BloodType.abNegative]
        case .abPositive:
            return [BloodType.abPositive]
        case .abNegative:
            return [BloodType.abPositive, BloodType.abNegative]
        case .oPositive:
            return [BloodType.oPositive, BloodType.aPositive, BloodType.bPositive, BloodType.abPositive]
        case .oNegative:
            return [BloodType.oPositive, BloodType.oNegative, BloodType.aNegative, BloodType.aPositive, BloodType.bNegative, BloodType.bPositive, BloodType.abNegative, BloodType.abPositive]
        }
    }
    
    // Returns a List of blood types that can be donated to the patient.
    func canReceiveFrom() -> [BloodType] {
        switch self {
        case .aPositive:
            return [BloodType.aPositive, BloodType.aNegative, BloodType.oNegative, BloodType.oPositive]
        case .aNegative:
            return [BloodType.aNegative, BloodType.oNegative]
        case .bPositive:
            return [BloodType.bPositive, BloodType.bNegative, BloodType.oNegative, BloodType.oPositive]
        case .bNegative:
            return [BloodType.bNegative, BloodType.oNegative]
        case .abNegative:
            return [BloodType.abNegative, BloodType.oNegative, BloodType.aNegative, BloodType.aPositive]
        case.abPositive:
            return [BloodType.oPositive, BloodType.oNegative, BloodType.aNegative, BloodType.aPositive, BloodType.bNegative, BloodType.bPositive, BloodType.abNegative, BloodType.abPositive]
        case.oNegative:
            return [BloodType.oNegative]
        case.oPositive:
            return [BloodType.oPositive, BloodType.oNegative]
        }
    }
    
    var type: String {
        return self.rawValue
    }
}

extension BloodType: CustomStringConvertible {
    var description: String {
        return """
        BloodType: \(type)
        """
    }
}

