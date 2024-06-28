//
//  CalcResSheet.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 27.06.2024.
//

import SwiftUI

struct CalcResSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var assets: AssetObservable
    
    @State var calc: Calculation
    
    var body: some View {
        NavigationView {
            ZStack {
//                BackgroundView()
                Color.b100.ignoresSafeArea()
                
                VStack {
                    VStack {
                        HStack {
                            Text("Result")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.w100)
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    assets.deleteCalculation(calc)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .font(.title3)
                                    .foregroundColor(.w50)
                            }
                        }
                        .padding()
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.w20)
                        
                        PickedCurrView(textPreview: "-", pickedCurr: $calc.result.originalCur, showChevron: false)
                            .padding()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("\(calc.result.originalCur.symbol)\(String(format: "%.2f", calc.result.amountOriginal))")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.w100)
                                Spacer()
                            }
                            .padding()
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.w20)
                            
                            Text("\(String(format: "%.2f", calc.result.exchangeRate))")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.w100)
                                .padding()
                        }
                        .background(Color.w10)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        
                        PickedCurrView(textPreview: "-", pickedCurr: $calc.result.targetCur, showChevron: false)
                            .padding()
                        
                        HStack {
                            Text("\(calc.result.targetCur.symbol)\(String(format: "%.2f", calc.result.totalExchange))")
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .padding()
                        .font(.headline)
                        .foregroundColor(.w100)
                        .background(Color.blueLight)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        
                        Spacer()
                            .frame(maxHeight: 150)
                    }
                    .background(Color.darkViol)
                    .cornerRadius(12)
                    .padding()
                    
                    Spacer()
                }
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(calc.name)
                        .font(.headline)
                        .foregroundColor(.w100)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                            
                            Text("Back")
                                .font(.headline)
                                .fontWeight(.medium)
                        }
                    }
                    .foregroundColor(.blueLight)
                }
            }
        }
    }
}

#Preview {
    CalcResSheet(calc: MockData.calculations[0])
        .environmentObject(AssetObservable())
}
