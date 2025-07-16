//
//  AnimeViewModel.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import RxCocoa
import Resolver
import Foundation

/**
 * BindingCases represents different UI states and actions for data binding.
 * This enum helps coordinate UI updates between the ViewModel and View.
 */
enum BindingCases {
    case reloadData
    case stopSkeletonAnimation
    case showError(String)
    case showLoading
    case hideLoading
}

/**
 * AnimeViewModelProtocol defines the contract for anime presentation logic.
 * This protocol encapsulates all the UI-related operations and state management.
 */
protocol AnimeViewModelProtocol: AnyObject {
    // MARK: - Properties
    var animesArray: [Anime] { get }
    var cellIdentifier: String { get }
    var bindingCases: BehaviorSubject<BindingCases> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var errorMessage: BehaviorRelay<String?> { get }
    var selectedSeason: BehaviorRelay<Season> { get }
    
    // MARK: - Methods
    func numberOfRowsInSection() -> Int
    func cellViewModel(_ cell: AnimeCell, indexPath: IndexPath)
    func fetchAnimes(_ season: Season)
    func fetchCurrentSeasonAnimes()
    func refreshData()
    func searchAnime(query: String)
    func filterByPopularity(minMembers: Int)
}

/**
 * AnimeViewModel provides concrete implementation of anime presentation logic.
 * This class handles UI state management, data transformation, and user interactions
 * while maintaining separation from the UI layer.
 */
class AnimeViewModel: AnimeViewModelProtocol {
    
    // MARK: - Dependencies
    
    /// Use case for anime business logic
    @Injected private var useCase: AnimeUseCaseProtocol
    
    // MARK: - Properties
    
    /// Array of anime to display in the UI
    private(set) var animesArray: [Anime] = [] {
        didSet {
            bindingCases.onNext(.reloadData)
        }
    }
    
    /// Original unfiltered anime array for search and filter operations
    private var originalAnimesArray: [Anime] = []
    
    /// Cell identifier for table view
    private(set) var cellIdentifier: String = "Cell"
    
    /// Subject for UI binding cases
    private(set) var bindingCases: BehaviorSubject<BindingCases> = BehaviorSubject(value: .reloadData)
    
    /// Loading state observable
    private(set) var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// Error message observable
    private(set) var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    /// Currently selected season
    private(set) var selectedSeason: BehaviorRelay<Season> = BehaviorRelay(value: .winter)
    
    /// Dispose bag for RxSwift subscriptions
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init() {
        setupBindings()
    }
    
    // MARK: - Private Setup
    
    /// Sets up reactive bindings for state management
    private func setupBindings() {
        // Bind loading state to UI
        isLoading
            .subscribe(onNext: { [weak self] loading in
                if loading {
                    self?.bindingCases.onNext(.showLoading)
                } else {
                    self?.bindingCases.onNext(.hideLoading)
                }
            })
            .disposed(by: disposeBag)
        
        // Bind error messages to UI
        errorMessage
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] error in
                self?.bindingCases.onNext(.showError(error))
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - AnimeViewModelProtocol Implementation
    
    /// Returns the number of rows in the table view section
    /// - Returns: Number of anime items
    func numberOfRowsInSection() -> Int {
        return animesArray.count
    }
    
    /// Configures a cell with anime data
    /// - Parameters:
    ///   - cell: The cell to configure
    ///   - indexPath: The index path of the cell
    func cellViewModel(_ cell: AnimeCell, indexPath: IndexPath) {
        guard indexPath.row < animesArray.count else {
            print("⚠️ Index out of bounds: \(indexPath.row)")
            return
        }
        cell.setCell(viewModel: animesArray[indexPath.row])
    }
    
    /// Fetches anime for a specific season
    /// - Parameter season: The season to fetch anime for
    func fetchAnimes(_ season: Season) {
        selectedSeason.accept(season)
        isLoading.accept(true)
        errorMessage.accept(nil)
        
        // Use hardcoded year for now, but this should be configurable
        useCase.animes(year: "2022", season: season)
            .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] animes in
                    self?.handleAnimesFetched(animes)
                },
                onError: { [weak self] error in
                    self?.handleError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    /// Fetches anime for the current season
    func fetchCurrentSeasonAnimes() {
        let currentSeason = Season.current
        selectedSeason.accept(currentSeason)
        isLoading.accept(true)
        errorMessage.accept(nil)
        
        useCase.currentSeasonAnimes()
            .delay(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] animes in
                    self?.handleAnimesFetched(animes)
                },
                onError: { [weak self] error in
                    self?.handleError(error)
                }
            )
            .disposed(by: disposeBag)
    }
    
    /// Refreshes the current data
    func refreshData() {
        fetchAnimes(selectedSeason.value)
    }
    
    /// Searches anime by query
    /// - Parameter query: The search query
    func searchAnime(query: String) {
        if query.isEmpty {
            animesArray = originalAnimesArray
        } else {
            animesArray = useCase.searchAnime(originalAnimesArray, query: query)
        }
    }
    
    /// Filters anime by minimum member count
    /// - Parameter minMembers: Minimum number of members
    func filterByPopularity(minMembers: Int) {
        animesArray = useCase.filterByPopularity(originalAnimesArray, minMembers: minMembers)
    }
    
    // MARK: - Private Helpers
    
    /// Handles successful anime fetch
    /// - Parameter animes: The fetched anime array
    private func handleAnimesFetched(_ animes: [Anime]) {
        originalAnimesArray = animes
        animesArray = animes
        isLoading.accept(false)
        bindingCases.onNext(.stopSkeletonAnimation)
        
        print("✅ ViewModel: Successfully loaded \(animes.count) anime")
    }
    
    /// Handles errors during anime fetch
    /// - Parameter error: The error that occurred
    private func handleError(_ error: Error) {
        isLoading.accept(false)
        
        let errorMessage = (error as? AnimeNetworkError)?.errorDescription ?? 
                          "An unexpected error occurred. Please try again."
        
        self.errorMessage.accept(errorMessage)
        bindingCases.onNext(.showError(errorMessage))
        bindingCases.onNext(.stopSkeletonAnimation)
        
        print("❌ ViewModel Error: \(error.localizedDescription)")
    }
}


