//
//  ViewController.swift
//  Anekdots
//
//  Created by dmka on 18.04.2020.
//  Copyright © 2020 dmka. All rights reserved.
//

import UIKit

func getRandomAnekdot2(block: (_ testAnekdot: String)->Void){
    //http://rzhunemogu.ru/RandJSON.aspx?CType=1
    if let urlRandomJoke = URL(string: "http:rzhunemogu.ru/RandJSON.aspx?CType=1") {
        do{
            let dataJSON = try String(contentsOf: urlRandomJoke, encoding: String.Encoding.windowsCP1251)
            let start = dataJSON.index(dataJSON.startIndex, offsetBy: 12)
            let end = dataJSON.index(dataJSON.endIndex, offsetBy: -2)
            let range = start..<end

            let mySubstring = dataJSON[range]  // play
            
            
            //print(mySubstring)
        
            if !mySubstring.isEmpty{
                    
                    block(mySubstring.replacingOccurrences(of: "&quot", with: "\""))
                    return
                }
            
        }catch{
            print(error)
        }
    }
    block("")
}

//http:rzhunemogu.ru/Rand.aspx?CType=1



class ViewController: UIViewController, XMLParserDelegate {
    
    @IBOutlet weak var labelAnekdots: UILabel!
    var currentParsingElement = ""
    
    @IBAction func pushShareButtonAction(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [labelAnekdots.text!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func pushRefreshButtonAction(_ sender: Any) {
        
        getRandomAnekdot2{ (jokeText) in
            self.labelAnekdots.text = jokeText
       }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

