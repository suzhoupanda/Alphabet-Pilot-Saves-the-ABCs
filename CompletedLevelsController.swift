//
//  CompletedLevelsController.swift
//  BadBoy Bunny Alphabet Learner
//
//  Created by Aleksander Makedonski on 5/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CompletedLevelsController: UITableViewController, NSFetchedResultsControllerDelegate{
    
    var managedContext: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController<LevelInformation>!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        }
    
    @IBAction func clearLevelData(_ sender: UIBarButtonItem) {
        
        tableView.endUpdates()
        
        guard let levelInformationArray = fetchedResultsController.fetchedObjects else {
            print("clearLevelData function warning: no data in the fetched results controller")
            return
        }
        
        
        DispatchQueue.global().async {

        
        
            for levelInformation in levelInformationArray{
            
                self.managedContext.delete(levelInformation)
                
                do{
                    
                    try self.managedContext.save()
                    
        
                    
                } catch let error as NSError{
                    print("Error \(error),\(error.localizedDescription)")
                }
                
                

            }
            
            DispatchQueue.main.sync {
                
                self.tableView.reloadData()
            }

        }
        
       
            
            
        
    }
    
    
    @IBAction func returnToLVController(_ sender: UIBarButtonItem) {
        returnToLevelViewController()
    }
    
    func returnToLevelViewController(){
        
        guard let navController = self.navigationController else {
            print("The completeld level controller is not embedded in a navigation controller")
            return
        }
        
        navController.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LevelInformationCell")
        
        let fetchRequest: NSFetchRequest<LevelInformation> = LevelInformation.fetchRequest()
        
        let completionSort = NSSortDescriptor(key: #keyPath(LevelInformation.completed), ascending: false)
        
        let dateSort = NSSortDescriptor(key: #keyPath(LevelInformation.dateCompleted), ascending: true)
        
        fetchRequest.sortDescriptors = [completionSort,dateSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: #keyPath(LevelInformation.completed), cacheName: "levelCompletionStatusCache")
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        } catch let error as NSError{
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
}


//MARK: Data Source Methods

extension CompletedLevelsController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "LevelInformationCell", for: indexPath)
        
        let levelInformation = fetchedResultsController.object(at: indexPath)
        
        configureTableViewCell(forTableViewCell: &cell, withLevelInformationFrom: levelInformation)
        
        return cell
        
    }
    
    
    func configureTableViewCell(forTableViewCell cell: inout UITableViewCell, withLevelInformationFrom levelInformation: LevelInformation){
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if let date = levelInformation.dateCompleted as? Date{
            let dateString = dateFormatter.string(from: date)
            cell.detailTextLabel?.text = dateString
            
            cell.textLabel?.text = "Scene: \(levelInformation.levelScene!), Date Completed: \(dateString)"

        }
       
        
        let completionImage = levelInformation.completed ? #imageLiteral(resourceName: "blue_checkmark") : #imageLiteral(resourceName: "blue_cross")
        cell.accessoryView = UIImageView(image: completionImage)
    
    }
    
}


//MARK:     Conformance with FetchedResultsController Delegate

extension CompletedLevelsController{
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .automatic)
                break
            case .delete:
                let alertController = UIAlertController(title: "Deletion Completed", message: "Level completion status data has been deleted", preferredStyle: .alert)
            
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(okayAction)
                
                present(alertController, animated: true, completion: nil)
            
            default:
                break
        }
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
