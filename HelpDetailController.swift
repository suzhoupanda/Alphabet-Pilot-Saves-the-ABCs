//
//  HelpDetailController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import UIKit


class HelpDetailController: UICollectionViewController{
    
    typealias QuestionAnswerSet = [[String:String]]
    
    var QASet: QuestionAnswerSet!
    
    /**
    var mainStackView: UIStackView!
    var toolbar: UIToolbar!
    
    var mainStackViewConstraints: [NSLayoutConstraint]{
        get{
            return [
                mainStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.00),
                mainStackView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
                mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.00),
                mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20.00)
            ]
        }
    }
    **/
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /**
        toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let backItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HelpDetailController.returnToHelpTopicsMenu))
        backItem.title = "Back to Help Topics Menu"
        
        toolbar.setItems([backItem], animated: true)
        view.addSubview(toolbar)
        
        toolbar.backgroundColor = UIColor.GetCustomColor(customColor: .GrassyGreen)
        

        mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStackView)
        
        
        
        
        
        NSLayoutConstraint.activate([
            //Configure constraints for navigation bar
            toolbar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            toolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolbar.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolbar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            
            ])
      
       NSLayoutConstraint.activate(mainStackViewConstraints)
      
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
 
        **/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        /**
        let removeConstraintsOperationQueue = OperationQueue()
        removeConstraintsOperationQueue.addOperation {
            NSLayoutConstraint.deactivate(self.mainStackViewConstraints)
        }
        
        removeConstraintsOperationQueue.waitUntilAllOperationsAreFinished()
        **/
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "QACell")
       
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


//MARK: CollectionView DataSource Methods

extension HelpDetailController{
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QASet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QACell", for: indexPath)
        
        let QAPair = QASet[indexPath.row]
        
        configureCell(forCollectionViewCell: &cell, andForQAPair: QAPair)
        
        return cell
    }
    
    func configureCell(forCollectionViewCell cell: inout UICollectionViewCell, andForQAPair QAPair: [String:String]){
        
        cell.backgroundColor = UIColor.GetCustomColor(customColor: .BluishGrey)
        
        let question = QAPair["Question"]
        let answer = QAPair["Answer"]
        
        let questionLabel = UILabel()
        questionLabel.text = question
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.font = UIFont(name: "Avenir-HeavyOblique", size: 20.0)
        questionLabel.textColor = UIColor.GetCustomColor(customColor: .StopSignRed)
        questionLabel.setContentHuggingPriority(110, for: .vertical)
        questionLabel.setContentCompressionResistancePriority(90, for: .vertical)
        
        let answerLabel = UILabel()
        answerLabel.text = answer
        answerLabel.numberOfLines = 0
        answerLabel.font = UIFont(name: "Avenir-Book", size: 15.0)
        answerLabel.lineBreakMode = .byWordWrapping
        answerLabel.setContentHuggingPriority(90, for: .vertical)
        answerLabel.setContentCompressionResistancePriority(110, for: .vertical)
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(answerLabel)
        
        cell.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10.00),
            stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10.00),
            stackView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 10.00),
            stackView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -10.00)
            
            ])
        
        
        cell.contentView.layoutSubviews()
    }


    /**
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 300.00{
            scrollView.setContentOffset(CGPoint(x: 300.0, y: 0.00), animated: true)
        }
      
    }
    **/
}
