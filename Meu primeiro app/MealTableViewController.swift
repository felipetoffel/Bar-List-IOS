//
//  MealTableViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 05/02/20.
//  Copyright © 2020 teste. All rights reserved.
//
import os.log
import UIKit

class MealTableViewController: UITableViewController {
    //MARK: Properties
    
    var meals = [Bar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }
        else {
            // Load the sample data.
            loadSampleMeals()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.RtingControl.rating = meal.rating
        return cell
    }
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveMeals()
        }
    }
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "barinho")
        let photo2 = UIImage(named: "barinho3")
        let photo3 = UIImage(named: "barinho4")
        
        guard let meal1 = Bar(name: "Bar do Chero", photo: photo1, rating: 4, Telefone:"4792214578",Longitude: 00.0001,Latitude:000.00001, Endereco: "Rua frederico marv") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Bar(name: "Bar da Cari", photo: photo2, rating: 5,Telefone:"4733375570",Longitude: 00.0002,Latitude:000.00002, Endereco: "Rua Carlos Roesel") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Bar(name: "Bar do Xerife", photo: photo3, rating: 3,Telefone:"4733371145",Longitude: 00.0003,Latitude:000.00003, Endereco: "Rua Marevoa derv") else {
            fatalError("Unable to instantiate meal2")
        }
        meals = [meal1,meal2,meal3]
        
        
    }
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var identifier = segue.identifier;
        print("-------"+identifier!)
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    private func loadMeals() -> [Bar]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
}
