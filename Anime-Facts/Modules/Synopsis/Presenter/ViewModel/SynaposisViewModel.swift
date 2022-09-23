//
//  SynaposisViewModel.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 23/09/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Resolver


protocol SynaposisViewModelProtocol: AnyObject{
    
}



class SynaposisViewModel: SynaposisViewModelProtocol{
    
    
    @Injected var useCase: SynaposisUseCaseProtocol
    
}
