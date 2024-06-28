//
//  CalculateCalcBalanceView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 26.06.2024.
//

import SwiftUI

struct CalculateCalcBalanceView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Calculations")
                    .font(.subheadline)
                    .foregroundColor(.w100)
                
                HStack {
                    Text("\(assets.calculations.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.w100)
                    
                    Spacer()
                }
            }
            .padding(14)
            .background(Color.darkViol)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Balance")
                    .font(.subheadline)
                    .foregroundColor(.w100)
                
                HStack {
                    Text(assets.calculateMainBalance())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.w100)
                    
                    Spacer()
                }
            }
            .padding(14)
            .background(Color.darkViol)
            .cornerRadius(12)
        }
    }
}

#Preview {
    CalculateCalcBalanceView()
        .background(Color.pink).environmentObject(AssetObservable())
}
