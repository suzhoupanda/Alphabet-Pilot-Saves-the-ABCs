//
//  ResourceLoadableType.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation

protocol ResourceLoadableType: class{
    
    //Indicates that static resources need to be loaded
    
    static var resourcesNeedLoading: Bool { get }
    
    //Loades resources into memory
    
    static func loadResources(withCompletionHandler completionHandler: @escaping () -> ())
    
    //Releases any static resources that can be loaded again later
    
    static func purgeResoures()
    
}
