//
//  MasterViewController.swift
//  SafariContentBlockingPerformance
//
//  Created by Alaric Cole on 8/27/15.
//  Copyright © 2015 Alaric Cole. All rights reserved.
//

import UIKit
import SafariServices
class MasterViewController: UITableViewController, SpeedDelegate{
    
    let sites = SiteList.sites
    /*
        Set this to whether or not a content blocker has been enabled.
        All it does is set the column name in the print output, so no big deal if you forget.
    */
    let contentBlockingEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            This prints the "columns" for CSV
        */
       
        print("URL,TIME_", terminator:contentBlockingEnabled ? "OPTIMIZED\n" : "STANDARD\n")
        
    }
    
    func finishedLoading(url: NSURL, loadingTime: NSTimeInterval) {
        
        /*
            This will print the url and the time it took to load.
            You can then just copy the console log and it'll be in CSV format for easy injection into a spreadsheet.
        */
        
        print("\(url),\(loadingTime)")
        
        
        if let splitViewController = self.splitViewController{
            /*
                iPads and big iPhones in landscape will show both parts of a split view.
                If both aren't showing, it's collapsed.
                Add a delay for good measure.
            */
            
            if splitViewController.collapsed{
                self.navigationController?.popViewControllerAnimated(true)
                delay(1.0){
                    self.loadNext()
                }
            }
            else{
                delay(1.0){
                    self.loadNext()
                }
            }
            
            
        }
        
        
        
    }
    
    func loadNext(){
        
        //load next
        let currentIndex = tableView.indexPathForSelectedRow?.row ?? 0
        let nextIndex = currentIndex + 1
        if nextIndex < sites.count{
            let nextPath = NSIndexPath(forRow: nextIndex, inSection: 0)
            title = "\(nextIndex + 1) / \(sites.count)"
            
            tableView.selectRowAtIndexPath(nextPath, animated: true, scrollPosition: .Middle)
            
            performSegueWithIdentifier("showDetail", sender: nil)
        }
        else{
            //done
            title = "Completed"
        }
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = false
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail", let indexPath = self.tableView.indexPathForSelectedRow {
            
                let object = sites[indexPath.row]
                
                let destinationNav = segue.destinationViewController as! UINavigationController
                
                let safari = SafariSpeedTestViewController(URL: NSURL(string: "http://" + object)!, speedDelegate:self)
                
                destinationNav.setViewControllers([safari], animated: false)

            
        }
    }
    
    // MARK: - Table View
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = sites[indexPath.row]
        cell.textLabel?.text = object
        return cell
    }
    
    
        
    
}

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

