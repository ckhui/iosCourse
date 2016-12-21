//
//  ViewController.swift
//  gcd
//
//  Created by NEXTAcademy on 11/29/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func simpleDispatch()       //2 //simple
    {
        DispatchQueue.global(qos: .default).async {
            //whatever typed, will be exceuted asyn 
            //on the default priority
        }
    }
    
    
    func asyncFunction()            //1
    {
//        DispatchQueue.main.async        //dispatch asynchronous
//        {
//            
//        }
        let apiGroup = DispatchGroup() // multiple api
        apiGroup.enter()
        someBlock {
            //once done
            //it's inside a closure or block or any async
            //because it only leave after the closure complete
            apiGroup.leave()
        }
        
        
        apiGroup.enter()
        someBlock {
            apiGroup.leave()
        }
        
        apiGroup.notify(queue: DispatchQueue.main, execute: {
            // do things once you are done with dispatch group
        })
    }
    
    
    func someBlock(closure: () -> ()){
        closure()
    }
    
    func simpleOp()             //3 total control
    {
        let anOperation = Operation()   // it need operation
        
        let operationQueue = OperationQueue() // it need operation queue
        
        operationQueue.addOperation(anOperation)// operation to operationQ
        
        operationQueue.addOperation{
            // this block is consider as operation
        }
        
        operationQueue.cancelAllOperations() // cancel all opeartion
        
        
        
    }
}

class Downloader : Operation {              //4
    override func start() {
      
    }
    
    override func cancel() {
        
    }
    
}




