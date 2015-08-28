This attempts to calculate complete load times of a large list of sites, simply by loading SFSafariViewController instances and printing the load times in the console (in CSV, for easy import into a spreadsheet).

Build on a device for the most accurate testing, though you may get decent results in the simulator for load times. 
Tap on a row to begin. Once the site loads, it will log its time and fire off the next site.

Then, install and turn on a Safari content blocker such as [Clearly](getclearly.com). Try the list again and compare the times.


- SiteList.swift contains a list of sites to load.
- AppDelegate.swift sets up a split view controller.
- MasterViewController is the UI for the list of sites.
- SafariSpeedTestViewController.swift is a SFSafariViewController subclass with timestamps.