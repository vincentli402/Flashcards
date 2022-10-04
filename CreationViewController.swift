//
//  CreationViewController.swift
//  Flashcard
//
//  Created by Vincent Li on 9/27/22.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraOneTextField: UITextField!
    @IBOutlet weak var extraTwoTextField: UITextField!
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let extraAnswerOneText = extraOneTextField.text
        let extraAnswerTwoText = extraTwoTextField.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty{
            let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            present(alert, animated: true)
        } else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!)
        }
        
        dismiss(animated: true)
    }
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
