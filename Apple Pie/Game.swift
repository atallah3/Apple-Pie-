//
//  Game.swift
//  Apple Pie
//
//  Created by Abd Elrahman Atallah on 10/08/2024.
//

import Foundation

struct Game {
    let word: String
    var incorrectMovesRemaining: Int
    var guessedLetter: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetter.contains(letter) {
                guessedWord.append(letter)
            } else {
                guessedWord.append("_")
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(char: Character) {
        guessedLetter.append(char)
        if !word.contains(char) {
            incorrectMovesRemaining -= 1
        }
    }
}

