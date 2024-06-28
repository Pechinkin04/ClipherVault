//
//  CurrencyList.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct CurrencyList: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var currencyPicked: Currency
    
    var currencys = MockData.currencys
    
    var body: some View {
        ZStack {
            Color.b100.ignoresSafeArea()
            
            ScrollView {
                ForEach(currencys) { currency in
                    Button {
                        withAnimation {
                            currencyPicked = currency
                        }
                    } label: {
                        HStack {
                            Image(currency.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(currency.name)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(currencyPicked.id == currency.id ? .w100 : .b100)
                                Text(currency.desc)
                                    .font(.subheadline)
                                    .foregroundColor(currencyPicked.id == currency.id ? .w50 : .b50)
                            }
                            
                            Spacer()
                            
                            Text(currency.symbol)
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(currencyPicked.id == currency.id ? .w100 : .b100)
                        }
                    }
                    .padding()
                    .background(currencyPicked.id == currency.id ? .blueLight : Color.w100)
                    .cornerRadius(12)
                }
            }
            .padding()
            
            VStack {
                Spacer()
                
                Button {
                    withAnimation {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    BlueLightButton(text: "Approve")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Currency")
                    .font(.headline)
                    .foregroundColor(.w100)
            }
        }
    }
}

#Preview {
    CurrencyList(currencyPicked: .constant(MockData.currencys[1]))
}
