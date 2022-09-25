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
    
    
    private lazy var separatorNavigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        return view
    }()
    
    
    
    private lazy var animeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    private lazy var animeTitle: UILabel =  {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var synaposisLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //-----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureControllerView()
        confoigureDoneNavitaionBarVIiew()
        configrueLayout()
    }
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //-----------------------------------------------------------------------------------

    
    
    
    
    fileprivate func configureControllerView(){
        view.backgroundColor = .white
    }
    
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Lyout constraints
    //-----------------------------------------------------------------------------------
    
    fileprivate func configrueLayout(){
        
        configureSeparatorViewLayOut()
        
        func configureSeparatorViewLayOut(){
            view.addSubview(separatorNavigationView)
            separatorNavigationView.snp.makeConstraints({
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.height.equalTo(1)
            })
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    fileprivate func confoigureDoneNavitaionBarVIiew(){
        let doneBarItem = UIBarButtonItem()
        doneBarItem.title = "Done"
        doneBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 19)], for: .normal)
        navigationItem.rightBarButtonItem = doneBarItem
    }
    
    
    
    
    
}
