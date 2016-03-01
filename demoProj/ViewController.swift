//
//  ViewController.swift
//  demoProj
//
//  Created by BridgeLabz on 29/02/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       //unzip the file
        
        let zipPath : String? = "/Users/bridgelabz/Downloads/case_out.zip"
        //destination  path in simulator to store unzip folders
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as! NSString
        let destinationpath = docsDir.stringByAppendingPathComponent(
            "unzipFolder")
        print("destinationPath " , destinationpath)
        //code for unzipping file
        let unZipped = SSZipArchive.unzipFileAtPath(zipPath, toDestination: destinationpath)
        
        
        //display the images in webview
        
        
         var path: String = NSBundle.mainBundle().pathForResource("page_5", ofType: "svg")!
        
         var url: NSURL = NSURL.fileURLWithPath(path)  //Creating a URL which points towards our path
        
        //Creating a page request which will load our URL (Which points to our path)
         var request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)  //Telling our webView to load our above request

        self.TotalDataCount(destinationpath+"/case_out/data/database.sqlite")
        
        

        
    }
    
    func TotalDataCount(databasePath : String)
    {
        
        let PageDataDB = FMDatabase(path : databasePath  as String)
        print("database" , PageDataDB)
        
        
        if PageDataDB.open()
        {
            let result = PageDataDB.executeQuery("SELECT COUNT(*) FROM PageData", withArgumentsInArray: [])
            if result.next() {
                let count = result.intForColumnIndex(0)
                print("count",count)
                
                PageDataDB.close()
            } else {
                print("Database error")
            }
        }
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


