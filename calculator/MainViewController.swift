//
//  ViewController.swift
//  calculator
//
//  Created by Rob Gilbert on 6/26/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calc = Calculator()
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tappedClear(_ sender: Any) {
        calc.clear()
        label.text = "0"
    }
    
    @IBAction func tappedDivide(_ sender: Any) {
        calc.addToQueue(char: Character("/"))
        label.text = calc.getLabel()
    }
    
    @IBAction func tappedMultiply(_ sender: Any) {
        calc.addToQueue(char: Character("*"))
        label.text = calc.getLabel()
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        calc.addToQueue(char: Character("+"))
        label.text = calc.getLabel()
    }
    
    @IBAction func tappedSubtract(_ sender: Any) {
        calc.addToQueue(char: Character("-"))
        label.text = calc.getLabel()
    }
    
    @IBAction func tappedEqual(_ sender: Any) {
        calc.equal()
        label.text = calc.getLabel()
    }
    
    @IBAction func tappedNumber(_ sender: UIButton) {
        calc.addToQueue(char: Character((sender.titleLabel?.text!)!))
        label.text = calc.getLabel()
    }

    @IBAction func tappedParenthesis(_ sender: Any) {
        calc.handleParenthesis()
        label.text = calc.getLabel()
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

