//
//  CheckInIngTableViewController.swift
//  CSSLibrary
//
//  Created by Han Gyeol Lee on 2017. 7. 28..
//  Copyright © 2017년 Han Gyeol Lee. All rights reserved.
//

import UIKit

class CheckInIngTableViewController: UITableViewController{

    private var result:String=""
    private var record:[String]=[]
    private var column:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let stringURL="http://220.149.124.129:8080/CSSLibrary/checkining.jsp"
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
        let stringURL="http://220.149.124.129:8080/CSSLibrary/checkining.jsp"
        if let url=URL(string: stringURL){
            if let data=NSData(contentsOf: url){
                result=NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as String!
                result=result.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        record=result.components(separatedBy: ":")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CheckInIngTableViewCell

        // Configure the cell...
        column=record[indexPath.row].components(separatedBy: ";")
        /*if let label=cell.viewWithTag(101) as? UILabel{
            label.text=column[0]
        }
        else if let label=cell.viewWithTag(102) as? UILabel{
            label.text=column[3]
        }
        else if let label=cell.viewWithTag(103) as? UILabel{
            label.text=column[2]
        }
        else if let label=cell.viewWithTag(104) as? UILabel{
            label.text=column[1]
        }*/
        cell.type.text=column[0]
        cell.title.text=column[1]
        cell.author.text=column[2]
        cell.name.text=column[3]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

}
