    //
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//   
    
    
    // Array of Friends that will be populated //
   
    var FriendArray: [buddy] = []
    // Couurses object to store each class in an array
    class courses{
        var department: String = String();
        var section: String = String();
        var number: String = String();
    }
    // a list of courses
    class courseLists{
        var name: String = String("NaN");
        var instructor: String = String("NaN");
        var times: String = String("NaN");
        var days: String = String();
        var desc: String = String();
        var location: String = String();
        
    }
    
    // Array class extension method to slice strings//
    extension Array {
        func slice(args: Int...) -> Array {
            var s = args[0]
            var e = self.count - 1
            if args.count > 1 { e = args[1] }
            
            if e < 0 {
                e += self.count
            }
            
            if s < 0 {
                s += self.count
            }
            
            let count = (s < e ? e-s : s-e)+1
            let inc = s < e ? 1 : -1
            var ret = Array()
            
            var idx = s
            for var i=0;i<count;i++  {
                ret.append(self[idx])
                idx += inc
            }
            return ret
        }
    }
    
    
   
    
    

    
    // search for particiular course in coursearray
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
   
// Uses the parsed schedule to create a matrix , each 0 = no class and 1 = class , each digit of the matrix is a time slot between the beginging of class from x.30 o clock till x.20 , matching the class schedule format of SFU 
// each 12 digits a full school day of the week ( does not include weekends)
func CreateMatrix() ->String {
    
    // if course list isnt present or parsing error then return blank matrix..
    if (courseList.isEmpty ){return "000000000000000000000000000000000000000000000000000000000000"}
    
    // for Each course in courselist , splice the string to seperate starting time from ending time //
    for course in courseList {
        
        var daymult = 0
        var intstring : [String] = course.times.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ": -"))
        
        var startime = 0
        var endtime  = 0
        var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
        // special case where theres a online course, the time is set as break
        if(intstring.count<=1){startime = 0;  endtime = 0} else{
        startime = intstring[0].toInt()!
        endtime = intstring[5].toInt()!}
        
        //convert string of days to a multipler offset for matrix
        
        
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
            var start = startime - 8
            var end = endtime - 8
            var hourOfClass = endtime - startime
            for (var i = 0; i < hourOfClass ; i++)
            {								
                matrix[daymult*timeSlotsOfADay + start + i] = "1"
            }
            
            // Convert the array back to the string that used to stored in database
            // let scheduleDB  = "" + self.matrix
            
            
            
            //}
            
            
            
        }
        
        
        
    }
    // convert matrix back to string
    let schedule  = "" + matrix
   
    return schedule
    
}

import UIKit
import CoreData
var matrix = Array("000000000000000000000000000000000000000000000000000000000000")

var timeSlotsOfADay = 12


    // Object displayed on table each one stores a name, status and schedule
    struct buddy {
        
        var name: String
        var status: String
        var matrix: String
    }

    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()


