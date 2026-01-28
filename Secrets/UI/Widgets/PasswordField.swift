//
//  PasswordField.swift
//  Secrets
//
//  Created by Jotam Leonardo on 1/28/26.
//

import SwiftUI

struct PasswordField: View {
    public var placeHolder: String
    @Binding public var password: String
    @State public var showPassword: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Group {
                    if showPassword {
                        TextField(placeHolder, text: $password)
                    } else {
                        SecureField(placeHolder, text: $password)
                    }
                }
                .textContentType(.password)
                .autocorrectionDisabled()

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}
