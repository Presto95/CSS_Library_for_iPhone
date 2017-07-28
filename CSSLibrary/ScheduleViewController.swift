//
//  ScheduleViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    private var result:String=""
    private var record:[String]=[]
    private var column:[String]=[]
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var contents: UILabel!
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
    @IBAction func datePicker(_ sender: UIDatePicker) {
        var date:String
        var realDate:[String]
        var year:Int
        var month:Int
        var day:Int
        let formatter=DateFormatter()
        formatter.dateFormat="yyyy-MM-dd"
        date=formatter.string(from: sender.date)
        realDate=date.components(separatedBy: "-")
        year=Int(realDate[0])!
        month=Int(realDate[1])!
        day=Int(realDate[2])!
        self.date.text = "\(year)년 \(month)월 \(day)일"
        var stringURL="http://220.149.124.129:8080/CSSLibrary/schedule.jsp?"
        stringURL.append("year=\(year)")
        stringURL.append("&month=\(month)")
        stringURL.append("&day=\(day)")
        stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                result=result.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        if(result==""){
            self.contents.text="데이터 없음"
        }
        else{
            self.contents.text=""
            self.record=self.result.components(separatedBy: ":")
            for i in 0..<self.record.count-1{
                self.column = self.record[i].components(separatedBy: ";")
                for j in 0...1{
                    self.contents.text! += self.column[j]+"\n"
                }
                self.contents.text!+="\n"
            }
        }
        
    }

}
