//
//  AuthenticationView.swift
//  SwiftFulFirebaseBootcamp
//
//  Created by Ton Silva on 20/2/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


@MainActor
final class AuthenticationViewModel: ObservableObject {
    //@Published var  didSignInWithApple: Bool = false
    let signInAppleHelper = SignInAppleHelper()
    
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await  AuthenticationManager.shared.signInWithApple(tokens: tokens)
        
//        signInAppleHelper.startSignInWithAppleFlow { result in
//            switch result {
//            case .success(let signInAppleResult):
//                Task {
//                    do {
//                        try await AuthenticationManager.shared.signInWithApple(tokens: signInAppleResult)
//                        self.didSignInWithApple = true
//                    } catch {
//                        
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInAnonymous()
    }
}

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showingSignInView: Bool
    
    var body: some View {
        VStack {
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInAnonymous()
                        showingSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Sign In Anonymously")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
            NavigationLink {
                SignInEmailView(showSignInView: $showingSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        //showingSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInApple()
                        showingSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .signIn, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showingSignInView: .constant(false))
    }
}
