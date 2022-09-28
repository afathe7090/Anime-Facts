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
    var animeSynaposis: Anime? { get set }
    func synaposisAsObserver()-> Observable<String>
}



class SynaposisViewModel: SynaposisViewModelProtocol{
    
    var animeSynaposis: Anime?
    @Injected var useCase: SynaposisUseCaseProtocol
    
    
    func synaposisAsObserver()-> Observable<String> {
        return Observable<String>.just(animeSynaposis?.synopsis ?? "")
        
    }
    
    
    
}
