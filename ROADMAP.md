# Roadmap

Step-by-step plan to bring SwiftfulCrypto up to feature parity with a full
MVVM + Combine + CoreData crypto tracker app. Each checked-off item is one
commit, pushed to `origin/main` as it lands. Order may shift slightly as we
go, but the phases build on each other in this sequence.

Current state (done): app entry point, theme colors, `CoinModel`,
`NetworkingManager`, `CoinDataService`, `HomeView`/`HomeViewModel`,
`CoinRowView`, `CoinImageView`/`CoinImageViewModel`/`CoinImageService`,
`CircleButtonView`/`CircleButtonAnimationView`, `PreviewProvider.dev`.

## Phase 1 — Home screen: search & sort
- [ ] `SearchBarView` component + wire into `HomeView`/`HomeViewModel` to filter `allCoins`
- [ ] Sort options (rank / holdings / price, ascending / descending) on `HomeViewModel` + sort button in the column header

## Phase 2 — Market stats strip
- [ ] `MarketDataModel` + CoinGecko `/global` endpoint support
- [ ] `MarketDataService` (fetch global market data)
- [ ] `StatisticModel` + reusable `StatisticView` tile component
- [ ] `HomeStatsView` (market cap, 24h volume, BTC dominance, portfolio value) shown/hidden with the portfolio toggle

## Phase 3 — CoreData persistence
- [ ] CoreData model (`Portfolio` entity: coinID, amount) + `PersistenceController`
- [ ] `PortfolioDataService` wrapping CoreData CRUD (add/update/delete/get)
- [ ] Wire `PortfolioDataService` into `HomeViewModel` to compute `porfolioCoins` from `allCoins` + saved entities

## Phase 4 — Add/edit portfolio sheet
- [ ] Scaffold `PortfolioView` (sheet) with its own search bar over all coins
- [ ] Horizontal coin-selection scroll section with selection highlighting
- [ ] Amount `TextField` + live current-value preview
- [ ] Save button (`XMarkButton`, trailing nav item) wired to `PortfolioDataService.updatePortfolio`
- [ ] Wire the "+" `CircleButtonView` on `HomeView` to present `PortfolioView`
- [ ] `HapticManager` + haptic feedback on save

## Phase 5 — Coin detail screen
- [ ] Navigation: `CoinRowView` → `NavigationLink` → `CoinDetailView`
- [ ] `CoinDetailDataService` (fetch single coin detail from `/coins/{id}`)
- [ ] `CoinDetailViewModel` (overview stats, additional stats, description)
- [ ] `CoinDetailView` header (image, name, price)
- [ ] Overview statistics grid
- [ ] Additional statistics grid
- [ ] Expandable description ("read more/less") + website/reddit links

## Phase 6 — Price chart
- [ ] `ChartView` (custom `Path`-based line chart) driven by sparkline data
- [ ] Chart interactivity (drag to inspect a point, date/price labels)
- [ ] Integrate `ChartView` into `CoinDetailView`, color accent tied to live price change

## Phase 7 — Settings & polish
- [ ] `SettingsView` (links) + gear `CircleButtonView` on `HomeView`
- [ ] `LaunchView` / splash loading animation shown until first data load completes
- [ ] Pull-to-refresh on the home list
- [ ] Network error handling (alert / retry) surfaced from services
- [ ] Accessibility pass + dark mode preview coverage on new views
- [ ] Final cleanup: retire unused `ContentView` scaffold, tidy comments, update `CLAUDE.md`

~30 commits total. We'll tick items off here as we land them.
