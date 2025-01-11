//
//  BloodTypeTest.swift
//  Digital HealthTests
//
//  Created by Polycarpos Yorkadjis on 10/01/2025.
//

import Foundation
import Testing
@testable import Digital_Health


struct BloodTypeTests {
    
    @Test("Blood type raw values match expected strings")
    func testRawValues() {
        #expect(BloodType.aPositive.rawValue == "A+")
        #expect(BloodType.aNegative.rawValue == "A-")
        #expect(BloodType.bPositive.rawValue == "B+")
        #expect(BloodType.bNegative.rawValue == "B-")
        #expect(BloodType.abPositive.rawValue == "AB+")
        #expect(BloodType.abNegative.rawValue == "AB-")
        #expect(BloodType.oPositive.rawValue == "O+")
        #expect(BloodType.oNegative.rawValue == "O-")
    }
    
    @Test("Blood type string representation is correct")
    func testStringRepresentation() {
        #expect(BloodType.aPositive.description == "BloodType: A+")
        #expect(BloodType.bNegative.description == "BloodType: B-")
        #expect(BloodType.abPositive.description == "BloodType: AB+")
        #expect(BloodType.oNegative.description == "BloodType: O-")
    }
    
    @Test("Type function works")
    func testTypeProperty() {
        #expect(BloodType.aPositive.type == "A+")
        #expect(BloodType.bNegative.type == "B-")
        #expect(BloodType.abPositive.type == "AB+")
        #expect(BloodType.oNegative.type == "O-")
    }
    
    @Test("O- can donate to all blood types")
    func testONegativeUniversalDonor() {
        let oNegative = BloodType.oNegative
        let canDonateTo = oNegative.canDonateTo()
        
        // Should be able to donate to all blood types
        #expect(canDonateTo.count == 8)
        #expect(canDonateTo.contains(.aPositive))
        #expect(canDonateTo.contains(.aNegative))
        #expect(canDonateTo.contains(.bPositive))
        #expect(canDonateTo.contains(.bNegative))
        #expect(canDonateTo.contains(.abPositive))
        #expect(canDonateTo.contains(.abNegative))
        #expect(canDonateTo.contains(.oPositive))
        #expect(canDonateTo.contains(.oNegative))
    }
    
    @Test("AB+ can receive from all blood types")
    func testABPositiveUniversalRecipient() {
        let abPositive = BloodType.abPositive
        let canReceiveFrom = abPositive.canReceiveFrom()
        
        // Should be able to receive from all blood types
        #expect(canReceiveFrom.count == 8)
        #expect(canReceiveFrom.contains(.aPositive))
        #expect(canReceiveFrom.contains(.aNegative))
        #expect(canReceiveFrom.contains(.bPositive))
        #expect(canReceiveFrom.contains(.bNegative))
        #expect(canReceiveFrom.contains(.abPositive))
        #expect(canReceiveFrom.contains(.abNegative))
        #expect(canReceiveFrom.contains(.oPositive))
        #expect(canReceiveFrom.contains(.oNegative))
    }
    
    @Test("A+ donation compatibility is correct")
    func testAPositiveDonationRules() {
        let aPositive = BloodType.aPositive
        let canDonateTo = aPositive.canDonateTo()
        
        // A+ can only donate to A+ and AB+
        #expect(canDonateTo.count == 2)
        #expect(canDonateTo.contains(.aPositive))
        #expect(canDonateTo.contains(.abPositive))
    }
    
    @Test("B- donation compatibility is correct")
    func testBNegativeDonationRules() {
        let bNegative = BloodType.bNegative
        let canDonateTo = bNegative.canDonateTo()
        
        // B- can donate to B+, B-, AB+, AB-
        #expect(canDonateTo.count == 4)
        #expect(canDonateTo.contains(.bPositive))
        #expect(canDonateTo.contains(.bNegative))
        #expect(canDonateTo.contains(.abPositive))
        #expect(canDonateTo.contains(.abNegative))
    }
    
    @Test("A- receiving compatibility is correct")
    func testANegativeReceivingRules() {
        let aNegative = BloodType.aNegative
        let canReceiveFrom = aNegative.canReceiveFrom()
        
        // A- can receive from A- and O-
        #expect(canReceiveFrom.count == 2)
        #expect(canReceiveFrom.contains(.aNegative))
        #expect(canReceiveFrom.contains(.oNegative))
    }
    
    @Test("O+ receiving compatibility is correct")
    func testOPositiveReceivingRules() {
        let oPositive = BloodType.oPositive
        let canReceiveFrom = oPositive.canReceiveFrom()
        
        // O+ can receive from O+ and O-
        #expect(canReceiveFrom.count == 2)
        #expect(canReceiveFrom.contains(.oPositive))
        #expect(canReceiveFrom.contains(.oNegative))
    }
}
