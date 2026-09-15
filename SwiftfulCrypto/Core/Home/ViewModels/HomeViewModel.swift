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
    @Published var sortOption: SortOption = .holdings

    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()


    init() {
        addSubscribers()
        }

    func addSubscribers() {
        // combines the live search text, the freshly fetched coins, and the chosen
        // sort option, waits briefly for typing to settle, then republishes the result
        $searchText
            .combineLatest(dataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
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

    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        // holdings sorting is a no-op until portfolio persistence lands (Phase 3);
        // it falls back to rank for now so the UI already wires up correctly
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
}

extension HomeViewModel {

    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }

}
