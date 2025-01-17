//
//  AddMedications.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 15/01/2025.
//

import SwiftUI

// This view is the form that gets filled out to perscribe a new medication to a patient.
// The new medication is added via the view model
struct AddMedicationsView: View {
    @Environment(PatientViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    let patient: Patient
    
    @State private var medicationName: String = ""
    @State private var medicationDose: Double = 0
    @State private var medicationPerscriptionDate: Date = Date()
    @State private var medicationRoute: String = ""
    @State private var medicationFrequency: Int = 0
    @State private var medicationDuration: Int = 0
    @State private var medicationUnit: String = ""
    
    @State private var showingError = false
    @State private var errorMessage = ""
    
    private var isFormValid: Bool {
        !medicationName.isEmpty &&
        medicationDose > 0 &&
        !medicationUnit.isEmpty &&
        !medicationPerscriptionDate.description.isEmpty &&
        !medicationRoute.isEmpty &&
        medicationFrequency > 0 &&
        medicationDuration > 0
    }
    
    // Find the patient in the "ground truth" list of patients of the view model given the copy of the patient passed into the veiw
    private var currentPatient: Patient {
        viewModel.patients.first { $0.medicalRecordNumber == patient.medicalRecordNumber } ?? patient
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Medication Details")) {
                VStack {
                    Image(systemName: "pills")
                    TextField("Medication Name", text: $medicationName)
                        .accessibilityIdentifier("medicationNameField")
                    HStack {
                        HStack {
                            Text("Dose: ")
                            TextField("Medication Dose", value: $medicationDose, format: .number)
                                .accessibilityIdentifier("medicationDoseField")
                        }
                        
                        TextField("Unit", text: $medicationUnit)
                            .accessibilityIdentifier("medicationUnitField")
                    }
                    HStack {
                        Text("Frequency Per Day: ")
                        TextField("Frequency Per Day", value: $medicationFrequency, format: .number)
                            .accessibilityIdentifier("medicationFrequencyField")
                    }
                    HStack {
                        Text("Duration in Days: ")
                        TextField("Duration in Days", value: $medicationDuration, format: .number)
                            .accessibilityIdentifier("medicationDurationField")
                    }
                    TextField("Route", text: $medicationRoute)
                        .accessibilityIdentifier("medicationRouteField")
                    
                    DatePicker("Perscription Date",
                               selection: $medicationPerscriptionDate,
                              in: ...Date(),
                              displayedComponents: .date)
                    .accessibilityIdentifier("medicationDateField")
                }
            }
        }
        .navigationTitle("Add Medication")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityIdentifier("cancelAddMedication")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    addMedication()
                }
                .disabled(!isFormValid)
                .accessibilityIdentifier("confirmAddMedication")
            }
        }
        .alert("Invalid Input", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func addMedication() {
        guard isFormValid else {
            errorMessage = "Please fill in all required fields"
            showingError = true
            return
        }
        
        let newMedication = Medication(name: medicationName,
                                       datePrescribed: medicationPerscriptionDate,
                                       dose: medicationDose,
                                       unit: medicationUnit,
                                       route: medicationRoute,
                                       frequencyPerDay: medicationFrequency,
                                       durationInDays: medicationDuration
                                       
                                       
        )
        do {
            try viewModel.addMedicationCentral(newMedication, to: currentPatient)
        }catch{
            errorMessage = "Medication is already prescribed for patient"
            showingError = true
        }
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddMedicationsView(patient: Patient(medicalRecordNumber: "MRN12345",
                                             firstName: "John",
                                             lastName: "Doe",
                                             dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!,
                                             height: 175,
                                             weight: 70,
                                             bloodType: .aPositive,
                                             medications: []))
    }
}

