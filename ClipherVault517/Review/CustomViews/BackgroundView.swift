//
//  BackgroundView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        VStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
        }
        .frame(height: 100)
    }
}

#Preview {
    BackgroundView()
}
