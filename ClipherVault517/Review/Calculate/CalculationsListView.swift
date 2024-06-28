//
//  CalculationsListView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 27.06.2024.
//

import SwiftUI

struct CalculationsListView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    @State var showCalcSheet = false
    @State var pickedCalc: Calculation? // = MockData.calculations[0]
    
    var body: some View {
        ZStack {
//            BackgroundView()
            Color.b100.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    ForEach(assets.calculations) { calculation in
                        Button {
                            pickedCalc = calculation
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                showCalcSheet.toggle()
//                            }
                        } label: {
                            CalcCard(calc: calculation)
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(item: $pickedCalc, content: { calc in
            CalcResSheet(calc: calc)
        })
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Calculations")
                    .font(.headline)
                    .foregroundColor(.w100)
            }
        }
    }
}

#Preview {
    NavigationView {
        CalculationsListView()
            .background(Color.pink)
            .environmentObject(AssetObservable())
    }
}

struct CalcCard: View {
    
    var calc: Calculation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(calc.name)
                    .font(.headline)
                    .foregroundColor(.b100)
                
                Text(calc.description)
                    .font(.footnote)
                    .foregroundColor(.b50)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.b50)
        }
        .padding()
        .background(Color.w100)
        .cornerRadius(12)
    }
}
