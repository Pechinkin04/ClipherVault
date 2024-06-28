//
//  HomeCalculateView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct HomeCalculateView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    @Binding var tabSelected: Int
    
    var body: some View {
        VStack(spacing: 24) {
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Main Balance")
                        .font(.subheadline)
                        .foregroundColor(.w100)
                    
                    Text(assets.calculateMainBalance())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.w100)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    NavigationLink {
                        AddAssetView()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 18)
                            .foregroundColor(.w100)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(Color.w20)
                            .cornerRadius(8)
                    }
                    
                    Button {
                        withAnimation {
                            tabSelected = 1
                        }
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 18)
                            .foregroundColor(.w100)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(Color.b50)
                            .cornerRadius(8)
                    }
                }
                
            }
            
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Currencies")
                        .font(.subheadline)
                        .foregroundColor(.w100)
                    
                    HStack {
                        Text("\(assets.findUsedCurrencies() ?? 0)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.w100)
                        
                        Spacer()
                        
                        Image("currenciesIMG")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 46, height: 18)
                    }
                }
                .padding(14)
                .background(Color.darkViol)
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Assets")
                        .font(.subheadline)
                        .foregroundColor(.w100)
                    
                    HStack {
                        Text("\(assets.assets.count)")
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
}

#Preview {
    HomeCalculateView(tabSelected: .constant(0))
        .background(Color.pink)
        .environmentObject(AssetObservable())
}
