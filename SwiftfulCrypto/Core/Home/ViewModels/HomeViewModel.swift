//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Amir Lajevardi on 14/05/2025.
//

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
