//
//  UICompostionalFlowLayout+Ext.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 22/09/2022.
//

import Foundation
import UIKit


func customCollectionViewLayout()-> UICollectionViewCompositionalLayout{
    
    let width = UIScreen.main.bounds.width
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = .init(top: 5, leading: 2.5, bottom: 10, trailing: 2.5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((width/4) + 20), heightDimension: .absolute(65))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    
    return UICollectionViewCompositionalLayout(section: section)
}
