//
//  WebViewController.swift
//  Voltage
//
//  Created by EVApp Team on 12/5/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import SystemConfiguration

class WebViewController: UIViewController {
    
    // UI Links
    @IBOutlet var webView: UIWebView!
    
    // goBack action handler
    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
    }
    // goForward action handler
    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    }
    // refresh action handler
    @IBAction func refresh(sender: AnyObject) {
        webView.reload()
    }
    
    
    // Functions
    
    /* viewDidLoad()
    * @description
    *      Initial function call similar to main()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isConnectedToNetwork() == true {
            webLoad()
        } else{
            let refreshAlert = UIAlertController(title: "No Internet Connection",
                message: "Retry When There is a Connection",
                preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Retry", style: .Default,
                handler: { (action: UIAlertAction!) in self.webLoad()
            }))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(refreshAlert, animated: true, completion: nil)
            })
        }
    }
    
    /* webLoad()
    * @description
    *      Load desired webpage
    */
    func webLoad(){
        let url = NSURL(string: "http://www.autozone.com")!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default,
            handler: { (action: UIAlertAction!) in print("Memory Warning")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /* isConnectedToNetwork()
    * @description
    *      Checks for network connection
    */
    func isConnectedToNetwork() -> Bool {
        
        var blankAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0,
            sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        blankAddress.sin_len = UInt8(sizeofValue(blankAddress))
        blankAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&blankAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }

        var stop: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &stop) == false {
            return false
        }
        
        let Reachable = stop == .Reachable
        let requiresConnection = stop == .ConnectionRequired
        
        return Reachable && !requiresConnection
    }
}
