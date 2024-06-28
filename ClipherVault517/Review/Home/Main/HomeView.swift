//
//  HomeView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var assets: AssetObservable
    
    @Binding var tabSelected: Int
    
    var imageNavLead: String
    
    var body: some View {
        NavigationView {
            
            ZStack {
                BackgroundView()
                
                VStack(spacing: 16) {
                    HomeCalculateView(tabSelected: $tabSelected)
                        .padding(.horizontal, 16)
                    
                    HomeAssestList()
                        .padding(.horizontal, 16)
                }
                .padding(.top, 16)
                
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
                Text("Home")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.w100)
            })
            
        }
    }
}

#Preview {
    HomeView(tabSelected: .constant(0), imageNavLead: "house")
        .environmentObject(AssetObservable())
}
