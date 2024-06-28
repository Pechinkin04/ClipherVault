//
//  MainTabView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 27.06.2024.
//

import SwiftUI

struct MainTabView: View {
    
    
    @ObservedObject var assets = AssetObservable()
    
    @State var tabSelected = 0
    
    
    var body: some View {
        TabView(selection: $tabSelected) {
            HomeView(tabSelected: $tabSelected, imageNavLead: "house")
                .tabItem { Image(systemName: "house") }.tag(0)
            
            CalculateView(imageNavLead: "plus.forwardslash.minus")
                .tabItem { Image(systemName: "plus.forwardslash.minus") }.tag(1)
            
            SettingsView(imageNavLead: "gear")
                .tabItem { Image(systemName: "gear") }.tag(2)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(.b100)
            UITabBar.appearance().backgroundColor = UIColor(.b100)
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "w20")
        }
        
        .accentColor(.blueLight)
        .environmentObject(assets)
        
    }
        
}

    

#Preview {
    MainTabView()
}
