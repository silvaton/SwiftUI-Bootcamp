//
//  RootView.swift
//  SwiftFulFirebaseBootcamp
//
//  Created by Ton Silva on 20/2/24.
//

import SwiftUI

struct RootView: View {
    @State private var showingSignView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showingSignView: $showingSignView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showingSignView = authUser == nil
            
        }
        .fullScreenCover(isPresented: $showingSignView) {
            NavigationStack {
                AuthenticationView(showingSignInView: $showingSignView)
            }
        }
    }
}

#Preview {
    RootView()
}
