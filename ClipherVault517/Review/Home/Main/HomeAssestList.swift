//
//  HomeAssestList.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct HomeAssestList: View {
    @EnvironmentObject var assets: AssetObservable
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Assets")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.w100)
            
            ScrollView {
                ForEach(assets.assets) { asset in
                    NavigationLink {
                        AddAssetView(isAdd: false,
                                     navTitle: asset.name,
                                     isEdit: false,
                                     assetDel: asset,
                                     nameField: asset.name,
                                     descriptionField: asset.description,
                                     countryField: asset.country,
                                     pickedCategory: asset.category,
                                     priceField: asset.price,
                                     currencyPicked: asset.currency)
                    } label: {
                        AssetsCard(asset: asset)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .padding(.horizontal, 16)
        .background(Color.darkViol)
        .cornerRadius(12)
    }
}

#Preview {
    HomeAssestList()
        .background(Color.pink)
        .environmentObject(AssetObservable())
//    AssetsCard(asset: MockData.assets[0]).padding(20).background(Color.darkViol)
}


struct AssetsCard: View {
    
    var asset: Asset
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(asset.category.rawValue)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.w100)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blueLight)
                    .cornerRadius(4)
                
                Text(asset.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.w100)
                    .lineLimit(1)
                
                ZStack {
                    Text(MockData.assets[0].description)
                        .foregroundColor(.clear)
                    Text(asset.description)
                }
                .font(.footnote)
            //                    .fontWeight(.medium)
                .foregroundColor(.w50)
                .lineLimit(1)
            }
            
            Spacer().frame(width: 25)
            
            Text("\(asset.currency.symbol)\(String(format: "%.0f", asset.price))")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.w100)
        }
        .padding(16)
        .background(Color.w10)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.w20, lineWidth: 2)
        )
        .cornerRadius(12)
    }
}
