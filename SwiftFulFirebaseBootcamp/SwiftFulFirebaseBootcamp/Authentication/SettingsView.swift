//
//  SettingsView.swift
//  SwiftFulFirebaseBootcamp
//
//  Created by Ton Silva on 20/2/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        // email should be passed/loaded into this vm in some way (my to-do)
        let authUser = try  AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let userEmail = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: userEmail)
    }
    
    func updateEmail() async throws {  // to-do: figure out how to pass the info needed
        let userEmail = "dada@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: userEmail)
    }
    
    func updatePassword() async throws { // to-do: figure out how to pass the info needed
        try await AuthenticationManager.shared.updatePassword(password: "hello123")
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
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showingSignView: .constant(false))
    }
}


extension SettingsView {
    private var emailSection: some View {
        
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset!!".uppercased())
                        showingSignView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password updated!!".uppercased())
                        showingSignView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email updated!!".uppercased())
                        showingSignView = true
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
}
