    //
//  BreakMatchController.swift
//  SFU_App
//
//  Created by Nethaniel Yuen on 2015-03-20.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//   
    var FriendArray: [buddy] = []
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
        println(intstring)
        var startime = 0
        var endtime  = 0
        var daystring = course.days.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: ", "))
    
        if(intstring.count<=1){startime = 0;  endtime = 0} else{
        startime = intstring[0].toInt()!
        endtime = intstring[5].toInt()!}
        
        
        
        
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
            println(result.sch)
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
            //println("There is no class today")
            //var Busy1 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
            var Free = buddy(name:result.userid,status:"Free",matrix:result.sch)
            FriendArray.append(Free)
            
            //FriendArray.append(Busy1)
            

        }
        else if (timeSlot == 24) //Current time is not regular class hour : 0000-0930
        {
            //println("All classes over now")
           
            var Busy2 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
             FriendArray.append(Busy2)


        }
            else
        {
            if(Usermatrix[daymult*timeSlotsOfADay + timeSlot] == "0")
            {
                //Display for tesing purpose
                //var newbuddy :buddy = buddy(name: result.userid,status: "Free")
                
                //self.FriendArray.append(buddy(name: result.userid,status: "Free"))
               
                var Free = buddy(name:result.userid,status:"Free",matrix:result.sch)
                FriendArray.append(Free)
                //println("Yes, he is free now")
            }
            else
            {
                //Display for tesing purpose
              //  var newbuddy :buddy = buddy(name: result.userid,status: "Free")
                
              //  self.FriendArray.append(buddy(name: result.userid,status: "Busy"))
            
               
                var Busy3 = buddy(name:result.userid,status:"Busy",matrix:result.sch)
                FriendArray.append(Busy3)
               // println("No, he is not free now")
            
            }
        }
    }
        
        
        
        
           }
    

    
    
    
    // Checks when next class is
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
                if(mat[daymult*timeSlotsOfADay + timeSlot] == "0")
                {
                    // if currently is break, then scan rest of array for next 1
                   
                    var startPoint = daymult*timeSlotsOfADay + timeSlot
                    
                    var submat = mat.slice(startPoint + 1)
                    //println(mat)
                   // println(submat)
                    if(find(submat,"1") == nil){return""}
                    var nextClass = (Float) (find(submat,"1")! + startPoint)
                    var floatofDay = Float(daymult*timeSlotsOfADay)
                    println(nextClass)
                    println(floatofDay)
                    if( nextClass < floatofDay + 8.0){
                        // difference is just matter of hours//
                        var difference = find(submat,"1")!
                        return " Class in \(difference) hours"
                    }else{
                       return "No Class Left Today"
                        
                        
                        
                    }
                    
                    
                    
                }
                if(mat[daymult*timeSlotsOfADay + timeSlot] == "1"){
                    var startPoint = daymult*timeSlotsOfADay + timeSlot
                    
                    var submat = mat.slice(startPoint + 1)
                    println(mat)
                    println(submat)
                    if(find(submat,"0") == nil){return"Never Free"}
                    var nextClass = (Float) (find(submat,"0")! + startPoint)
                    var floatofDay = Float(daymult*timeSlotsOfADay)
                    println(nextClass)
                    println(floatofDay)
                    if( nextClass < floatofDay + 8.0){
                        // difference is just matter of hours//
                        var difference = find(submat,"0")!
                        return " Break in \(difference) hours"
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
      
        println(FriendArray.count)
        self.checkBreak()
        println(FriendArray.count)
        for friend in FriendArray{
            println(friend.status)
        }
        //self.FriendTable.reloadData();
      /*  FriendArray = []
        println("Array count before: %@", FriendArray.count)
        checkBreak()
        println("Array count after: %@", FriendArray.count)
        FriendTable.reloadData()
        if (FriendArray.count > FriendTable .numberOfRowsInSection(0)) {
            let indexPath = NSIndexPath(forRow: FriendArray.count-1, inSection: 0)
            FriendTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }   */
    }
       
    
  
    
   
        
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func numberOfSectionsINtableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
       // let fetchRequest  = NSFetchRequest(entityName:"Friend")
        //let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
        //fetchResults!.count

       
        
        return  FriendArray.count   }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell = FriendTable.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as UITableViewCell
        
       var cell = UITableViewCell(style:UITableViewCellStyle.Subtitle , reuseIdentifier: "FriendCell")
        
        
       
          //  cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,"
              //  reuseIdentifier: "FriendCell")
        
        
        
       
    
        
        
        
        
        // let fetchRequest  = NSFetchRequest(entityName:"Friend")
        //let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest,error: nil )
       // var Display2 : [String] = []
       // for  result in fetchResults as [Friend] {
          //   Display2.append(result.userid)
            
            
      //  }
        //if(FriendArray.isEmpty){
            
            
            
          //  return cell ;}//
        var green:UIImage = UIImage(named:"led-green-black")!
        var red: UIImage = UIImage(named:"led-red-black")!
        
        let row = indexPath.row
        
       // let label2 = cell.contentView.viewWithTag(1111) as UILabel!
        //label2?.text = "hello"
       // cell.imageView?.image = green
       // cell.detailTextLabel?.text = "Hello World"
       
        
      
        if(FriendArray[row].status == "Busy"){
            var test = self.TimeTillClass(row)
            cell.textLabel?.text = FriendArray[row].name
            cell.detailTextLabel?.text = self.TimeTillClass(row)
            cell.textLabel?.text = self.TimeTillClass(row)
            cell.imageView?.image = red
           
            
        }
        else{
        cell.detailTextLabel?.text = self.TimeTillClass(row)
        
        cell.textLabel?.text = FriendArray[row].name
        //cell.textLabel?.text = self.TimeTillClass(row)
        //cell.detailTextLabel?.text = self.TimeTillClass(row)
        cell.imageView?.image = green
      
         
        }
       
        return cell     }
    
    
    
    
    
}


