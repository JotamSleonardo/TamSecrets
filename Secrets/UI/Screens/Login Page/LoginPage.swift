//
//  ContentView.swift
//  TamSecrets
//
//  Created by Jotam Leonardo on 1/23/26.
//

import SwiftUI

struct LoginPage: View {
    @Binding public var isLoggedIn: Bool
    
    // View State
    @State private var masterPassword = ""
    @State private var createdPassword = ""
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var isCreatingAccount = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            // App Icon / Title
            VStack(spacing: 8) {
                Image("shield")
                    .resizable()
                    .frame(width: 80, height: 80)

                Text(K.appName)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(K.appFootNote)
                    .foregroundColor(.secondary)
            }
            
            // Master Password Field
            VStack(spacing: 12) {
                if isCreatingAccount {
                    PasswordField(placeHolder: K.createPassPlaceHolder, password: $createdPassword)
                    PasswordField(placeHolder: K.confirmPassPlaceHolder, password: $masterPassword)
                } else {
                    PasswordField(placeHolder: K.masterPassPlaceHolder, password: $masterPassword)
                }
                
                if let errorMessage, !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }

            // Login Button
            Button {
                if isCreatingAccount {
                    createVault()
                } else {
                    login()
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text(isCreatingAccount ? K.createVaultText : K.unlockVaultText)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60.0)
            .background(masterPassword.isEmpty ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .disabled(masterPassword.isEmpty || isLoading)
            
            Button(isCreatingAccount ? K.existingVaultText : K.createVaultText) {
                self.isCreatingAccount = !self.isCreatingAccount
                self.clear()
            }
            .fontWeight(.heavy)
            .font(.caption)

            Spacer()
        }
        .padding()
    }

    // MARK: - Login Logic
    private func login() {
        self.errorMessage = nil
        self.isLoading = true

        // Simulate local verification delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if masterPassword == K.samplePassword {
                self.isLoading = false
                self.isLoggedIn = true
            } else {
                self.isLoading = false
                self.errorMessage = K.invalidPassword
            }
        }
    }
    
    private func createVault() {
        self.errorMessage = nil
        self.isLoading = true
        
        // Simulate local verification delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if createdPassword == masterPassword {
                self.isLoading = false
                self.isCreatingAccount = false
                print(K.vaultCreatedText)
            } else {
                self.isLoading = false
                self.errorMessage = K.invalidMatchPassword
            }
        }
        
        self.clear()
    }
    
    private func clear() {
        errorMessage = ""
        masterPassword = ""
        createdPassword = ""
    }
}
