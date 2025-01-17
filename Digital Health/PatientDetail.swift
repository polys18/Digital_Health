//
//  PatientDetail.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 15/01/2025.
//

import SwiftUI

// This is the view that displays patient information. the top wight of this view contains the
// addMedications button that can be used to perscribe medications to this patient
struct PatientDetailView: View {
    @Environment(PatientViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    let  patient: Patient
    @State private var showingAddMedication = false
    
    private var currentPatient: Patient {
        viewModel.patients.first { $0.medicalRecordNumber == patient.medicalRecordNumber } ?? patient
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)
                    
                    Text(currentPatient.nameAndAge())
                        .font(.title2.bold())
                    
                    Text("MRN: \(currentPatient.medicalRecordNumber)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            
            Section("Personal Information") {
                LabeledContent("Date of Birth") {
                    Text(currentPatient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))
                }
                
                LabeledContent("Age") {
                    Text("\(Calendar.current.dateComponents([.year], from: currentPatient.dateOfBirth, to: Date()).year ?? 0) years")
                }
            }
            
            Section("Physical Information") {
                LabeledContent("Height") {
                    Text(String(format: "%.1f cm", currentPatient.heightInCm))
                }
                
                LabeledContent("Weight") {
                    Text(String(format: "%.1f kg", currentPatient.weightInKg))
                }
                
                LabeledContent("Blood Type") {
                    Text(currentPatient.bloodType.rawValue)
                        .foregroundStyle(.red)
                }
            }
            
            Section("Active Medications") {
                if currentPatient.getCurrentMedications().isEmpty {
                    ContentUnavailableView {
                        Label("No Medications", systemImage: "pills.circle")
                    } description: {
                        Text("Add medications using the button at the top right")
                    }
                } else {
                    ForEach(currentPatient.getCurrentMedications(), id: \.name) { medication in
                        MedicationRowView(medication: medication)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddMedication = true
                } label: {
                    Image(systemName: "pills.circle.fill").font(.system(size: 24))
                }
                .accessibilityIdentifier("addMedicationButton")
            }
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label : {
//                    HStack {
//                        Image(systemName: "chevron.left")
//                        Text("back")
//                    }
//                    
//                }
//            }
        }
        .sheet(isPresented: $showingAddMedication) {
            NavigationStack {
                AddMedicationsView(patient: currentPatient)
                Text("Add Medication Form")
            }
        }
    }
}

struct MedicationRowView: View {
    let medication: Medication
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(medication.name)
                    .font(.headline)
                Spacer()
                Text("\(medication.dose)\(medication.unit)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.blue)
            }
            
            Text("\(medication.route) • \(medication.frequencyPerDay)x daily for \(medication.durationInDays) days strating \(medication.datePrescribed, style: .date)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PatientDetailView(
            patient: Patient(
                medicalRecordNumber: "MRN12345",
                firstName: "John",
                lastName: "Doe",
                dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!,
                height: 175,
                weight: 70,
                bloodType: .aPositive
            )
        )
    }
}
