//
//  GameMetaData.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


protocol GameMetaData{
    var previewImage: UIImage { get set }
    var titleText: String { get set }
    var subTitleText: String { get set }
    var descriptionText: String? { get set }
}
