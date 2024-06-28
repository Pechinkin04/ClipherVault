//
//  InputDataCalcView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 26.06.2024.
//

import SwiftUI

struct InputDataCalcView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    @State var originalCur: Currency = MockData.mockCurr
    @State var amount: Double = 0
    @State var exchange: Double = 0
    @State var targetCur: Currency = MockData.mockCurr
    
    @State var result: ResultCalculation? // = MockData.calculations[0].result
    
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Input data")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.w100)
                
                Spacer()
                
                NavigationLink {
                    CalculationsListView()
//                Button {
//                    withAnimation {
//                        cleanCalculation()
//                    }
                } label: {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.headline)
                        .foregroundColor(.w50)
                }
            }
            
            NavigationLink {
                CurrencyList(currencyPicked: $originalCur)
            } label: {
                PickedCurrView(textPreview: "Original currency",
                               pickedCurr: $originalCur)
            }
            
            VStack(spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Amount")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.w100)
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        if originalCur.id != MockData.mockCurr.id {
                            Text("\(originalCur.symbol)")
                                .foregroundColor(.b100)
                        }
                        TextField("100", value: $amount, formatter: amountFormatter)
                            .keyboardType(.decimalPad)
                    }
                    .textFieldStyle()
                    .frame(width: 100)
                }
                
                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(Color.darkViol)
                    .padding(-16)
                    .offset(y: 8)
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Exchange Rate")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.w100)
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        TextField("0.95", value: $exchange, formatter: amountFormatter)
                            .keyboardType(.decimalPad)
                    }
                    .textFieldStyle()
                    .frame(width: 100)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .background(Color.w10)
            .cornerRadius(12)
            
            NavigationLink {
                CurrencyList(currencyPicked: $targetCur)
            } label: {
                PickedCurrView(textPreview: "Target currency",
                               pickedCurr: $targetCur)
            }
            
            if let result {
                resultShow(result: result)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button {
                    withAnimation {
                        cleanCalculation()
                        result = nil
                    }
                } label: {
                    if result != nil {
                        BlueLightButtonImage(image: "arrowshape.left.fill")
                    }
                }
                
                Button {
                    withAnimation {
//                        if (result != nil) {
//                            cleanCalculation()
//                            result = nil
//                        } else {
                            
                            result = ResultCalculation(originalCur: originalCur,
                                                       amountOriginal: amount,
                                                       exchangeRate: exchange,
                                                       targetCur: targetCur)
                            if let result {
                                assets.addCalculation(result)
                                //                    cleanCalculation()
                            }
//                        }
                    }
                } label: {
                    BlueLightButton(text: (result != nil) ? "Re-calculate" : "Calculate")
                        .opacity((originalCur.id != MockData.mockCurr.id && targetCur.id != MockData.mockCurr.id) ? 1 : 0.6)
                        .padding(-16)
                }
                .padding(.vertical, 12)
                .disabled((originalCur.id != MockData.mockCurr.id && targetCur.id != MockData.mockCurr.id) ? false : true)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.darkViol)
        .cornerRadius(12)
    }
    
    
    private func cleanCalculation() {
        originalCur = MockData.mockCurr
        amount = 0
        exchange = 0
        targetCur = MockData.mockCurr
    }
    
    let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        formatter.allowsFloats = true // Разрешить ввод дробей
        formatter.maximumFractionDigits = 2 // Максимальное количество знаков после запятой
        return formatter
    }()
}

#Preview {
    NavigationView {
        InputDataCalcView()
            .background(Color.pink)
            .environmentObject(AssetObservable())
    }
}


struct PickedCurrView: View {
    
    var textPreview: String
    @Binding var pickedCurr: Currency
    
    var showChevron = true
    
    var body: some View {
        HStack {
            if pickedCurr.id == MockData.mockCurr.id {
                Text(textPreview)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.w100)
            } else {
                HStack(spacing: 4) {
                    Image(pickedCurr.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                    
                    Text(pickedCurr.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.w100)
                }
            }
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.w100)
            }
        }
        .padding()
        .background(Color.w10)
        .cornerRadius(12)
    }
}


struct resultShow: View {
    
    var result: ResultCalculation
    
    var body: some View {
        HStack(spacing: 4) {
            Image(result.targetCur.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
            
            Text("\(result.targetCur.symbol)\(String(format: "%.2f", result.totalExchange))")
                .fontWeight(.medium)
            Spacer()
        }
        .padding()
        .font(.subheadline)
        .foregroundColor(.w100)
        .background(Color.blueLight)
        .cornerRadius(12)
    }
}
