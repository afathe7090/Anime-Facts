//
//  AnimeCell.swift
//  Anime-Facts
//
//  Created by Ahmed Fathy on 21/09/2022.
//

import SnapKit
import UIKit
import SkeletonView

class AnimeCell: UITableViewCell {
    
    
    private lazy var animeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode  = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    
    private lazy var animeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 1
        label.isSkeletonable = true
        return label
    }()
    
    private lazy var synopsisLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 2
        label.isSkeletonable = true
        return label
    }()
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //-----------------------------------------------------------------------------------
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        configureLayoutCell()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    //-----------------------------------------------------------------------------------
    //=======>MARK: -  Configure Cell
    //-----------------------------------------------------------------------------------
    private func configureLayoutCell(){
        
        contentView.addSubview(animeImageView)
        animeImageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(15)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.89)
            $0.width.equalTo(100)
        }
        
        contentView.addSubview(animeNameLabel)
        animeNameLabel.snp.makeConstraints({
            $0.centerY.equalTo(animeImageView.snp.centerY).offset(-20)
            $0.leading.equalTo(animeImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
        })
        
        
        contentView.addSubview(synopsisLabel)
        synopsisLabel.snp.makeConstraints {
            $0.top.equalTo(animeNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(animeImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-15)
                    }
        
    }
    
    func setCell(viewModel: Anime){
        self.animeNameLabel.text = viewModel.title
        self.animeImageView.setImage(viewModel.image_url)
        self.synopsisLabel.text = viewModel.synopsis
    }
    
    
}
