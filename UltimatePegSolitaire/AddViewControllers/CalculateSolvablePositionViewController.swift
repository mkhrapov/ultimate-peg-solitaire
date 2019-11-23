//
//  CalculateSolvablePositionViewController.swift
//  UltimatePegSolitaire
//
//  Created by Maksim Khrapov on 11/21/19.
//  Copyright © 2019 Maksim Khrapov. All rights reserved.
//

// https://www.ultimatepegsolitaire.com/
// https://github.com/mkhrapov/ultimate-peg-solitaire
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import UIKit

final class CalculateSolvablePositionViewController: UIViewController {

    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Calculate"
        let backItem = UIBarButtonItem()
        backItem.title = "Calculate"
        navigationItem.backBarButtonItem = backItem
        
        calculateButton.layer.cornerRadius = 10
        calculateButton.clipsToBounds = true
        
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        messageLabel.attributedText = nil
        messageLabel.text = "Tap the Calculate button to calculate solvable initial positions."
    }
    
    
    
    @IBAction func calculateButtonAction(_ sender: UIButton) {
        activityIndicator.startAnimating()
        messageLabel.attributedText = nil
        messageLabel.text = "Calculating..."
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
            let solver = SolvablePositions(GlobalStateManager.shared.newBoard)
            if solver.isConnected() {
                GlobalStateManager.shared.solvable = solver.calculateSolvablePositions()
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.messageLabel.attributedText = nil
                    self.messageLabel.text = "Solvable positions have been calculated. Please proceed to the next screen to select the initial position."
                }
            }
            else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.messageLabel.text = nil
                    let text = "The board is not connected."
                    let attrs = [NSAttributedString.Key.foregroundColor: UIColor.red]
                    self.messageLabel.attributedText = NSAttributedString(string: text, attributes: attrs)
                }
            }
        }
        
        
    }
    
    
}
