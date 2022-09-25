//
//  AnimeViewController+Delegation.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 22/09/2022.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import Resolver

//-----------------------------------------------------------------------------------
//=======>MARK: -  Delgation of skeleton
//-----------------------------------------------------------------------------------
extension AnimeViewController: SkeletonTableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as! AnimeCell
        viewModel.cellViewModel(cell, indexPath: indexPath)
        return cell
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return viewModel.cellIdentifier
    }
    
    
    
    
    
    func deSelectTableView(){
        tableView.rx.itemSelected.map({$0}).subscribe(onNext: { [weak self] index in
            guard let self = self else {return}
            let anime = self.viewModel.animesArray[index.row]
            self.synaposisViewControllerPresenting(anime)
            self.tableView.deselectRow(at: index, animated: true)
        }).disposed(by: bag)
    }
    
    fileprivate func synaposisViewControllerPresenting(_ anime: Anime){
        let synaposis: SynaposisVC = Resolver.resolve(SynaposisVC.self , args: anime)
        let navigationSynaposis = UINavigationController(rootViewController: synaposis)
        self.present(navigationSynaposis, animated: true, completion: nil)
    }
    
}


extension AnimeViewController {
    
    func selectedCollectionViewCellItems(){
        Observable.of(Season.selfArray)
            .bind(to: seasonCollectionView.rx.items(cellIdentifier: SeasonCell.cellId, cellType: SeasonCell.self)){
                row , season , cell in
                cell.configure(season)
            }.disposed(by: bag)
    }
    
    
    func startSelectedSeasonType(){
        seasonCollectionView.rx.itemSelected.map({$0.row}).subscribe(onNext: { row in
            self.tableViewSkeleton()
            let season = Season.allCases[row]
            self.viewModel.fetchAnimes(season)
        }).disposed(by: bag)
    }
    
    
    
}
