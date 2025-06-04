//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 14/05/2025.
//

import Foundation


class HomeViewModel: ObservableObject{
    
    @Published var allCoins: [CoinModel] = []
    @Published var porfolioCoins: [CoinModel] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.porfolioCoins.append(DeveloperPreview.instance.coin)

        }
    }
}
