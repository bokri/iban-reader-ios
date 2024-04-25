//
//  IbanTextField.swift
//  IbanReader
//
//  Created by Aymen Bokri on 25/04/2024.
//

import Foundation
import SwiftUI

/// A custom SwiftUI view representing a text field with validation support.
struct IbanTextField: View {
    /// The placeholder text to display when the text field is empty.
    var placeHolder: String
    
    /// The error message to display when validation fails.
    var errorMessage: String
    
    /// A binding to the text value entered into the text field.
    @Binding var value: String
    
    /// A closure that defines the validation logic for the text field.
    var validator: (String) -> Bool
    
    /// A state variable indicating whether the current value of the text field is valid.
    @State var isValid: Bool = false
    
    var body: some View {
        VStack {
            // Text field for user input
            TextField(self.placeHolder, text: $value)
                .onChange(of: value) { _, newValue in
                    isValid = validator(newValue)
                }
            
            // Divider line below the text field
            Divider()
            
            // Display error message if validation fails and the field is not empty
            if !isValid && !value.isEmpty {
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(5)
    }
}

#Preview {
    IbanTextField(placeHolder: "FR76 XXXX", errorMessage: "Saisie erronée", value: .constant("DE89"), validator: { _ in return false})
        .padding()
}
