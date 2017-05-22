//
//  HelpDetailController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class HelpDetailController: UIViewController, UIScrollViewDelegate{
    
    typealias QuestionAnswerSet = [[String:String]]
    
    var QASet: QuestionAnswerSet!
    
    var mainStackView: UIStackView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let backItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HelpDetailController.returnToHelpTopicsMenu))
        backItem.title = "Back to Help Topics Menu"
        
        toolbar.setItems([backItem], animated: true)
        view.addSubview(toolbar)
        
        toolbar.backgroundColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView = UIStackView()
        view.addSubview(mainStackView)
        
        
        
        
        
        NSLayoutConstraint.activate([
            //Configure constraints for navigation bar
            toolbar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            toolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolbar.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolbar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            //Configure constraints for scroll view
            mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.00),
            mainStackView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.00),
            mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20.00)
            
            ])
      
       
      
        view.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        mainStackView.backgroundColor = UIColor.GetCustomColor(customColor: .SharkFinWhite)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        
       mainStackView.backgroundColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        
        for QADict in QASet{
            
            let questionLabel = UILabel()
            questionLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 20.0)
            questionLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
            questionLabel.text = QADict["Question"]!
            questionLabel.textAlignment = .left
            questionLabel.numberOfLines = 0
            questionLabel.lineBreakMode = .byWordWrapping
            questionLabel.setContentCompressionResistancePriority(100, for: .vertical)
            questionLabel.setContentHuggingPriority(120, for: .vertical)
            questionLabel.sizeToFit()
            
            let answerLabel = UILabel()
            answerLabel.font = UIFont(name: "Avenir-Book ", size: 15.0)
            answerLabel.text = QADict["Answer"]!
            answerLabel.textAlignment = .left
            answerLabel.numberOfLines = 0
            answerLabel.lineBreakMode = .byWordWrapping
            answerLabel.setContentCompressionResistancePriority(120, for: .vertical)
            answerLabel.setContentHuggingPriority(100, for: .vertical)
            answerLabel.sizeToFit()
            
            let QAStackView = UIStackView(arrangedSubviews: [questionLabel, answerLabel])
            QAStackView.backgroundColor = UIColor.GetCustomColor(customColor: .BluishGrey)
            
            QAStackView.axis = .vertical
            QAStackView.distribution = .fillProportionally
            
            
            mainStackView.addArrangedSubview(QAStackView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
  
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
    
    func returnToHelpTopicsMenu(){
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK: ScrollViewDelegate Methods

extension HelpDetailController{

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 300.00{
            scrollView.setContentOffset(CGPoint(x: 300.0, y: 0.00), animated: true)
        }
      
    }
    
}
