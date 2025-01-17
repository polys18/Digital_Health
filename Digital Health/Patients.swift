//
//  Patients.swift
//  Digital Health
//
//  Created by Polycarpos Yorkadjis on 15/01/2025.
//

import SwiftUI

// This view lists the registered patients in alphabetical order (sorted on last name).
// Patients can be clicked to go to their patientDetail view. There is also a button
// to add new patients and a search bar to search for patients, by their last name.
struct PatientListView: View {
    @Environment(PatientViewModel.self) private var viewModel
    //@State private var patients: [Patient] = []
    @State private var showingAddPatient = false
    @State private var navigationPath = NavigationPath()
    @State private var searchText = ""
    
    private var filteredAndSortedPatients: [Patient] {
        let sorted = viewModel.patients.sorted { $0.lastName.lowercased() < $1.lastName.lowercased() }
            
        if searchText.isEmpty {
            return sorted
        }
            
        return sorted.filter { patient in
            patient.lastName.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if viewModel.patients.isEmpty {
                    ContentUnavailableView(
                        "No Patients",
                        systemImage: "person.crop.circle.badge.exclamationmark",
                        description: Text("Add patients using the button on the top right")
                    )
                } else {
                    List(filteredAndSortedPatients, id: \.medicalRecordNumber) { patient in
                        NavigationLink(value: patient) {
                            PatientRowView(patient: patient)
                        }
                    }
                }
            }
            .navigationTitle("Patients")
            .navigationDestination(for: Patient.self) { patient in
                PatientDetailView(patient: patient)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddPatient = true
                    }) {
                        Image(systemName: "person.badge.plus")
                    }
                    .accessibilityIdentifier("addPatientButton")
                }
            }
            .searchable(
                text: $searchText,
                prompt: "Search by last name"
            )
            
            .sheet(isPresented: $showingAddPatient) {
                NavigationStack {
                    AddPatientView(isPresented: $showingAddPatient)
                }
            }
        }
    }
}

struct PatientRowView: View {
    let patient: Patient
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(patient.nameAndAge())
                .font(.headline)
            Text("MRN: \(patient.medicalRecordNumber)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    PatientListView()
}
