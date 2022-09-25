//
//  AnimeViewController.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import SnapKit
import SkeletonView

class AnimeViewController: UIViewController {
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Injected ViewModel
    //-----------------------------------------------------------------------------------
    @Injected var viewModel: AnimeViewModelProtocol
    private(set) var bag = DisposeBag()
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Subviews
    //-----------------------------------------------------------------------------------
    
    private lazy var seaconBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    private(set) lazy var seasonCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customCollectionViewLayout())
        collectionView.register(UINib(nibName: SeasonCell.cellId, bundle: nil)
                                , forCellWithReuseIdentifier: SeasonCell.cellId)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    private(set) lazy var tableView: UITableView  = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 20)
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.register(AnimeCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //-----------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIView()
        configureSeasonBackView()
        configureTableViewLayoutCostraints()
        configureSelectedSeacionCOllectionViewCell()
        
        deSelectTableView()
        bindWithViewModel()
        
        selectedCollectionViewCellItems()
        startSelectedSeasonType()
    }
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functins
    //-----------------------------------------------------------------------------------
    
    func tableViewSkeleton(){
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
    }
    

    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Layout COnstraints
    //-----------------------------------------------------------------------------------
    
    
    fileprivate func configureUIView(){
        title = "Anime synopsis"
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    fileprivate func configureSeasonBackView(){
        view.addSubview(seaconBackView)
        seaconBackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.height.equalTo(70)
            $0.leading.trailing.equalTo(view)
        }
    }
    
    fileprivate func configureSelectedSeacionCOllectionViewCell(){
        view.addSubview(seasonCollectionView)
        seasonCollectionView.snp.makeConstraints({
            $0.edges.equalTo(seaconBackView.snp.edges)
        })
    }
    
    fileprivate func configureTableViewLayoutCostraints(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(seaconBackView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Binding
    //-----------------------------------------------------------------------------------
    fileprivate func bindWithViewModel() {
        viewModel.bindingCases
            .asObservable()
            .subscribe(onNext: { [weak self] cases in
                guard let self = self else { return }
                switch cases {
                case .reloadData:
                    self.tableView.reloadData()
                case .stopSkeltonAnimation:
                    self.tableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: false, transition: .none)
                }
            }).disposed(by: bag)
    }
    

}




