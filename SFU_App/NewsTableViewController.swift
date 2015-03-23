//
//  NewsTableViewController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-06.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, NSXMLParserDelegate {

    var parser: NSXMLParser = NSXMLParser() // Instance of NSXML parser
    var posts: [rssPosts] = [] // Holds RSS posts
    
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()
    var rsschn : String = String()
    var eventTitle : String = String ()
    
    
    @IBOutlet var rssTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:NSURL = NSURL(string: rsschn)!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
        self.navigationItem.title = eventTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return posts.count
    }
    
    // Creating storage for desired layer
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
        }
    }
    
    // Parses desired tags
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            }
        }
    }
    
    // Save parsed information into array
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "item" {
            let onePost: rssPosts = rssPosts()
            onePost.postTitle = postTitle
            onePost.postLink = postLink
            posts.append(onePost)
        }
    }
    


    // Initialize view table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let post: rssPosts = posts[indexPath.row]
        cell.textLabel.text = post.postTitle
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    // Pass data to next controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "viewpost" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                
                let rssPost: rssPosts = posts[indexPath.row]
                let test : String = "hi"
            
                let viewController = segue.destinationViewController as PostViewController
                viewController.postLink = rssPost.postLink
            }
        }
    }

}
