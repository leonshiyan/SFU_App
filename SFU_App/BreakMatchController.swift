    //
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//
    class courses{
        var department: String = String();
        var section: String = String();
        var number: String = String();
    }
    
    class courseLists{
        var name: String = String("NaN");
        var instructor: String = String("NaN");
        var times: String = String("NaN");
        var days: String = String();
        var desc: String = String();
        var location: String = String();
        
    }
    
    
    
    
    func checkArrayForCourse(var x : courses) -> Bool{
        for y in arr{
            if x.department == y.department &&
                x.section == y.section &&
                x.number == y.number{
                    return true
            }
        }
        return false
        
    }

// Final List of names to display
   

func CreateMatrix() ->String {
    
    
    if (courseList.isEmpty ){return "000000000000000000000000000000000000000000000000000000000000"}
    for course in courseList {
        //println(course.times)
        var daymult = 0
        var intstring : [String] = course.times.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ": -"))
        
        var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
        
        var startime = intstring[0].toInt()
        var endtime = intstring[5].toInt()
        
        
        
        
        for day in daystring {
            
            
            switch day {
                
                
            case "Mo" :
                
                daymult = 0
                break;
                
            case "Tu":
                daymult = 1
                break;
                
            case "We":
                daymult = 2
                break;
                
            case "Th":
                daymult = 3
                break;
                
            case "Fr":
                daymult = 4
                break;
                
            default :
                break;
            }
            
            //Do some computation here
            var start = startime! - 8
            var end = endtime! - 8
            var hourOfClass = endtime! - startime!
            for (var i = 0; i < hourOfClass ; i++)
            {
                matrix[daymult*timeSlotsOfADay + start + i] = "1"
            }
            
            // Convert the array back to the string that used to stored in database
            // let scheduleDB  = "" + self.matrix
            
            
            
            
            
            
            
        }
        
        
        
    }
    let schedule  = "" + matrix
   
    return schedule
    
}

import UIKit
import CoreData
var matrix = Array("000000000000000000000000000000000000000000000000000000000000")

var timeSlotsOfADay = 12



    struct buddy {
        
        var name: String
        var status: String
        var matrix: String
    }










class BreakMatchController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    //@IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var FriendTable: UITableView!
    var FriendArray: [buddy] = []
    var DisplayList : [String]  = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkBreak()
        
        FriendTable.delegate = self
        FriendTable.dataSource = self
        
}
    
    
    override func viewDidAppear(animated: Bool) {
        let fetchRequest  = NSFetchRequest(entityName:"Friend")
         let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        for  result in fetchResults as [Friend] {
            println(result.userid)
            println(result.sch)
            
            
        }
        
    }
    // Runs through the list
    func checkBreak (){
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        var currentTime = hour*100 + minutes
        var timeSlot = 0

        let fetchRequest  = NSFetchRequest(entityName:"Friend")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        // iterate each friendslist and check//
        for  result in fetchResults as [Friend] {
            var Usermatrix = Array(result.sch)
            
        

        
        switch currentTime
        {
        case 830...929:
            timeSlot = 0;
        case 930...1029:
            timeSlot = 1;
        case 1030...1129:
            timeSlot = 2;
        case 1130...1229:
            timeSlot = 3;
        case 1230...1329:
            timeSlot = 4;
        case 1330...1429:
            timeSlot = 5;
        case 1430...1529:
            timeSlot = 6;
        case 1530...1629:
            timeSlot = 7;
        case 1630...1729:
            timeSlot = 8;
        case 1730...1829:
            timeSlot = 9;
        case 1830...1929:
            timeSlot = 10;
        case 1930...2329:
            timeSlot = 11;
        default :
            timeSlot = 24;// Non regular class time
        }
        let dayTimeFormatter = NSDateFormatter()
        dayTimeFormatter.dateFormat = "EEEEEE"
        let dayString = dayTimeFormatter.stringFromDate(date)
        
        
        var daymult = 0
        switch dayString {
        case "Mo" :
            
            daymult = 0
            break;
            
        case "Tu":
            daymult = 1
            break;
            
        case "We":
            daymult = 2
            break;
            
        case "Th":
            daymult = 3
            break;
            
        case "Fr":
            daymult = 4
            break;
            
        default :
            daymult = 100;
        }
            
            
        if(daymult >= 100)
        {
            println("There is no class today")
            var Busy1 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
            
            self.DisplayList.append(result.userid)
            self.FriendArray.append(Busy1)
            

        }
        else if (timeSlot == 24) //Current time is not regular class hour : 0000-0930
        {
            println("All classes over now")
            self.DisplayList.append(result.userid)
            var Busy2 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
             self.FriendArray.append(Busy2)


        }
            else
        {
            if(Usermatrix[daymult*timeSlotsOfADay + timeSlot] == "0")
            {
                //Display for tesing purpose
                //var newbuddy :buddy = buddy(name: result.userid,status: "Free")
                
                //self.FriendArray.append(buddy(name: result.userid,status: "Free"))
                self.DisplayList.append(result.userid)
                var Free = buddy(name:result.userid,status:"Free",matrix:result.sch)
                self.FriendArray.append(Free)
                println("Yes, he is free now")
            }
            else
            {
                //Display for tesing purpose
              //  var newbuddy :buddy = buddy(name: result.userid,status: "Free")
                
              //  self.FriendArray.append(buddy(name: result.userid,status: "Busy"))
            
                self.DisplayList.append(result.userid)
                var Busy3 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
                self.FriendArray.append(Busy3)
                println("No, he is not free now")
            
            }
        }
    }
        
        
        
        for people in DisplayList {
            println(people)
        }
        
           }
    
    
    
    
    
    // Checks when next class is
    func TimeTillClass () {
        // get matrix of person 
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    func numberOfSectionsINtableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
       // let fetchRequest  = NSFetchRequest(entityName:"Friend")
        //let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        //fetchResults!.count

       
        
        return  self.DisplayList.count   }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FriendTable.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as UITableViewCell   // let fetchRequest  = NSFetchRequest(entityName:"Friend")
        //let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
       // var Display2 : [String] = []
       // for  result in fetchResults as [Friend] {
          //   Display2.append(result.userid)
            
            
      //  }
        var green:UIImage = UIImage(named:"led-green-black")!
        var red: UIImage = UIImage(named:"led-red-black")!
        
        let row = indexPath.row
        
        cell.textLabel?.text = self.FriendArray[row].name
        cell.imageView?.image = green
        
        
        //(cell.contentView.viewWithTag(10) as UILabel).text = self.FriendArray[row].status
        if(FriendArray[row].status == "Busy"){
            cell.detailTextLabel?.text = "Busy till "
            cell.imageView?.image = red
        }
        else{
        cell.detailTextLabel?.text = "Free till" //"Break till"
        cell.imageView?.image = green
        }
       
        return cell     }
    
}


