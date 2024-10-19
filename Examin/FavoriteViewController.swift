import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [String]()
    var selectedItems = [NSManagedObject]() // To keep track of Core Data objects for deletion

    func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext

        let request = NSFetchRequest<NSManagedObject>(entityName: "Char") // select * from Char

        do {
            let resultReq = try managedContext.fetch(request)
            selectedItems = resultReq // Store fetched objects for deletion
            items = resultReq.compactMap { $0.value(forKey: "name") as? String } // Extract names
            
        } catch {
            print("fetch error")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Reload your table view here if you have one (not shown in the provided code)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fcell")!
        let contentView = cell.contentView
        let itemLabel = contentView.viewWithTag(1) as! UILabel
        let itemImage = contentView.viewWithTag(2) as! UIImageView
        
        itemLabel.text = items[indexPath.row]
        itemImage.image = UIImage(named: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Show confirmation alert before deleting
            let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete \(items[indexPath.row]) from favorites?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                // Proceed with deletion if confirmed
                guard let self = self else { return }
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let persistentContainer = appDelegate.persistentContainer
                let managedContext = persistentContainer.viewContext

                // Get the object to delete
                let objectToDelete = self.selectedItems[indexPath.row]

                managedContext.delete(objectToDelete)

                do {
                    // Save the context after deletion
                    try managedContext.save()
                    print("Deleted item successfully.")
                    
                    // Remove from the array and table view
                    self.items.remove(at: indexPath.row)
                    self.selectedItems.remove(at: indexPath.row) // Update the array of Core Data objects
                    
                    tableView.deleteRows(at: [indexPath], with: .fade) // Animate the deletion
                } catch {
                    print("Failed to delete the item: \(error)")
                }
            }))

            // Present the alert
            present(alert, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
