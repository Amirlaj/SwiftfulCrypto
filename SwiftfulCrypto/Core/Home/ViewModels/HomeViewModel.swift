//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 14/05/2025.
//

// holds the state/data for the home screen (allCoins and protfolioCoins)
//subscribes to a CoinDataService, and updates allCoins whenever new data is fetched
// uses Combine for reactive, real-time updates
// shares this data with Swift views via @Published

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    @Published var allCoins: [CoinModel] = []
    @Published var porfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()


    init() {
        addSubscribers()
        }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (retunredCoins) in
                self?.allCoins = retunredCoins
            }
            .store(in: &cancellables)
    }
}
