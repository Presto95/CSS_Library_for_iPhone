//
//  CheckInTableViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class CheckInTableViewController: UITableViewController {

    private var keyword:String=""
    private var isSearched:Bool=false
    
    private var result:String=""
    private var record:[String]=[]
    private var column:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var stringURL="http://220.149.124.129:8080/CSSLibrary/checkin.jsp?type=제목&keyword= "
        stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                self.result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                self.result=self.result.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if(isSearched){
            Search()
        }
        isSearched=false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CheckInTableViewCell

        // Configure the cell...
        column=record[indexPath.row].components(separatedBy: ";")
        cell.type.text=column[0]
        cell.title.text=column[1]
        cell.author.text=column[2]
        cell.amount.text=column[3]+"권"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell=tableView.cellForRow(at: indexPath) as! CheckInTableViewCell
        if(cell.amount.text!=="0권"){
            let alert=UIAlertController(title: "안내", message: "보유하고 있지 않아 대출할 수 없습니다.", preferredStyle: .alert)
            let action=UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true, completion: nil)
            return
        }
        let alert=UIAlertController(title: "안내", message: cell.title.text!+"\n\n이 책을 대출합니다.", preferredStyle: .alert)
        let yesAction=UIAlertAction(title: "확인", style: .default){(action: UIAlertAction) -> Void in
            
            var stringURL="http://220.149.124.129:8080/CSSLibrary/insert.jsp?"
            stringURL.append("id="+UserDefaults.standard.string(forKey: "id")!)
            stringURL.append("&type="+cell.type.text!)
            stringURL.append("&title="+cell.title.text!)
            stringURL.append("&author="+cell.author.text!)
            stringURL.append("&name="+UserDefaults.standard.string(forKey: "name")!)
            stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url=URL(string: stringURL){
                if let data=NSData(contentsOf: url){
                    _=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                }
            }
            
            var stringURL2="http://220.149.124.129:8080/CSSLibrary/update.jsp?title="+cell.title.text!+"&amount="+cell.amount.text!
            stringURL2=stringURL2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url=URL(string: stringURL2){
                if let data=NSData(contentsOf: url){
                    _=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                }
            }
            let alert=UIAlertController(title: "안내", message: "대출하였습니다.", preferredStyle: .alert)
            let action=UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
            self.Search()
            
            
        }
        let noAction=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert,animated: true, completion: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    @IBAction func search(_ sender: UIBarButtonItem) {
        let alert=UIAlertController(title: "검색", message: "도서 제목 키워드을 입력하세요.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: nil)
        let yesAction=UIAlertAction(title: "확인", style: UIAlertActionStyle.default){(action: UIAlertAction)-> Void in
            if let input=alert.textFields![0].text{
                self.keyword=input
                //통신
                /*var stringURL="http://220.149.124.129:8080/CSSLibrary/checkin.jsp?type=제목&keyword="+input
                stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                if let url=URL(string: stringURL){
                    if let data=NSData(contentsOf: url){
                        self.result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                        self.result=self.result.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
                self.record=self.result.components(separatedBy: ":")
                self.tableView.reloadData()
                self.isSearched=true
            }
            else{
                let alert=UIAlertController(title: "안내", message: "값을 입력하세요.", preferredStyle: .alert)
                let action=UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true, completion: nil)*/
                if(input.trimmingCharacters(in: .whitespaces)==""){
                    let alert=UIAlertController(title: "안내", message: "값을 입력하세요.", preferredStyle: .alert)
                    let action=UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true, completion: nil)
                    return
                }
                self.isSearched=true
                self.Search()
            }
            
        }
        let noAction=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert,animated: true, completion: nil)
    }
    
    func Search(){
        var stringURL="http://220.149.124.129:8080/CSSLibrary/checkin.jsp?type=제목&keyword="+keyword
        stringURL=stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                self.result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                self.result=self.result.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        if(result==""){
            let alert=UIAlertController(title: "안내", message: "검색 결과가 없습니다.", preferredStyle: .alert)
            let action=UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            self.record=self.result.components(separatedBy: ":")
            self.tableView.reloadData()
        }
        
    }

}
