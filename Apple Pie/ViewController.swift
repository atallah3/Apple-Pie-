//
//  ViewController.swift
//  Apple Pie
//
//  Created by Abd Elrahman Atallah on 10/08/2024.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    //MARK: - PROPERTIES
    var currentGame: Game?
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    var incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    //MARK: - IBActions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        guard let letterString = sender.configuration?.title else { return }
        let letter = Character(letterString.lowercased())
        currentGame?.playerGuessed(char: letter)
        updateGameState()
    }
    
    //MARK: - FUNCTIONS
    private func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetter: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    private func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    private func updateUI() {
        guard let game = currentGame else { return }
        updateCorrectWordLabel(currentGame: game)
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(game.incorrectMovesRemaining)")
    }
    
    private func updateCorrectWordLabel(currentGame: Game) {
        var letters: [String] = []
        for letter in currentGame.formattedWord {
            letters.append("\(letter)")
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
    }
    
    private func updateGameState() {
        if currentGame?.incorrectMovesRemaining == 0 {
            totalLosses += 1
            newRound()
        } else if currentGame?.word == currentGame?.formattedWord {
            totalWins += 1
            newRound()
        } else {
            updateUI()
        }
    }
    
}

