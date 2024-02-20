//
//  SettingsView.swift
//  SwiftFulFirebaseBootcamp
//
//  Created by Ton Silva on 20/2/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}


struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showingSignView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showingSignView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showingSignView: .constant(false))
    }
}
