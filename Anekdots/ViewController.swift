//
//  ViewController.swift
//  Anekdots
//
//  Created by dmka on 18.04.2020.
//  Copyright © 2020 dmka. All rights reserved.
//

import UIKit
var typeJokeId = "1"

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var textView: UITextView!
    
    var typeJoke = ["Анекдот","Рассказ","Стишок","Афоризм","Цитата","Тост","Статус","Анекдот (18+)","Рассказ (18+)","Стишок (18+)","Афоризм (18+)","Цитата (18+)","Тост (18+)","Статус (18+)"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeJoke.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var finalRow = 1
        if row == 6{
            finalRow = 8
        }else if row == 7 {
            finalRow = 11
        }else if row == 8 {
            finalRow = 12
        }else if row == 9 {
            finalRow = 13
        }else if row == 10 {
            finalRow = 14
        }else if row == 11 {
            finalRow = 15
        }else if row == 12 {
            finalRow = 16
        }else if row == 13 {
            finalRow = 18
        }else {
            finalRow = row+1
        }
        typeJokeId = String(finalRow)
        //print(typeJokeId)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeJoke[row]
    }
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBAction func pushShareButtonAction(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [textView.text!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func pushRefreshButtonAction(_ sender: Any) {
        
        getRandomAnekdot2{ (jokeText) in
            //test git changes
            self.textView.text = jokeText
       }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
    }


}

func getRandomAnekdot2(block: (_ testAnekdot: String)->Void){
    //http://rzhunemogu.ru/RandJSON.aspx?CType=1
    if let urlRandomJoke = URL(string: "http:rzhunemogu.ru/RandJSON.aspx?CType=\(typeJokeId)") {
        do{
            let dataJSON = try String(contentsOf: urlRandomJoke, encoding: String.Encoding.windowsCP1251)
            let start = dataJSON.index(dataJSON.startIndex, offsetBy: 12)
            let end = dataJSON.index(dataJSON.endIndex, offsetBy: -2)
            let range = start..<end

            let mySubstring = dataJSON[range]  // play
                   
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



