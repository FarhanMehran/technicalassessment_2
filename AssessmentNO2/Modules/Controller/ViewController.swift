//
//  ViewController.swift
//  AssessmentNO2
//
//  Created by Muhammad  Farhan Akram on 22/10/2024.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collageView = CollageView()
        collageView.backgroundColor = .gray
        self.view.addSubview(collageView)
        
        // Disable autoresizing mask translation to constraints
        collageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints from top and bottom
        NSLayoutConstraint.activate([
            // Top constraint (20 points from the top of the view)
            collageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            // Bottom constraint (20 points from the bottom of the view)
            collageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Left constraint (leading)
            collageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            
            // Right constraint (trailing)
            collageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        // Set the background color of the main view for better visibility
        self.view.backgroundColor = .white
    }
}
