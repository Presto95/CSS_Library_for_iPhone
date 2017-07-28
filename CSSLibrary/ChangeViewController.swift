//
//  ChangeViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var changePassword: UITextField!
    @IBOutlet weak var changecheckPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonConfirm(_ sender: UIButton) {
        var temp:String=""
        
        if(currentPassword.text!=="" || changePassword.text!=="" || changecheckPassword.text!==""){
            let alert=UIAlertController(title: "안내", message: "값을 입력해 주세요.", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
        else if(changePassword.text! != changecheckPassword.text!){
            let alert=UIAlertController(title: "안내", message: "새 비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        }
        else{
            var stringURL="http://220.149.124.129:8080/CSSLibrary/change.jsp?"
            stringURL.append("currentPassword="+currentPassword.text!)
            stringURL.append("&changePassword="+changePassword.text!)
            stringURL.append("&confirmPassword="+changecheckPassword.text!)
            stringURL.append("&id="+UserDefaults.standard.string(forKey: "id")!)
            if let url=URL(string: stringURL){
                if let data=NSData(contentsOf: url){
                    temp=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                    temp=temp.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            if(temp==""){
                let alert=UIAlertController(title: "안내", message: "인터넷 연결을 확인해 주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion: nil)
            }
            else if(temp=="true"){
                let alert=UIAlertController(title: "안내", message: "비밀번호를 변경하였습니다.", preferredStyle: UIAlertControllerStyle.alert)
                let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(action: UIAlertAction)-> Void in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                self.present(alert,animated: true, completion: nil)
            }
            else if(temp=="false" || temp=="noId"){
                let alert=UIAlertController(title: "안내", message: "현재 비밀번호가 일치하지 않습니다.", preferredStyle: UIAlertControllerStyle.alert)
                let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion: nil)
            }
            else{
                let alert=UIAlertController(title: "안내", message: "???", preferredStyle: UIAlertControllerStyle.alert)
                let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion: nil)
            }

        }
        
    }

}