class BreakMatchController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    //@IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var FriendTable: UITableView!

    //var FriendArray: [buddy] = []
    var DisplayList : [String]  = []
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check internet connection to instantly return
        if (Reachability.isConnectedToNetwork() == false) {
            return
        }
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
        
        checkBreak()
        self.FriendTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
        FriendTable.delegate = self
        FriendTable.dataSource = self
        }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
 

    
    // Runs checks core data for each added contact, fetch schedule and add a buddy object to be displayed.
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
            
            
        
        // Map current time string to matrix decimal location
        
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
        // convert current day of the week to offset for matrix
        
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
            // if it is the weekend then everyone is free //
            var Free = buddy(name:result.userid,status:"Free",matrix:result.sch)
            FriendArray.append(Free)
            
          
            

        }
        else if (timeSlot == 24) //Current time is not regular class hour : 0000-0930
        {    // Past regular  school class hours
         
           
            var Busy2 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
             FriendArray.append(Busy2)
           


        }
            else
        {   // 0 = no class
            if(Usermatrix[daymult*timeSlotsOfADay + timeSlot] == "0")
            {
                
               
                var Free = buddy(name:result.userid,status:"Free",matrix:result.sch)
                FriendArray.append(Free)
               
            }
            else
            {
              // User is in class //
               
                var Busy3 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
                FriendArray.append(Busy3)
       
            }
        }
    }
        
        
        
        
           }
    

    
    
    
    // Calculates next break or next class for each user in buddy list
    func TimeTillClass (index: Int) ->String{
        // get matrix of person 
        // Find Current time slot
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        var currentTime = hour*100 + minutes
        var timeSlot = 0
        if(FriendArray[index].matrix.isEmpty){return"7"}
         var mat = Array(FriendArray[index].matrix)
        // iterate each friendslist and check//
        
            
            
            
            // Map current time to matrix index
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
                
                
                return "There is no class today"
                
                
            }
            else if (timeSlot == 24) //Current time is not regular class hour : 0000-0930
            {
                return "All classes over now"
             
                
            }
            else
            {
                // Search matrix for the next class "1"
                if(mat[daymult*timeSlotsOfADay + timeSlot] == "0")
                {
                    // if currently is break, then scan rest of array for next 1
                   
                    var startPoint = daymult*timeSlotsOfADay + timeSlot
                    
                    var submat = mat.slice(startPoint + 1)
                   
                    if(find(submat,"1") == nil){return "no class left"}
                    // calculate offsets between sub arrays
                   
                    var nextClass = (Float) (find(submat,"1")! + startPoint)
                    //println(nextClass)
                    var floatofDay = Float(daymult*timeSlotsOfADay)
                    println(nextClass - startPoint)
                    if( nextClass < floatofDay + 8.0){
                        
                        // difference is just matter of hours//
                        var difference = nextClass - floatofDay
                        
                        if(difference <= 1 ){
                            difference = 1
                            return " Class in \(difference) hour"
                        }
                        
                        return " Class in \(difference) hours"
                    }else{
                       return "No Class Left Today"
                        
                        
                        
                    }
                    
                    
                    
                }
                // case when user is in class, search for when their next break is
                if(mat[daymult*timeSlotsOfADay + timeSlot] == "1"){
                    var startPoint = daymult*timeSlotsOfADay + timeSlot
                    
                    var submat = mat.slice(startPoint+1)
                    println(submat)
                  
                    if(find(submat,"0") == nil){return"Never Free"}
                
                    var nextClass = (Float) (find(submat,"0")!)
                    //println(nextClass)
                    var floatofDay = Float(daymult*timeSlotsOfADay)
                  
                    if( nextClass < floatofDay + 8.0){
                        
                        // difference is just matter of hours//
                        var difference = nextClass
                        println(difference)
                        if (difference <= 0){
                            difference = 1;
                            return " Class ends in \(difference) hour left"

                        }
                        //Break in \(difference) hours
                        return " Class ends in \(difference) hours left"
                    }else{
                        return "No Breaks Left Today"
                        
                        
                        
                    }
                    

                
                
                }
                
                
                
                            }
        
        
        
        
        
    
    return ""
    }
    
        
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        FriendArray.removeAll()
      
       
        self.checkBreak()
        
        
            }
       
    
  
    
   
        
    // Enable sidee menu slider
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                
            } else {
                
            }
        } else {
          
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // Code to populate TableViewCells
    // ---------------------------------
    
    
    
    func numberOfSectionsINtableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
       
       
        
        return  FriendArray.count   }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
       var cell = UITableViewCell(style:UITableViewCellStyle.Subtitle , reuseIdentifier: "FriendCell")
       
        
        var green:UIImage = UIImage(named:"led-green-black")!
        var red: UIImage = UIImage(named:"led-red-black")!
        
        let row = indexPath.row
        
    
       
        
       // if busy display different color for image
        if(FriendArray[row].status == "Busy"){
            var test = self.TimeTillClass(row)
            cell.textLabel?.text = FriendArray[row].name
            cell.detailTextLabel?.text = self.TimeTillClass(row)
      
            cell.imageView?.image = red
           
            
        }
        // if free display green light
        else{
        
        cell.detailTextLabel?.text = self.TimeTillClass(row)
        
        cell.textLabel?.text = FriendArray[row].name
        
        cell.imageView?.image = green
      
         
        }
       
        return cell     }
    
    
    
    
    
}


