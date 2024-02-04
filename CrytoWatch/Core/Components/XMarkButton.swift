//
//  XMarkButton.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 04/02/24.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) private var isPresented
    
    var body: some View {
        Button(action: {
            isPresented.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}
