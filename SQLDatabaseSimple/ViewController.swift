//
//  ViewController.swift
//  SQLDatabaseSimple
//
//  Created by Nikhil Patil on 16/03/19.
//  Copyright © 2019 Nikhil Patil. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var path:String!
    var db:Connection!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var mobNo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do{
            db = try Connection("\(path!)/signupdata.sqlite3")
            try db.run("Create table if not exists signupdata (id integer primary key autoincrement,FirstName text,LastName text,Age int,MobileNo int)")
            print(path!)
        }catch{
            print(error)
        }
        
    }
    
    @IBAction func saveEvent(_ sender: UIButton) {
        
        do{
            try db.run("insert into signupdata (FirstName,LastName,Age,MobileNo) values (?,?,?,?)",firstName.text!,lastName.text!,age.text!,mobNo.text!)
        }catch{
            print(error)
        }
        
        firstName.text! = ""
        lastName.text! = ""
        age.text! = ""
        mobNo.text! = ""
        
    }
    
    @IBAction func retrive(_ sender: UIButton) {
        
        do{
            let statement = try db.run("Select FirstName,LastName,Age,MobileNo from signupdata")
            
            for row in statement
            {
                for (index,name) in statement.columnNames.enumerated()
                {
                    print("\(name):\(row[index]!)")
                }
            }
            
        }catch{
            print(error)
        }
    }


}

