//
//  AddBlogViewController.swift
//  ExternalApiProject
//
//  Created by NEXTAcademy on 11/23/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddBlogViewController: UIViewController {
    
    var count = 0
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        for i in 0...100{
        count += 1
        guard let title = titleLabel.text,
            let body = bodyTextField.text
            else{ return }
        let newBlogDict = [
            "blog" : [
                "title" : " \(title) : \(count)",
                "body" : body
            ]
        ]
        
        let url = "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs"
        Alamofire.request(url, method: .post, parameters: newBlogDict).responseJSON(completionHandler: {(response) in
            switch response.result{
            case .success(let value):
                    let json = JSON(value)
                let blog = Blog(json: json)
                    Blog.all.insert(blog, at: 0)
                //self.navigationController?.popViewController(animated: true)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        }
        self.navigationController?.popViewController(animated: true)
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


