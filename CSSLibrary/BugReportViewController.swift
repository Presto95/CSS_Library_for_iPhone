//
//  BugReportViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//
import MessageUI

import UIKit

class BugReportViewController: UIViewController, MFMailComposeViewControllerDelegate {

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
    @IBAction func clickButton(_ sender: UIButton) {
        let mc=MFMailComposeViewController()
        mc.mailComposeDelegate=self
        mc.setToRecipients(["yoohan95@gmail.com"])
        mc.setSubject("CSS "+UserDefaults.standard.string(forKey: "name")!+" 버그 제보합니다.")
        mc.setMessageBody("내용을 입력하세요.", isHTML: false)
        if MFMailComposeViewController.canSendMail(){
            self.present(mc,animated: true, completion: nil)
        }
        /*else{
            let alertcontroller: UIAlertController=UIAlertController(title: "메일 보내기", message: "현재 디바이스에서 이메일을 보낼 수 없습니다. 설정에서 관련 설정을 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            let defaultAction=UIAlertAction(title: "확인", style: .default, handler: {
                (alert: UIAlertAction!) in
            })
            alertcontroller.addAction(defaultAction)
            present(alertcontroller,animated: true,completion: nil)
            
        }*/
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
