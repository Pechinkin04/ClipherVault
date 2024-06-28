//
//  SettingsView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 26.06.2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    @State private var isShareSheetShowing = false
    @State private var shareApp = "https://apps.apple.com/app/swift-gaze/id6504806399"
    @State private var policy = "https://www.termsfeed.com/live/80fccef0-15bf-4e51-8805-c5c201b97d77"
    
    var imageNavLead: String
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 12) {
                    
                    Spacer().frame(height: 20)
                    
                    Button {
                        isShareSheetShowing.toggle()
                    } label: {
                        ButtonSetting(image: "square.and.arrow.up.fill", label: "Share app")
                    }
                    .sheet(isPresented: $isShareSheetShowing, onDismiss: {
                        print("Share sheet dismissed")
                    }) {
                        ShareSheet(activityItems: [shareApp])
                    }
                    
                    Button {
                        openURL(URL(string: policy)!)
                    } label: {
                        ButtonSetting(image: "list.bullet.clipboard.fill", label: "Usage Policy")
                    }
                    
                    Button {
                        SKStoreReviewController.requestReview()
                    } label: {
                        ButtonSetting(image: "star.fill", label: "Rate app")
                    }
                    
                    Spacer()
                    
                }
                
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
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.w100)
            })
        }
    }
}

#Preview {
    SettingsView(imageNavLead: "gear")
        .environmentObject(AssetObservable())
}

struct ButtonSetting: View {
    
    var image: String
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.body)
                .foregroundColor(.blueLight)
            
            Text(label)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.w100)
            
            Spacer()
        }
        .padding()
        .background(Color.darkViol)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
