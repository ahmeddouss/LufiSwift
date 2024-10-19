//  DetailsViewController.swift
//  Examin
//
//  Created by ahmed douss on 16/10/2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    var itemCharacter: Character?
    var index = 0

    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageback: UIImageView!
    
    // Outlets for the buttons
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial content
        updateContent()

        // Hide buttons initially if conditions are not met
        updateButtonVisibility()
    }

    func updateContent() {
        image.image = UIImage(named: itemCharacter!.images[index])
        label.text = itemCharacter!.name
        desc.text = itemCharacter!.details
        imageback.image = UIImage(named: itemCharacter!.images[index])
    }
    
    func updateButtonVisibility() {
        // Example condition: hide 'Next' button if last image is reached
        nextButton.isHidden = (index >= itemCharacter!.images.count - 1)
        
        // Example condition: hide 'Previous' button if first image is shown
        previousButton.isHidden = (index == 0)
        
        // Custom condition for addFavoriteButton (e.g., check if character is already favorited)
        // addFavoriteButton.isHidden = yourConditionForFavorites
    }

    @IBAction func NextB(_ sender: Any) {
        if index < itemCharacter!.images.count - 1 {
            index += 1
            updateContent()
            updateButtonVisibility()
        }
    }

    @IBAction func PreviousB(_ sender: Any) {
        if index > 0 {
            index -= 1
            updateContent()
            updateButtonVisibility()
        }
    }

    @IBAction func addfavorite(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        // Assuming itemCharacter is your selected character
        let characterSelected = itemCharacter?.name
        
        // Create a fetch request to check if the character already exists
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Char")
        fetchRequest.predicate = NSPredicate(format: "name == %@", characterSelected ?? "")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            if results.isEmpty {
                // Character does not exist, so add it to favorites
                let entityDescription = NSEntityDescription.entity(forEntityName: "Char", in: managedContext)
                let object = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
                object.setValue(characterSelected, forKey: "name")
                
                // Save the managed context to persist the data
                try managedContext.save()
                print("INSERT good")
                
                // Show alert that the character is added to favorites
                showFavoriteAlert(characterName: characterSelected ?? "Char")
            } else {
                // Character already exists in favorites
                showAlreadyInFavoritesAlert(characterName: characterSelected ?? "Char")
            }
        } catch {
            print("FETCH failed")
        }
    }
    
    func showFavoriteAlert(characterName: String) {
            let alert = UIAlertController(title: "Added to Favorites", message: "\(characterName) added to favorite", preferredStyle: .alert)
            
            // Add an "OK" button to dismiss the alert
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            // Present the alert on the top view controller
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first,
               let rootViewController = window.rootViewController {
                
                var topController = rootViewController
                // Find the topmost view controller to present the alert
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                topController.present(alert, animated: true, completion: nil)
            }
    }
        
    func showAlreadyInFavoritesAlert(characterName: String) {
        let alert = UIAlertController(title: "Already in Favorites", message: "\(characterName) is already in your favorites.", preferredStyle: .alert)
        
        // Add an "OK" button to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert on the top view controller
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let rootViewController = window.rootViewController {
            
            var topController = rootViewController
            // Find the topmost view controller to present the alert
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
}
