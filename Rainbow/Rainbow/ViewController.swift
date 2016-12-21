//
//  ViewController.swift
//  Rainbow
//
//  Created by NEXTAcademy on 11/24/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    enum RainbowColor : Int{
        case red
        case orange
        case yellow
        case green
        case blue
        case indigo
        case violet
        
        
        func text() -> String {
            switch self {
            case .red : return "Red"
            case .green : return "green"
            case .blue : return "blue"
            case .yellow : return "yellow"
            case .orange : return "orange"
            case .indigo : return "indigo"
            case .violet : return "violet"
            }
        }
        
        func color() -> UIColor {
            switch self {
            case .red : return UIColor.red
            case .green : return UIColor.green
            case .blue : return UIColor.blue
            case .yellow : return UIColor.yellow
            case .orange : return UIColor.orange
            case .indigo : return UIColor.indigo
            case .violet : return UIColor.violet
            }
        }
        
        
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        else{
                return UITableViewCell()
        }
        
        if let rainbow = RainbowColor.init(rawValue: indexPath.row)
        {
            cell.textLabel?.text = rainbow.text()
            cell.backgroundColor = rainbow.color()
        }
        
        return cell
    }
    
    
}


extension UIColor {
    @nonobjc static let indigo = UIColor(red: 0.365, green: 0.463, blue: 0.796, alpha: 1.0)
    
    @nonobjc static let violet = UIColor(red: 0.451, green: 0.400, blue: 0.741, alpha: 1.0)
}

