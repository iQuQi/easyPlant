//
//  uerPlantsCollectionViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

private let reuseIdentifier = "userPlantCell"

let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("savingUserPlants.json")


class UserPlantCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userPlantCollectionView: UICollectionView!

  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
//        saveNewUserPlant(plantsList: userPlants, archiveURL: archiveURL)
        
        
        loadUserPlant()
        print("user plant load finish")
//        view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
   
//        userPlantCollectionView.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
        
        userPlantCollectionView.reloadData()
        print("user plant reload data finish")

       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPlantCollectionView.reloadData()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       // #warning Incomplete implementation, return the number of sections

       return 1
   }


   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of items
    return userPlants.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPlantCollectionViewCell

  
        print("user plant update before")
    
        let userplant = userPlants[indexPath.row]
        cell.update(info: userplant)
        print("user plant update finish")

   
       
       return cell
   }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
   

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let width  = (userPlantCollectionView.frame.width-10)/2
        
    
        return CGSize(width: width, height: width*1.3)
        }

    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? MyPlantViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  userPlantCollectionView.indexPath(for: cell) {
            detailVC.myPlant = userPlants[indexPath.item]
            print("user plant prepare1 finish")

        }
        
        
        if segue.identifier == "makeNewUserPlant"{
            if let detailVC = segue.destination as?  EditUserPlantTableViewController{
                detailVC.editPlant = UserPlant()
                detailVC.isEdit = false
                print("user plant prepare2 finish")

                
                
            }
        }
        


    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        return CGSize(width: 20, height: 20)
//
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
        
   
    @IBAction func unwindToUserPlants(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        userPlantCollectionView.reloadData()
        
    }
    
    
    @IBAction func unwindToNewPlantsList(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        userPlantCollectionView.reloadData()
    }
    
    
    
    
    
}


