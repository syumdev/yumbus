//
//  FirstViewController.swift
//  YumBus
//
//  Created by Seungheon Yum on 5/28/16.
//  Copyright © 2016 syumdev. All rights reserved.
//

import UIKit


class ShowBusTimesViewController: UIViewController, NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var _tableView: UITableView!
    
    var retriever:NextBusRetriever!
    let _cellReuseIdentifier = "showInfoCell"
    var _refreshControl = UIRefreshControl()
    var _tableViewController = UITableViewController(style: .Plain)
    var secondsArray: [String] = []
    var strRefreshTime:String!
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateFormatter.dateFormat = "HH:mm:ss"
        strRefreshTime = dateFormatter.stringFromDate(NSDate())
        
        self.retriever =  NextBusRetriever(agency:"mbta",route:"66",stop:"1111")
        self.retriever.parseNextBus()
        _tableView.backgroundView=_refreshControl
        setTableView()
        addRefreshControl()
        print(retriever.url)
        self.secondsArray = retriever.secondsArray
       

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTableView(){
        _tableView.delegate=self
        _tableView.dataSource=self
    }
    
    func addRefreshControl(){
        
        _refreshControl.attributedTitle = NSAttributedString(string: "Last updated on " + self.strRefreshTime)
        _tableViewController.refreshControl = _refreshControl
        self.strRefreshTime = dateFormatter.stringFromDate(NSDate())
        _refreshControl.addTarget(self, action: "refreshTableView", forControlEvents: UIControlEvents.ValueChanged)
        _tableView?.addSubview(_refreshControl)
        
        
        
    }
    
    func refreshTableView(){
        retriever.removeAll()
        retriever.parseNextBus()
        self.secondsArray = retriever.secondsArray
        for second in (secondsArray){
            print(second)
        }
        _tableView.reloadData()
        
        let delayInSeconds = 0.5;
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self._refreshControl.endRefreshing()
        }
    }
    
    func setRefreshControl(){
        self.refreshTableView()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self._tableView.dequeueReusableCellWithIdentifier(_cellReuseIdentifier, forIndexPath: indexPath) as! showInfoCell
        cell._lblBusNumber.text="66"
        cell._lblBusTimeLeft.text = textForLblBusTimeLeft()
        
        
        return cell
    }
    
    func textForLblBusTimeLeft() -> String{
        var timeText = String()
        
        for time in self.secondsArray.prefix(2){
            timeText += secondsToMinuteSeconds(time) + ", "
        }
        
        timeText += secondsToMinuteSeconds(secondsArray[2])
        
        return timeText
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func secondsToMinuteSeconds(time: String) -> String {
        
        let min = String(Int(time)!/60)
        let sec = String(Int(time)!%60)
        
        if(Int(min)! < 1) {
            return sec + " seconds, "
        }
        
        return min+":"+sec+" min"
    }
    
    
    
    
}

