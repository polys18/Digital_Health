//
//  AddPatientForm.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 15/01/2025.
//

import SwiftUI

// This view is the form that is filled out to add a new patient. The patient information is
// collected and the patient is added to the list pf patients via the viewModel
struct AddPatientView: View {
    @Environment(PatientViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    //@Binding var patients: [Patient]
    @Binding var isPresented: Bool
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height: Double = 0
    @State private var weight: Double = 0
    @State private var selectedBloodType = BloodType.aPositive
    @State private var MRN: String = ""
    
    @State private var showingError = false
    @State private var errorMessage = ""
    
    private var isFormValid: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !MRN.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        height > 0 && weight > 0
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading) {
                        TextField("First Name", text: $firstName)
                            .textContentType(.givenName)
                            .accessibilityIdentifier("firstNameField")
                        
                        TextField("Last Name", text: $lastName)
                            .textContentType(.familyName)
                            .accessibilityIdentifier("lastNameField")
                    }
                }
            }
            
            Section {
                TextField("Medical Record Number", text: $MRN).accessibilityIdentifier("MRNField")
            }
            
            Section {
                DatePicker("Date of Birth",
                          selection: $dateOfBirth,
                          in: ...Date(),
                           displayedComponents: .date)
                .accessibilityIdentifier("dobPicker")
            }
            
            Section {
                VStack {
                    HStack {
                        Text("Height")
                        Spacer()
                        TextField("Height", value: $height, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("cm")
                            .foregroundStyle(.secondary)
                    }
                    
                    Slider(value: $height, in: 0...300, step: 1) {
                        Text("Height")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("300")
                    }
                    .accessibilityIdentifier("heightSlider")
                }
                
                VStack {
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("Weight", value: $weight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                        Text("kg")
                            .foregroundStyle(.secondary)
                    }
                    
                    Slider(value: $weight, in: 0...300, step: 0.1) {
                        Text("Weight")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("300")
                    }
                    .accessibilityIdentifier("weightSlider")
                }
            }
            
            Section {
                Picker("Blood Type", selection: $selectedBloodType) {
                    ForEach(BloodType.allCases, id: \.self) { bloodType in
                        Text(bloodType.rawValue)
                            .tag(bloodType)
                    }
                    .accessibilityIdentifier("bloodTypePicker")
                }
            }
        }
        .navigationTitle("Add Patient")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    addPatient()
                }
                .disabled(!isFormValid)
                .accessibilityIdentifier("confirmAddPatient")
            }
            
        }
        .alert("Invalid Input", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func addPatient() {
        guard isFormValid else {
            errorMessage = "Please fill in all required fields"
            showingError = true
            return
        }
        
        let newPatient = Patient(
            medicalRecordNumber: MRN,
            firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
            lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
            bloodType: selectedBloodType
        )
        
        viewModel.addPatient(newPatient)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddPatientView(
//            patients: .constant([]),
            isPresented: .constant(true)
        )
    }
}
