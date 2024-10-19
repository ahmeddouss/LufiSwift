//
//  ViewController.swift
//  Examin
//
//  Created by ahmed douss on 16/10/2024.
//

import UIKit
import CoreData

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
   
    
    
    var characters = ["Monkey D. Luffy","Gol D. Roger","Roronoa Zoro","Portgas D. Ace","Sabo"]
      
        var LuffyImages = ["LuffyImages1", "LuffyImages2","LuffyImages3" ]
        var golDRogerImages = ["golDRogerImages1", "golDRogerImages2","golDRogerImages3" ]
        var portgasDAceImages = ["portgasDAceImages1", "portgasDAceImages2","portgasDAceImages3"]
        var saboImages = ["saboImages1", "saboImages2","saboImages3"]
        var roronoaZoroImages = ["roronoaZoroImages1", "roronoaZoroImages2","roronoaZoroImages3"]
        
        
        
        var monkeyDLuffyDetails = "Monkey D. Luffy is the series' main protagonist, a young pirate who wishes to succeed Gold Roger, the deceased King of the Pirates, by finding his treasure, the 'One Piece'."
        var golDRogerDetails = "Gol D. Roger, after gaining worldwide infamy as captain of the Roger Pirates, becomes better known as Gold Roger, the King of the Pirates."
        var portgasDAceDetails = "Portgas D. Ace, is the biological son of the late Pirate King, Gol D. Roger, and Portgas D. Rouge, as well as the sworn older brother of Luffy and Sabo. Ace was adopted by Monkey D. Garp, as had been requested by Roger before his execution. "

        var saboDetails = "'Flame Emperor' Sabo is the Revolutionary Army's chief of staff, recognized as the No. 2 of the entire organization and outranked only by Supreme Commander Monkey D. Dragon. He is also the sworn brother of the notorious pirates Monkey D. Luffy and the late Portgas D. Ace "
        var roronoaZoroDetails = "Roronoa Zoro is a swordsman who uses up to three swords simultaneously, holding one in each hand and a third in his mouth.To fulfill a promise to Kuina, his deceased childhood friend and rival, he aims to defeat 'Hawk-Eye' Mihawk and become the world's greatest swordsman."
    
  
    var charactersList: [Character] = [
        Character(name: "Monkey D. Luffy", images: ["LuffyImages1", "LuffyImages2", "LuffyImages3"], details: "Monkey D. Luffy is the series' main protagonist, a young pirate who wishes to succeed Gold Roger, the deceased King of the Pirates, by finding his treasure, the 'One Piece'."),
        
        Character(name: "Gol D. Roger", images: ["golDRogerImages1", "golDRogerImages2", "golDRogerImages3"], details: "Gol D. Roger, after gaining worldwide infamy as captain of the Roger Pirates, becomes better known as Gold Roger, the King of the Pirates."),
        
        Character(name: "Portgas D. Ace", images: ["portgasDAceImages1", "portgasDAceImages2", "portgasDAceImages3"], details: "Portgas D. Ace, is the biological son of the late Pirate King, Gol D. Roger, and Portgas D. Rouge, as well as the sworn older brother of Luffy and Sabo. Ace was adopted by Monkey D. Garp, as had been requested by Roger before his execution."),
        
        Character(name: "Sabo", images: ["saboImages1", "saboImages2", "saboImages3"], details: "'Flame Emperor' Sabo is the Revolutionary Army's chief of staff, recognized as the No. 2 of the entire organization and outranked only by Supreme Commander Monkey D. Dragon. He is also the sworn brother of the notorious pirates Monkey D. Luffy and the late Portgas D. Ace."),
        
        Character(name: "Roronoa Zoro", images: ["roronoaZoroImages1", "roronoaZoroImages2", "roronoaZoroImages3"], details: "Roronoa Zoro is a swordsman who uses up to three swords simultaneously, holding one in each hand and a third in his mouth.To fulfill a promise to Kuina, his deceased childhood friend and rival, he aims to defeat 'Hawk-Eye' Mihawk and become the world's greatest swordsman.")
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let contentview = cell.contentView
        let itemLabel = contentview.viewWithTag(2) as! UILabel
        let itemImage = contentview.viewWithTag(1) as! UIImageView
        
        itemLabel.text = charactersList[indexPath.row].name
        itemImage.image = UIImage(named: charactersList[indexPath.row].name)
        return cell
        
        
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let destinationVC = segue.destination as? DetailsViewController {
                destinationVC.itemCharacter = sender! as? Character
            }
        }
    }
    func collectionView(_ CollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: charactersList[indexPath.item])
        
       
        
    }
} 

