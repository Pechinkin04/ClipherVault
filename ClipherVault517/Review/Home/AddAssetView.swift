//
//  AddAssetView.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import SwiftUI

struct AddAssetView: View {
    
    /// Mark: Environment
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var assets: AssetObservable
    
    
    /// Mark: Add/Edit
    
    var isAdd = true
    var navTitle = "Add account"
    @State var isEdit = true
    
    var assetDel: Asset = MockData.assets[0]
    @State var deleteAssetAlert = false
    
    
    /// Mark: Fields
    
    @State var nameField = ""
    @State var descriptionField = "" // MockData.assets[0].description
    @State var sizeDescription: CGFloat = 34
    @State var countryField = ""
    
    @State var pickedCategory = CategoryAsset.entertainment
    
    @State var priceField = 0.0
    @State var currencyPicked = MockData.currencys[0]
    
    var body: some View {
        ZStack {
            Color.b100.ignoresSafeArea()
            
            VStack{
                
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text("Name")
                            .fontWeight(.semibold)
                            .titleStyle()
                        
                        TextField("Text", text: $nameField)
                            .textFieldStyle()
                            .disabled(!isEdit)
                        
                        Text("Description")
                            .fontWeight(.semibold)
                            .titleStyle()
                        
//                        TextField("Text", text: $descriptionField)
//                            .textFieldStyle()
                        MultiTextField(obj: $sizeDescription, textM: $descriptionField, isEdit: $isEdit, hint: "Text")
                            .frame(height: sizeDescription * (isEdit ? 1 : 2) < 64 ? sizeDescription * (isEdit ? 1 : 2) : 64)
                            .cornerRadius(10)
                            .textFieldStyle()
                        
                        Text("Country")
                            .fontWeight(.semibold)
                            .titleStyle()
                        
                        TextField("Text", text: $countryField)
                            .textFieldStyle()
                            .disabled(!isEdit)
                        
                        Text("Category")
                            .fontWeight(.semibold)
                            .titleStyle()
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(CategoryAsset.allCases, id: \.self) { category in
                                Button {
                                    withAnimation {
                                        pickedCategory = category
                                    }
                                } label: {
                                    Text(category.rawValue)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(pickedCategory == category ? .w100 : .b100)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 12)
                                        .background(pickedCategory == category ? Color.blueLight : Color.w100)
                                        .cornerRadius(12)
                                }
                                .disabled(!isEdit)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                    
                    Group {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Price")
                                    .fontWeight(.semibold)
                                    .titleStyle()
                                
                                HStack(spacing: 2) {
                                    Text("\(currencyPicked.symbol)")
                                        .foregroundColor(.b100)
                                    TextField("100", value: $priceField, formatter: amountFormatter)
                                        .keyboardType(.decimalPad)
                                }
                                .textFieldStyle()
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Currency")
                                    .fontWeight(.semibold)
                                    .titleStyle()
                                NavigationLink {
                                    CurrencyList(currencyPicked: $currencyPicked)
                                } label: {
                                    HStack(spacing: 5) {
                                        Image(currencyPicked.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 18, height: 18)
                                        
                                        Text(currencyPicked.name)
                                            .font(.footnote)
                                            .fontWeight(.medium)
                                            .foregroundColor(.w100)
                                    }
                                    .padding(.horizontal, 11)
                                    .padding(.vertical, 6)
                                    .background(Color.blueLight)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.w100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.blueLight, lineWidth: 2)
                                    )
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .disabled(!isEdit)
                    
                }
                
                Spacer()
                
                if isAdd {
                    Button {
                        assets.addAsset(Asset(name: nameField,
                                              description: descriptionField,
                                              country: countryField,
                                              category: pickedCategory,
                                              price: priceField,
                                              currency: currencyPicked))
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        BlueLightButton(text: "Add")
                    }
                } else {
                    HStack {
                        Button {
                            withAnimation {
                                deleteAssetAlert.toggle()
                            }
//                            assets.deleteAsset(assets.assets[assetIndex])
                        } label: {
                            BlueLightButtonImage(image: "trash")
                        }
                        .alert(isPresented: $deleteAssetAlert, content: {
                            Alert(title: Text("Are you sure?"),
                                  primaryButton: .destructive(Text("Delete"),
                                                              action: { assets.deleteAsset(assetDel) }),
                                  secondaryButton: .cancel(Text("Cancel")))
                        })
                        
                        Button {
                            withAnimation {
                                isEdit.toggle()
                            }
                        } label: {
                            BlueLightButton(text: isEdit ? "Save" : "Edit")
                                .padding(-16)
                        }
                    }
                    .padding()
                }
            }.padding(.vertical, 12)
            
        }
        .onTapGesture {
            hideKeyboard()
        }
//        .navigationTitle("Add account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(navTitle)
                    .font(.headline)
                    .foregroundColor(.w100)
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.endEditing()
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
    AddAssetView().environmentObject(AssetObservable())
}


struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(.blueLight)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(12)
            .padding(.bottom, 12)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
    
    func textFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
}
