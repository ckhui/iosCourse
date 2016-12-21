//
//  SwiftViewController.swift
//  week 4 swift
//
//  Created by NEXTAcademy on 11/7/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var fizzBuzzLabel: UILabel!
    @IBOutlet weak var sumOfMultipleLabel: UILabel!
    
    @IBOutlet weak var pigLatinInput: UITextField!
    @IBOutlet weak var pigLatinOutput: UILabel!
    
    
    @IBOutlet weak var googleText1: UITextField!
    @IBOutlet weak var googleText2: UITextField!
    @IBOutlet weak var googleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fizzBuzzLabel.text = fizzBuzz(n: 100)
        
        sumOfMultipleLabel.text = "\(sumOfMultipleOf(a: 3, b: 5, n: 1000 - 1))"
        
        pigLatinInput.placeholder = "enter sentence here"
        pigLatinInput.delegate = self;
        
        
        print(binary_search(Array(1...100), toFind:99))
        print(binary_search([12 ,124, 213,424, 92, 99], toFind:99))
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fizzBuzz(n :Int) -> String {
        var fbMessage = ""
        for i in 1...n{
            if i % 3 == 0{
                if i % 5 == 0{
                    fbMessage += "FizzBuzz "
                }
                else{
                    fbMessage += "Fizz"
                }
            }
            else if i % 5 == 0 {
                fbMessage += "Buzz"
            }
            else {
                fbMessage += "\(i)"
            }
            
        }
        return fbMessage;
    }
    
    func sumOfMultipleOf(a :Int, b: Int, n :Int) -> Int{
        
        let sumOfxa = a * (n / a) * ((n / a) + 1) / 2;
        let sumOfxb = b * (n / b) * ((n / b) + 1) / 2;
        let ab = a * b
        let sumOfxab = ab * (n / ab) * ((n / ab) + 1) / 2;
        
        return sumOfxa + sumOfxb - sumOfxab;
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard
            let input : String = textField.text
            else{
                pigLatinOutput.text = "Error"
                return true;
        }
        
        if input.isEmpty{
            pigLatinOutput.text = "Empty input"
            return true
        }
        
        let inputArr = input.components(separatedBy:" ")
        
        let vowel : CharacterSet = CharacterSet(charactersIn :"aeiou")// ['a','e','i','o','u']
        
        var result = ""
        for word in inputArr{
            
            if let range = word.lowercased().rangeOfCharacter(from: vowel, options: .caseInsensitive){
                //let firstIndex = word.index(after: (range.lowerBound))
                let firstIndex = range.lowerBound
                if firstIndex == word.startIndex{
                    result += word + " "
                }else{
                    result += word.substring(from: firstIndex) + word.substring(to: firstIndex) + "ay "
                }
            }
            else{
                result += word + " "
            }
        }
        pigLatinOutput.text = result
        return true
    }
    
    
    func binary_search(_ numbers : [Int], toFind target : Int) -> Int{
        
        //sort
        var num = numbers.sorted()
        
        var top = num.count - 1
        var bottom = 0
        var middle = (top+bottom) / 2
        
        if num[top] < target || num[bottom] > target{
            return -1
        }
        
        if num[top] == target{
            return top
        }
        else if num[bottom] == target{
            return bottom
        }
        
        while num[middle] != target {
            
            if top - bottom <= 1{
                return -1
            }
            else if num[middle] < target{
                bottom = middle
            }
            else{
                top = middle
            }
            middle = (top+bottom) / 2
        }
        return middle
    }
    
    func goolgeQuestion(word1 str1 : String, word2 str2 : String) -> Int{
        let chars : CharacterSet = CharacterSet(charactersIn :str2)
        
        if str1.lowercased().rangeOfCharacter(from: chars) != nil{
            return -1
        }else{
            return str1.characters.count * str2.characters.count
        }
        
        
    }
    
    @IBAction func onGooglePressed(_ sender: AnyObject) {
        let result = goolgeQuestion(word1: googleText1.text!, word2: googleText2.text!)
        googleLabel.text = "\(result)"
    }
}
