//
//  Asset.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import Foundation

final class AssetObservable: ObservableObject {
//    @Published var assets: [Asset] = MockData.assets
    @Published var currencys: [Currency] = MockData.currencys
//    
//    @Published var calculations: [Calculation] = MockData.calculations
    
    @Published var assets: [Asset] = UserDefaults.standard.getAssets(forKey: "assets517")
//    @Published var currencys: [Currency] = UserDefaults.standard.getCurrencys(forKey: "currency517")
    
    @Published var calculations: [Calculation] = UserDefaults.standard.getCalculations(forKey: "calculation517")
    
    /// MARK: MainHome
    private func findPrivateMainCurrency() -> Currency {
        var mainCurrencyArray = [Int](repeating: 0, count: currencys.count)
        for asset in assets {
            for i in 0..<currencys.count {
                if asset.currency.name == currencys[i].name {
                    mainCurrencyArray[i] += 1
                    break
                }
            }
        }
        
        var mainCurrency = currencys[0]
        var maxValue = mainCurrencyArray[0]
        for i in 1..<currencys.count {
            if mainCurrencyArray[i] > maxValue {
                maxValue = mainCurrencyArray[i]
                mainCurrency = currencys[i]
            }
        }
        
        return mainCurrency
    }
    
    public func calculateMainBalance() -> String {
        var balance: Double = 0
        let mainCurrency = findPrivateMainCurrency()
        
        for asset in assets {
            if asset.currency.name == mainCurrency.name {
                balance += asset.price
            }
        }
        
        let out = "\(mainCurrency.symbol)\(String(format: "%.2f", balance))"
        return out
    }
    
    public func findUsedCurrencies() -> Int? {
        var mainCurrencyArray = [Int](repeating: 0, count: currencys.count)
        for asset in assets {
            for i in 0..<currencys.count {
                if asset.currency.name == currencys[i].name {
                    mainCurrencyArray[i] += 1
                    break
                }
            }
        }
        
        var usedCurrencies = 0
        for cur in mainCurrencyArray {
            if cur != 0 {
                usedCurrencies += 1
            }
        }
        
        return usedCurrencies
    }
    
    
    
    /// MARK: Add/Delete Asset
    public func addAsset(_ asset: Asset) {
        assets.insert(asset, at: 0)
        print(assets[0])
        saveAssets()
    }
    
    public func deleteAsset(_ asset: Asset) {
        for i in 0..<assets.count {
            if assets[i].id == asset.id {
                assets.remove(at: i)
                saveAssets()
                return
            }
        }
    }
    
    public func saveAssets() {
        UserDefaults.standard.setAssets(assets, forKey: "assets517")
    }
    
    
    
    /// MARK: Calculations
    public func addCalculation(_ result: ResultCalculation) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy, HH:mm a"
        let formattedDate = formatter.string(from: date)
//        print(formattedDate)
        
        
        let nameCalc = "\(result.originalCur.name) - \(result.targetCur.name) (\(calculations.count + 1))"
        let descriptionCalc = formattedDate
        
        let newCalculation = Calculation(name: nameCalc,
                                         description: descriptionCalc,
                                         result: result)
        
        calculations.insert(newCalculation, at: 0)
        print(calculations[0])
        saveCalculations()
    }
    
    public func deleteCalculation(_ calc: Calculation) {
        for i in 0..<calculations.count {
            if calculations[i].id == calc.id {
                calculations.remove(at: i)
                saveCalculations()
                return
            }
        }
    }
    
    public func saveCalculations() {
        UserDefaults.standard.setCalculations(calculations, forKey: "calculation517")
    }
    
    
}


struct Asset: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var description: String
    var country: String
    
    var category: CategoryAsset
    
    var price: Double
    var currency: Currency
}


enum CategoryAsset: String, CaseIterable, Codable {
    case entertainment = "Entertainment"
    case travel = "Travel"
    case gadgets = "Gadgets"
    case books = "Books"
    case appliances = "Appliances"
}


