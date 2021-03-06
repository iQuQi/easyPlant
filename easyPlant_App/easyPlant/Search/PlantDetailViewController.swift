//
//  PlantDetailViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit
import FirebaseAuth

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var superstackView: UIStackView!
    @IBOutlet var stackViewList: [UIStackView]!
    var detailPlantName: String?
    var detailPlantType: String?
    var index1 = 0
    var index2 = 0
    @IBOutlet weak var plantDetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //먼저 해당하는 plant의 인덱스를 찾는다
        if let nameData = detailPlantName, let typeData = detailPlantType{
            for (i,typeString) in plantType.type.enumerated(){
                if typeString == typeData {
                    index1 = i
                    break
                }
            }
            for (i,plant) in plantType.plantAll[index1].enumerated(){
                if plant.dic["cntntsSj"] == nameData {
                    index2 = i
                    break
                }
            }
            
            //찾은 인덱스를 통해서 데이터를 가져온다
            let tmpImage = UIImageView()
            do{
                //사진을 원격에서 가져오고 크기 설정을 해준다.
                let data = try Data(contentsOf: URL(string: imageURL+plantType.plantAll[index1][index2].dic["rtnStreFileNm"]!)!)
                tmpImage.image = UIImage(data: data)
                let newWidth = self.view.frame.size.width
              
                let scale = (newWidth / tmpImage.image!.size.width)
                let newHeight = tmpImage.image!.size.height * scale
                UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
                
                tmpImage.image!.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                plantDetailImage.image = newImage


              

            }catch let err{
                print(err.localizedDescription)
            }
            
            
            //기타 UI 설정
            plantDetailImage.layer.cornerRadius = 0
            plantDetailImage.layer.borderColor = UIColor.lightGray.cgColor
            plantDetailImage.layer.borderWidth = 0.5
     
            contentView.layer.cornerRadius = 30
            contentView.layer.borderColor = UIColor.white.cgColor
            contentView.layer.borderWidth = 1
            contentView.layer.zPosition = 2
            plantDetailImage.layer.zPosition = 1
            contentLoad(plantType.plantAll[index1][index2])
        }
    }
  
    
    //현재 식물에 대한 정보를 읽어와서 페이지에 표시한다
    func contentLoad(_ plant :Plant){
        for (index,key) in keyArray.enumerated() {
            if index > 39 {
                break
            }
            
            if plant.dic[key] != "" {
                stackViewList[index].subviews[0].setValue(plantKey[key], forKey: "text")
                stackViewList[index].subviews[1].setValue(plant.dic[key], forKey: "text")
                //print(stackViewList[index].subviews[0])
                //print(stackViewList[index].subviews[1])

            }
            else{
                //존재하지 않는 데이터는 표시하지 않는다
                stackViewList[index].isHidden = true
            }
        }
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode =  .never
        
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? EditUserPlantTableViewController {
            vc.editPlant = UserPlant()
            vc.speciesTmp = self.detailPlantName
            vc.isEdit = false
            vc.isFromSearch = true
       
        }
        
        
    }
 
    @IBAction func addPlantBtnTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        
        performSegue(withIdentifier: "toEditPlant", sender: self)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "로그인이 필요한 서비스입니다", message: "로그인 후 이용바랍니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
}
