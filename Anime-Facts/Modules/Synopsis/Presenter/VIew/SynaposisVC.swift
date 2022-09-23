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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
