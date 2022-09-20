//
//  ViewController.swift
//  Flashcard
//
//  Created by Vincent Li on 9/13/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionOne.clipsToBounds = true
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4462072849, green: 0.8619298339, blue: 0.866147697, alpha: 1)

        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionTwo.clipsToBounds = true
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4462072849, green: 0.8619298339, blue: 0.866147697, alpha: 1)
        
        btnOptionThree.layer.cornerRadius = 20.0
        btnOptionThree.clipsToBounds = true
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4462072849, green: 0.8619298339, blue: 0.866147697, alpha: 1)
        
    }

    @IBAction func tapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
        }
    }

    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
        btnOptionOne.isHidden = true
        btnOptionThree.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
}

