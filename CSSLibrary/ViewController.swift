//
//  ViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 26..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var textLoginId: UITextField!
    @IBOutlet weak var textLoginPassword: UITextField!
    @IBOutlet weak var switchSave: UISwitch!
    
    private var temp:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        if(UserDefaults.standard.bool(forKey: "isId")){
            switchSave.setOn(true, animated: true)
            textLoginId.text=UserDefaults.standard.string(forKey: "id")
        }
        else{
            textLoginId.text=""
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!Reachability.isConnectedToNetwork()){
            let alert=UIAlertController(title: "안내", message: "인터넷 연결을 확인하세요.", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(UIAlertAction)->Void in
                exit(0)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }

        if(UserDefaults.standard.bool(forKey:"autoLogin")){
            let storyboard:UIStoryboard = self.storyboard!
            let nextView=storyboard.instantiateViewController(withIdentifier: "MainView")
            self.present(nextView, animated: true, completion: nil)
        }
    }
       

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonLogin(_ sender: UIButton) {
        
        let stringURL="http://220.149.124.129:8080/CSSLibrary/login.jsp?loginId="+textLoginId.text!+"&loginPassword="+textLoginPassword.text!
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                temp=NSString(data: data as Data, encoding:String.Encoding.utf8.rawValue) as String!
                temp=temp.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        if(temp=="false"){
            let alert=UIAlertController(title: "안내", message: "로그인 실패", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if(temp==""){
            let alert=UIAlertController(title: "안내", message: "인터넷 연결을 확인해 주세요.", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title:"확인", style: UIAlertActionStyle.default){(action: UIAlertAction) -> Void in
                exit(0)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert=UIAlertController(title: "안내", message: "로그인!", preferredStyle: UIAlertControllerStyle.alert)
            let action=UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(action: UIAlertAction)-> Void in
                if(self.switchSave.isOn==true){
                    UserDefaults.standard.set(self.textLoginId.text,forKey:"id")
                    UserDefaults.standard.set(true,forKey:"isId")
                }
                else{
                    UserDefaults.standard.set(false,forKey:"isId")
                }
                UserDefaults.standard.set(self.textLoginId.text,forKey:"id")
                UserDefaults.standard.set(self.temp,forKey:"name")
                let storyboard:UIStoryboard = self.storyboard!
                let nextView=storyboard.instantiateViewController(withIdentifier: "MainView")
                self.present(nextView, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public class Reachability {
        
        class func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
    }
}

