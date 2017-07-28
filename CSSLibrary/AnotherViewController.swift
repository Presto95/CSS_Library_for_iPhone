//
//  AnotherViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class AnotherViewController: UITableViewController {

    @IBOutlet weak var switchAutoLogin: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.bool(forKey:"autoLogin")){
            switchAutoLogin.setOn(true, animated: true)
        }
        else{
            switchAutoLogin.setOn(false, animated: true)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        switch(indexPath.row){
        case 0: break   //자동로그인
        case 1: break   //비밀번호변경
        case 2: break   //버그리포트
        case 3: break   //CSS스케줄러
        case 4: //CSS클럽접속
            let url=NSURL(string: "http://club.cyworld.com/ClubV1/Home.cy/53489439")
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            break
        case 5:    //만든사람들
            let alert=UIAlertController(title: "Project [CSS Library]", message: "Developer\n9th LEE Han Gyeol\n\nThanks To\n4th KIM Jong Hoon\n6th KIM Shin Woo",preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion: nil)
            break
        case 6: //버전정보
            let alert=UIAlertController(title: "버전 정보", message: "v 1.0.0\n첫 배포",preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion: nil)
            break
        case 7: //종료
            let alert=UIAlertController(title: "안내", message: "어플리케이션을 종료합니다.", preferredStyle: UIAlertControllerStyle.alert)
            let yesAction=UIAlertAction(title:"확인",style: UIAlertActionStyle.default){(action: UIAlertAction) -> Void in
                exit(0)
            }
            let noAction=UIAlertAction(title:"취소", style:UIAlertActionStyle.cancel)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.present(alert,animated:true,completion:nil)
            break
        default: break
        }
    }
    @IBAction func isAutoLogin(_ sender: UISwitch) {
        if(sender.isOn){
            UserDefaults.standard.set(true, forKey: "autoLogin")
        }
        else{
            UserDefaults.standard.set(false,forKey: "autoLogin")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
