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
    @Published var searchText: String = ""

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()


    init() {
        addSubscribers()
        }

    func addSubscribers() {
        // combines the live search text with the freshly fetched coins,
        // waits briefly for typing to settle, then republishes the filtered list
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
    }
}
