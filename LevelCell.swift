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
        
        previewImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))

        previewImageView.contentMode = .scaleAspectFit
        contentView.addSubview(previewImageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: previewImageView.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
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
