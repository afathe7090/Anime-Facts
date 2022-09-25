//
//  AnimeVIewModel.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import RxSwift
import RxCocoa
import Resolver
import Foundation

enum BindingCases {
    case reloadData
    case stopSkeltonAnimation
}

protocol AnimeViewModelProtocol: AnyObject {
    
    var animesArray: [Anime] { get }
    var cellIdentifier: String { get }
    var bindingCases: BehaviorSubject<BindingCases> { get }
    func numberOfRowsInSection()-> Int
    func cellViewModel(_ cell: AnimeCell , indexPath: IndexPath)
    func fetchAnimes(_ season: Season)
}


class AnimeViewModel: AnimeViewModelProtocol {
    
    
    @Injected private var useCase: AnimeUseCaseProtocol
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -
    //-----------------------------------------------------------------------------------
    private(set) var animesArray: [Anime] = [] {
        didSet{
            self.bindingCases.onNext(.reloadData)
        }
    }
    
    private(set) var cellIdentifier: String = "Cell"
    //-----------------------------------------------------------------------------------
    //=======>MARK: -
    //-----------------------------------------------------------------------------------
    
    private(set) var bindingCases: BehaviorSubject<BindingCases> = BehaviorSubject(value: .reloadData)
    
  
    private let bag = DisposeBag()
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //-----------------------------------------------------------------------------------
    init() {
        
    }
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Helper Data
    //-----------------------------------------------------------------------------------
    func numberOfRowsInSection() -> Int {
        return animesArray.count
    }
    
    func cellViewModel(_ cell: AnimeCell, indexPath: IndexPath) {
        cell.setCell(viewModel: animesArray[indexPath.row])
    }
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Fetch Data
    //-----------------------------------------------------------------------------------
    func fetchAnimes(_ season: Season) {
        // Note i handel it to request to api with path
        // year of animes from archive
        // season that the anime is created
        useCase.animes(year: "2022", season: .winter).asObservable()
            .delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext:{[weak self] animes in
                guard let self = self else { return }
                self.asyneAnime(animes)
            }).disposed(by: bag)
    }
    
    fileprivate func asyneAnime(_ animes: [Anime]){
        animesArray = animes
        bindingCases.onNext(.reloadData)
        bindingCases.onNext(.stopSkeltonAnimation)
    }
}


