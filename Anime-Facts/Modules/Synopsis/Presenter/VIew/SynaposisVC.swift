//
//  SynaposisVC.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 23/09/2022.
//

import UIKit
import SnapKit
import Resolver
import RxCocoa
import RxSwift

class SynaposisVC: UIViewController {
    
    @Injected var viewModel: SynaposisViewModelProtocol
    
    private let bag = DisposeBag()
    
    private lazy var separatorNavigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        return view
    }()
    
    
    private lazy var doneBarButtonItem: UIBarButtonItem = {
        let doneBarItem = UIBarButtonItem()
        doneBarItem.title = "Done"
        doneBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 19)], for: .normal)
        return doneBarItem
    }()
    
    
    private lazy var animeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    
    private lazy var animeTitle: UILabel =  {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    private lazy var personImageForMembers: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = UIColor.lightGray
        return imageView
    }()
    
    private lazy var membersCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var membersStackView: UIStackView = {
        let arrangesSubViews = [personImageForMembers , membersCounterLabel]
        let stack = UIStackView(arrangedSubviews: arrangesSubViews)
        stack.spacing = 8
        stack.contentMode = .center
        stack.axis = .horizontal
        stack.alignment  = .fill
        return stack
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //-----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureControllerView()
        confoigureDoneNavitaionBarVIiew()
        configrueLayout()
        
        asyneDataTOComponants()
        configureTableViewObserve()
    }
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //-----------------------------------------------------------------------------------
    
    
    
    
    fileprivate func configureControllerView(){
        view.backgroundColor = .tertiarySystemBackground
    }
    
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Lyout constraints
    //-----------------------------------------------------------------------------------
    
    fileprivate func configrueLayout(){
        
        configureSeparatorViewLayOut()
        configureImageOfAnime()
        configureTitleOfAnimeLabel()
        configureMembersStackView()
        configureTableVIewLayout()
        
        func configureSeparatorViewLayOut(){
            view.addSubview(separatorNavigationView)
            separatorNavigationView.snp.makeConstraints({
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.height.equalTo(1)
            })
        }
        
        func configureImageOfAnime(){
            view.addSubview(animeImage)
            animeImage.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
                $0.height.equalTo(275)
                $0.width.equalTo(view).multipliedBy(0.65)
                $0.centerX.equalTo(view)
            }
        }
        
        func configureTitleOfAnimeLabel(){
            view.addSubview(animeTitle)
            animeTitle.snp.makeConstraints({
                $0.top.equalTo(animeImage.snp.bottom).offset(25)
                $0.leading.equalTo(view).offset(20)
                $0.trailing.equalTo(view).offset(-20)
            })
        }
        
        func configureMembersStackView(){
            view.addSubview(membersStackView)
            membersStackView.snp.makeConstraints({
                $0.centerX.equalTo(animeTitle)
                $0.top.equalTo(animeTitle.snp.bottom).offset(10)
            })
        }
        
        
        
        func configureTableVIewLayout(){
            view.addSubview(tableView)
            tableView.snp.makeConstraints({
                $0.top.equalTo(membersStackView.snp.bottom).offset(10)
                $0.leading.equalTo(view.snp.leading).offset(10)
                $0.trailing.equalTo(view.snp.trailing).offset(-10)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            })
        }

        
    }
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -
    //-----------------------------------------------------------------------------------
    
    fileprivate func asyneDataTOComponants(){
        guard let anime = viewModel.animeSynaposis else { return }
        animeTitle.text = anime.title
        membersCounterLabel.text = anime.members.formatted()
        animeImage.setImage(anime.image_url)
    }
    
    
    fileprivate func confoigureDoneNavitaionBarVIiew(){
        navigationItem.rightBarButtonItem = doneBarButtonItem
        doneBarButtonItem.rx.tap.subscribe(onNext: { _ in
            self.dismiss(animated: true)
        }).disposed(by: bag)
    }
    
    
    fileprivate func configureTableViewObserve(){
        
        Observable.just("w")
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                _ , _ , cell in
                cell.textLabel?.textAlignment = .justified
                cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "\(self.viewModel.animeSynaposis?.synopsis ?? "")"
            }.disposed(by: bag)
        
    }
    
}


