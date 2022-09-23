//
//  SeasonCell.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 22/09/2022.
//

import UIKit

class SeasonCell: UICollectionViewCell {

    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Outlets
    //-----------------------------------------------------------------------------------
    
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    static let  cellId = "SeasonCell"
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -
    //-----------------------------------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
    }
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  ISSelected Options
    //-----------------------------------------------------------------------------------
    override var isSelected: Bool{
        didSet{
            self.backView.backgroundColor = isSelected ? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1):#colorLiteral(red: 0.3529162082, green: 0.4821025247, blue: 1, alpha: 0.5)
        }
    }
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Configure Cell
    //-----------------------------------------------------------------------------------
    func configure(_ season: String){
        self.seasonLabel.text = season.capitalized
    }

}
