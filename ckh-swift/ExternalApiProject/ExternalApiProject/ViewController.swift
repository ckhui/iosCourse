//
//  ViewController.swift
//  ExternalApiProject
//
//  Created by NEXTAcademy on 11/23/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    //var blogArray : [Blog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs"
        
        Alamofire.request(url).responseJSON(completionHandler: {(response) in
            switch response.result {
            case .success(let responseValue):
                let json = JSON(responseValue)
                for (_,subJson) : (String ,JSON) in json{
                    let blog = Blog(json: subJson)
                    //self.blogArray.append(blog)
                    Blog.all.append(blog)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
        for i in Blog.all{
            deleteBlog(blogId: i.id!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Blog.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{
                return UITableViewCell()
        }
        
        //let blog = blogArray[indexPath.row]
        let blog = Blog.all[indexPath.row]
        
        cell.textLabel?.text = blog.title
        cell.detailTextLabel?.text = blog.body
        return cell
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let blog = Blog.all[indexPath.row]
        guard let blogId = blog.id  else { return}
        deleteBlog(blogId: blogId)
    }
    
    func deleteBlog(blogId : Int){
        let url = "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(blogId)"
        Alamofire.request(url, method: .delete, parameters: ["":""], encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(_):
                Blog.all = Blog.all.filter({ $0.id != blogId})
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })

    }
    
}
