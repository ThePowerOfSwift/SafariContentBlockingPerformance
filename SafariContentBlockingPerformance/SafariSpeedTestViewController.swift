//
//  SafariSpeedTestViewController.swift
//  Clearly
//
//  Created by Alaric Cole on 8/27/15.
//  Copyright © 2015 OpenAdblock. All rights reserved.
//

import UIKit
import SafariServices

protocol SpeedDelegate{
    func finishedLoading(url:NSURL, loadingTime:NSTimeInterval)
}

class SafariSpeedTestViewController: SFSafariViewController, SFSafariViewControllerDelegate {
    
    var speedDelegate:SpeedDelegate?
    var url:NSURL!
    
    var timeStarted = NSDate()
    var timeEnded = NSDate()
    
    
    //MARK: SFSafariViewControllerDelegate
    //When the Safari VC finishes loading, this gets called with a timestamp
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        timeEnded = NSDate()
        
        //calculate the time this page took to load
        let timeInterval = timeEnded.timeIntervalSinceDate(timeStarted)
        
        speedDelegate?.finishedLoading(url, loadingTime: timeInterval)
    }
    
    
    convenience init(URL: NSURL, speedDelegate:SpeedDelegate) {
        self.init(URL: URL, entersReaderIfAvailable: false)
        self.speedDelegate = speedDelegate
    }
    
    override  init(URL: NSURL, entersReaderIfAvailable: Bool) {
        
        timeStarted = NSDate()
        
        super.init(URL: URL, entersReaderIfAvailable: entersReaderIfAvailable)
        
        delegate = self
        url = URL
        title = url.host
        
    }
    
    deinit
    {
        speedDelegate = nil
    }
    
}
