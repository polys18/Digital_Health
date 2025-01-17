//
//  ContentView.swift
//  Digital Health
//
//  Created by Polycarpos Yiorkadjis on 10/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = PatientViewModel()
    
    var body: some View {
        PatientListView()
            .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
