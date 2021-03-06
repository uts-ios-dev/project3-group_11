//
//  productTableView.swift
//  ios-group
//
//  Created by Wanlong Cai on 29/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit

class productTableView: UITableViewController {
    @IBOutlet var productTable: UITableView!
    let productlist = StroageUtils.getProduct().sorted(by:<)
    var goId : Int = 0
    struct cellDate {
        var opened = Bool()
        var title = String()
        var sectionDate = [Product]()
    }
    var tableViewDate = [cellDate]()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTable.delegate = self
        productTable.dataSource = self
        tableViewDate = generateDisplayDate()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func generateDisplayDate()->[cellDate]{
        var nearlyExpireSectionDate = [Product]()
         var longExpireSectionDate = [Product]()
        for items in productlist{
            if daysBetween(expireDate: items.timeExpire!) < 30 {
                nearlyExpireSectionDate.append(items)
            }
            else {
                longExpireSectionDate.append(items)
            }
        }
        var tableViewDate = [cellDate]()
        tableViewDate = [cellDate(opened: false, title: "Nearly expired", sectionDate: nearlyExpireSectionDate),
                         cellDate(opened: false, title: "Long time to expire", sectionDate: longExpireSectionDate)
        ]
        return tableViewDate
    }
    
    //calcuate days between two date
    func daysBetween(expireDate: Int) -> Int {
        let endDate = Date(timeIntervalSince1970: Double(expireDate))
         let currentDate = Date()
        let calendar = Calendar.current
        let differentdays = calendar.dateComponents([.day], from: currentDate, to: endDate)
        return differentdays.day!
    }
    
    
    //Add section of table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDate.count
    }
    
    
   
    
    
    
    //Add items to cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDate[section].opened == true{
            return tableViewDate[section].sectionDate.count + 1
        }else{
            return 1
        }
    }

   /* override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "myListSegue")
        cell?.textLabel?.text = productlist[indexPath.row].name
         let endDate = Date(timeIntervalSince1970: Double(productlist[indexPath.row].timeExpire!))
        let currentDate = Date()
        cell?.detailTextLabel?.text = "Expire: " + endDate.offset(from: currentDate )
        return cell!
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let dataIndex = indexPath.row-1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myListSegue") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewDate[indexPath.section].title
            cell.detailTextLabel?.text = ""
            cell.imageView?.image = nil
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "myListSegue") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewDate[indexPath.section].sectionDate[dataIndex].name
            let currentDate = Date()
            let endDate = Date(timeIntervalSince1970: Double(tableViewDate[indexPath.section].sectionDate[dataIndex].timeExpire!))
            cell.detailTextLabel?.text = "Expire: " + endDate.offset(from: currentDate)
            
            cell.imageView?.image = UIImage(contentsOfFile:tableViewDate[indexPath.section].sectionDate[dataIndex].image!)
            //cell.backgroundColor = UIColor.lightGray
            return cell
        }
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let dataIndex = indexPath.row - 1
        if (tableViewDate[indexPath.section].opened == true && indexPath.row == 0){
            tableViewDate[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
          
        }else{
            tableViewDate[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        }
        
         print(dataIndex);
        
        if indexPath.row != 0 {
            
            
             print(tableViewDate[indexPath.section].sectionDate[dataIndex].id)
            
            goDetail(id: tableViewDate[indexPath.section].sectionDate[dataIndex].id!)
        }
//        if tableViewDate[indexPath.section].sectionDate[dataIndex].image != nil {
//            print("sub");
//        }else {
//            print("title");
//        }
    }
    
    func goDetail(id: Int){
           goId = id
          performSegue(withIdentifier: "goEdit", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit" {
            let controller = segue.destination as! EditViewController
            controller.id = self.goId
        }
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