struct Currency: Identifiable, Codable {
    var id = UUID()
    var image: String
    var name: String
    var desc: String
    var symbol: String
}


struct Calculation: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var description: String
    var result: ResultCalculation
}

struct ResultCalculation: Identifiable, Codable {
    var id = UUID()
    
    var originalCur: Currency
    var amountOriginal: Double
    
    var exchangeRate: Double
    var targetCur: Currency
    
    var totalExchange: Double {
        amountOriginal * exchangeRate
    }
}



struct MockData {
    
    static var assets = [
        Asset(name: "Breville Espresso Machine",
              description: "A modern espresso machine featuring adjustable temperature and pressure settings for the perfect espresso.",
              country: "USA",
              category: .appliances,
              price: 424,
              currency: currencys[0]),
        
        Asset(name: "Secrets of the JavaScript Ninja",
              description: "Dive deep into the complex and challenging aspects of JavaScript for advanced developers.",
              country: "Sweden",
              category: .books,
              price: 100,
              currency: currencys[1]),
        
        Asset(name: "Xiaomi Mi Band 6",
              description: "A fitness tracker with a wide range of features for monitoring your activity and health.",
              country: "Turkey",
              category: .gadgets,
              price: 1303,
              currency: currencys[5]),
        
        Asset(name: "Breville Espresso Machine",
              description: "A modern espresso machine featuring adjustable temperature and pressure settings for the perfect espresso.",
              country: "USA",
              category: .appliances,
              price: 424,
              currency: currencys[0]),
        
        Asset(name: "Secrets of the JavaScript Ninja",
              description: "Dive deep into the complex and challenging aspects of JavaScript for advanced developers.",
              country: "Sweden",
              category: .books,
              price: 100,
              currency: currencys[1]),
        
        Asset(name: "Xiaomi Mi Band 6",
              description: "A fitness tracker with a wide range of features for monitoring your activity and health.",
              country: "Turkey",
              category: .gadgets,
              price: 1303,
              currency: currencys[0]),
    ]
    
    static var currencys = [
        Currency(image: "usd", name: "USD", desc: "US dollar", symbol: "$"),
        Currency(image: "eur", name: "EUR", desc: "Euro", symbol: "€"),
        Currency(image: "jpy", name: "JPY", desc: "Japanese yen", symbol: "¥"),
        Currency(image: "chf", name: "CHF", desc: "Swiss franc", symbol: "₣"),
        
        Currency(image: "try", name: "TRY", desc: "Turkish lira ", symbol: "₺"),
        Currency(image: "kzt", name: "KZT", desc: "Kazakhstani tenge", symbol: "₸"),
        Currency(image: "gbp", name: "GBP", desc: "Pound sterling", symbol: "£"),
        Currency(image: "thb", name: "THB", desc: "Thai baht", symbol: "฿"),
    ]
    
    static var mockCurr = Currency(image: "-",
                                   name: "-",
                                   desc: "-",
                                   symbol: "-")
    
    
    static var calculations = [
        Calculation(name: "USD - EUR (1)",
                    description: "14 Jul, 2024, 24:00 PM",
                    result: ResultCalculation(originalCur: currencys[0],
                                              amountOriginal: 100,
                                              exchangeRate: 0.95,
                                              targetCur: currencys[1])),
        
        Calculation(name: "USD - EUR (2)",
                    description: "14 Jul, 2024, 24:00 PM",
                    result: ResultCalculation(originalCur: currencys[0],
                                              amountOriginal: 500,
                                              exchangeRate: 0.95,
                                              targetCur: currencys[1])),
        
        Calculation(name: "USD - EUR (3)",
                    description: "14 Jul, 2024, 24:00 PM",
                    result: ResultCalculation(originalCur: currencys[0],
                                              amountOriginal: 3,
                                              exchangeRate: 0.95,
                                              targetCur: currencys[1])),
    ]
}
