//
//  WordTableVC.swift
//  Project1
//
//  Created by Alexia Munoz (RIT Student) on 3/24/17.
//  Copyright © 2017 Alexia Munoz (RIT Student). All rights reserved.
//

import UIKit

class WordTableVC: UITableViewController {
    
    static var wordVC = WordTableVC()
    
    //var vcController = ViewController()
    
  //var SelectedList = wordBank.share.fetchList(category: "comedy")
    
    //Cancel Button
    @IBAction func cancelTapped(sender: AnyObject){
        ViewController().placeWords()
        dismiss(animated: true, completion: nil)
        
    }
    
    //List of all avaliable genres
    //"comedy","tragedy","drama","musical", "satire","mystery":
    var categories:[(name:String,value:[String])] = [(name:"Comedy",value:wordBank.share.fetchList(category:"comedy")),(name:"Tragedy",value:wordBank.share.fetchList(category:"tragedy")),(name:"Drama",value:wordBank.share.fetchList(category:"drama")),(name:"Musical",value:wordBank.share.fetchList(category:"musical"))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let set = categories[indexPath.row]
        let name = set.name
        cell.textLabel?.text = name
        
        return cell
    }
    
    //Select Setter
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SelectedList = categories[indexPath.row].value

    }

}
