//
//  GameViewController.swift
//  Racing game
//
//  Created by Артём Симан on 7.04.22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var block: UIImageView!
    
    @IBOutlet weak var carView: UIImageView!
    
    @IBOutlet weak var blockDown: NSLayoutConstraint!
    
    let point: CGFloat = 135
    var minx: CGFloat = 0
    var maxx: CGFloat = 0
    var carHeight: CGFloat = 55
    var carWidth: CGFloat = 55
    let blockWidth: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = carView.layer.frame.height
        
    }
    
    private func setupSubviews() {
        let viewSize = self.view.bounds
        let superViewHeight = viewSize.height
        let superViewWidth = viewSize.width
        
        maxx = superViewWidth - carWidth
        
        carView.frame = CGRect(x: superViewWidth / 2 - 25, y: superViewHeight - 160, width: 50, height: 50)
      
        self.view.addSubview(carView)
        
    }
    
    @IBAction func left(_ sender: UIButton) {
        let newX = max(carView.frame.origin.x - point, minx)
        carView.frame.origin.x = newX
    }
    
    @IBAction func right(_ sender: UIButton) {
        let newX = min(carView.frame.origin.x + point, maxx)
        carView.frame.origin.x = newX
    }
 
    private func goingDown () {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut, .repeat], animations: {
            self.blockDown.constant += self.view.frame.height
            self.view.layoutIfNeeded()
        },
                       completion: {_ in
            self.blockDown.constant -= self.view.frame.height
            self.view.layoutIfNeeded()
            self.goingDown()
        })
    }
    
}
