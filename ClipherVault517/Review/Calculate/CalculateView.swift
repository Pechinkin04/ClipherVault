//
//  CalculateView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 26.06.2024.
//

import SwiftUI

struct CalculateView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    var imageNavLead: String
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    CalculateCalcBalanceView()
                        .padding()
                    
                    InputDataCalcView()
                        .padding(.horizontal, 16)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
         
            .navigationBarItems(leading: ZStack {
                Image("navBarLead")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Image(systemName: imageNavLead)
                    .font(.body)
                    .foregroundColor(.pinkNav)
            },
                trailing: HStack {
                Text("Calculator")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.w100)
            })
            
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.endEditing()
    }
}

#Preview {
    CalculateView(imageNavLead: "plus.forwardslash.minus").environmentObject(AssetObservable())
}
