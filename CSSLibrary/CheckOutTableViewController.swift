//
//  CheckOutTableViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class CheckOutTableViewController: UITableViewController {

    private var result:String=""
    private var record:[String]=[]
    private var column:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let stringURL="http://220.149.124.129:8080/CSSLibrary/checkout.jsp?id="+UserDefaults.standard.string(forKey: "id")!
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                result=result.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        record=result.components(separatedBy: ":")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        CheckOut()
        self.record=self.result.components(separatedBy: ":")
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return record.count-1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CheckOutTableViewCell
        column=record[indexPath.row].components(separatedBy: ";")
        // Configure the cell...
        cell.type.text=column[0]
        cell.title.text=column[1]
        cell.author.text=column[2]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell=tableView.cellForRow(at: indexPath) as! CheckOutTableViewCell
        let alert=UIAlertController(title: "안내", message: cell.title.text!+"\n이 책을 반납합니다.", preferredStyle: .alert)
        let yesAction=UIAlertAction(title: "확인", style: .default){(action: UIAlertAction) -> Void in
            //서버 통신
            var stringURL="http://220.149.124.129:8080/CSSLibrary/update2.jsp?"
            stringURL.append("type="+cell.type.text!)
            stringURL.append("&title="+cell.title.text!)
            stringURL.append("&author="+cell.author.text!)
            stringURL.append("&id="+UserDefaults.standard.string(forKey: "id")!)
            stringURL.append("&name="+UserDefaults.standard.string(forKey: "name")!)
            stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url=URL(string: stringURL){
                if let data=NSData(contentsOf: url){
                    _=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                }
            }
            let alert=UIAlertController(title: "안내", message: "반납하였습니다.", preferredStyle: .alert)
            let action=UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion: nil)
            self.CheckOut()
            self.record=self.result.components(separatedBy: ":")
            tableView.reloadData()
            
        }
        let noAction=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
  
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
        
    func CheckOut(){
        let stringURL="http://220.149.124.129:8080/CSSLibrary/checkout.jsp?id="+UserDefaults.standard.string(forKey: "id")!
            if let url=URL(string: stringURL){
                if let data=NSData(contentsOf: url){
                    result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                    result=result.trimmingCharacters(in: .whitespacesAndNewlines)
                }
        }

    }

}

