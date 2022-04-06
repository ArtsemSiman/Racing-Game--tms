//
//  SettingsViewController.swift
//  Racing game
//
//  Created by Артём Симан on 1.04.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    @IBOutlet weak var speedSlider: UISlider!
    
    @IBOutlet weak var hindranceControl: UISegmentedControl!
    
    private let colors = [UIColor.red, UIColor.black, UIColor.blue]
    private let hindrance = [Hindrance.tree, Hindrance.construction, Hindrance.conus, Hindrance.sign]
    
    @IBAction func save(_ sender: Any) {
        navigationController?.popToRootViewController( animated: true)
        Settings.shared.carColor = colors[colorControl.selectedSegmentIndex]
        Settings.shared.speed = speedSlider.value
        Settings.shared.hindrance = hindrance[hindranceControl.selectedSegmentIndex]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorControl.selectedSegmentIndex = colors.firstIndex(of: Settings.shared.carColor) ?? 0
        
        speedSlider.value = Settings.shared.speed
        hindranceControl.selectedSegmentIndex = hindrance.firstIndex(of: Settings.shared.hindrance) ?? 0


    }
  
    @IBAction func changeColor(_ sender: UISegmentedControl) {
       
    }
    
    @IBAction func changeSpeed(_ sender: UISlider) {
        
    }
    
    @IBAction func changeHindrance(_ sender: UISegmentedControl) {
       
    }
    
}
