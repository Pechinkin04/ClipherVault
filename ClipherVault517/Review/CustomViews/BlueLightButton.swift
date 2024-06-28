//
//  BlueLightButton.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct BlueLightButton: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.w100)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color.blueLight)
            .cornerRadius(12)
            .padding(.horizontal, 16)
    }
}

struct BlueLightButtonImage: View {
    
    var image: String
    
    var body: some View {
        Image(systemName: image)
            .font(.headline)
            .foregroundColor(.w100)
            .padding(14)
            .background(Color.blueLight)
            .cornerRadius(12)
    }
}

#Preview {
    BlueLightButton(text: "Add")
}
