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
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
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
        
/*       btnOptionOne.layer.cornerRadius = 20.0
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
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4462072849, green: 0.8619298339, blue: 0.866147697, alpha: 1)*/
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "Which country has the largest population?", answer: "China")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
    @IBAction func tapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
        }
    }
    
    struct Flashcard {
        var question: String
        var answer: String
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        /*
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(answer, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        */
        // Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        print("Added a new Flashcard, take a look -> ", flashcards)
        // Logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        // Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        // Update buttons
        updateNextPrevButtons()
        // Update labels
        updateLabels()
    }
    
    func updateNextPrevButtons() {
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        //Disable prev button if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        // Update labels
        updateLabels()
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        // Update labels
        updateLabels()
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        present(alert, animated: true)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
    }
    
    func deleteCurrentFlashcard() {
        // Delete current
        flashcards.remove(at: currentIndex)
        // Special case: Check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}

