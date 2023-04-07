//
//  JoinViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/10.
//

import UIKit
import FirebaseAuth

class JoinViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        joinBtn.layer.cornerRadius = 15
        
        IDField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: IDField.frame.size.height, width: IDField.layer.frame.width, height: 1)
        IDField.layer.addSublayer((border))
        border.backgroundColor = UIColor.lightGray.cgColor
        
        pwField.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: pwField.frame.size.height-1, width: pwField.layer.frame.width, height: 1)
        border2.backgroundColor = UIColor.lightGray.cgColor
        pwField.layer.addSublayer((border2))
        
        nameField.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: nameField.frame.size.height-1, width: nameField.layer.frame.width, height: 1)
        border3.backgroundColor = UIColor.lightGray.cgColor
        nameField.layer.addSublayer((border3))
        
        pwCheckField.borderStyle = .none
        let border4 = CALayer()
        border4.frame = CGRect(x: 0, y: pwCheckField.frame.size.height-1, width: pwCheckField.layer.frame.width, height: 1)
        border4.backgroundColor = UIColor.lightGray.cgColor
        pwCheckField.layer.addSublayer((border4))
    }
    
    @IBAction func joinBtnTapped(_ sender: Any) {
        if nameField.text! == "" {
            showAlert(message: "이름을 입력해주세요")
            return
        }
        if IDField.text! == "" {
            showAlert(message: "아이디를 입력해주세요")
            return
        }
        
        if pwField.text! == "" {
            showAlert(message: "비밀번호를 입력해주세요")
            return
        }
        
        if pwCheckField.text! == "" {
            showAlert(message: "비밀번호 확인란을 입력해주세요")
            return
        }
        
        if pwField.text! != pwCheckField.text! {
            showAlert(message: "비밀번호가 맞지 않습니다")
            return
        }
        
        Auth.auth().createUser(withEmail: IDField.text!, password: pwField.text!) {
            (user, error) in
            
            if error != nil {
//                if let errorNo = AuthErrorCode(AuthErrorCode.Code(rawValue: error!._code)) {
//                    switch errorNo {
//                    case AuthErrorCode.invalidEmail:
//                        self.showAlert(message: "유효하지 않은 이메일 입니다")
//                    case AuthErrorCode.emailAlreadyInUse:
//                        self.showAlert(message: "이미 가입된 아이디입니다.")
//                    case AuthErrorCode.weakPassword:
//                        self.showAlert(message: "6자리 이상의 비밀번호를 입력해주세요")
//                    default:
//                        print(errorNo)
//                    }
//                }
            } else {
                if user != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.nameField.text!
                    changeRequest?.commitChanges(completion: nil)
                    
                    myUser = User(Date())
                    userPlants = []
                    myUser.updateUser()
                    saveUserInfo(user: myUser)
                    saveNewUserPlant(plantsList: userPlants, archiveURL: archiveURL)
                    
                    Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                    let alert = UIAlertController(title: "환영합니다! 회원가입이 완료되었습니다", message: "가입하신 이메일로 가입완료메일 확인 후 지금 바로 easyPlant를 시작해보세요!", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)

                            }))
                    self.present(alert, animated: true, completion: {})
                    
                    print("회원가입 성공")
                } else {
                    self.showAlert(message: "회원가입 실패 (뜨면 안되는 문구)")
                    print("회원가입 실패")
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "회원가입에 실패하였습니다", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
