//
//  LevelCell.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit

class LevelCell: UICollectionViewCell{
    
    private var previewImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    
    
    var previewImage: UIImage?{
        
        get{
            return previewImageView.image
        }
        
        set(newImage){
            previewImageView.image = newImage
        }
    }
    
    var titleText: String?{
        get{
            return titleLabel.text
        }
        
        set(newText){
            titleLabel.text = newText
        }
    }
    
    var descriptionText: String?{
        get{
            return descriptionLabel.text
        }
        
        set(newDescriptionText){
            descriptionLabel.text = newDescriptionText
        }
    }
    
    var subtitleText: String?{
        get{
            return subtitleLabel.text
        }
        
        set(newSubtitleText){
            subtitleLabel.text = newSubtitleText
        }
    }
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
       
        previewImageView = UIImageView(frame: CGRect(x: frame.size.width*0.10, y: frame.size.height*0.10, width: frame.size.width*0.80, height: frame.size.height*0.50))
        previewImageView.contentMode = .scaleAspectFit
        contentView.addSubview(previewImageView)
        
        
        titleLabel = UILabel(frame: CGRect(x: frame.size.width*0.00, y: frame.size.height*0.40, width: frame.size.width, height: frame.size.height*0.20))
        titleLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        titleLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 30.0)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        
        subtitleLabel = UILabel(frame: CGRect(x: frame.size.width*0.00, y: frame.size.height*0.65, width: frame.size.width, height: frame.size.height*0.10))
        subtitleLabel.textColor = UIColor.GetCustomColor(customColor: .BluishGrey)
        subtitleLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 25.0)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(subtitleLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: frame.size.width*0.00, y: frame.size.height*0.70, width: frame.size.width, height: frame.size.height*0.30))
        descriptionLabel.textColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        descriptionLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 20.0)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(descriptionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


extension LevelCell{
    
    enum Section: Int{
        case LevelScenes = 0
        case Players
        case Enemies
        case Collectibles
        case BonusLevels
        case CharacterStories
    }
    
    static func gameMetaDataForIndexPath(indexPath: IndexPath) -> GameMetaData?{
        
        guard let section = LevelCell.Section(rawValue: (indexPath as NSIndexPath).section) else {
            print("Error: failed to initialize LevelCell.Section enum type while retrieving game meta data")
            return nil
        }
        
        return LevelCell.metaDataDictionary[section]?[indexPath.row]
    }
    
    static let metaDataDictionary : [Section: [GameMetaData]] = [
        Section.LevelScenes : LevelSceneMetaData.allLevels,
        Section.Players : [],
        Section.Enemies : [],
        Section.Collectibles : [],
        Section.BonusLevels : [],
        Section.CharacterStories : []
    ]
}
