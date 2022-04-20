//
//  GameViewController.swift
//  Racing game
//
//  Created by Артём Симан on 7.04.22.
//

import UIKit

class GameViewController: UIViewController {
 
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var carView: UIImageView!
    
    @IBOutlet weak var carWidtConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var carLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var leftTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftFall: UIImageView!
    
    @IBOutlet weak var centerFall: UIImageView!
    
    @IBOutlet weak var rightFall: UIImageView!
    
    var point: CGFloat = 0
    var minx: CGFloat = 0
    var maxx: CGFloat = 0
    var carHeight: CGFloat = 55
 
    let blockWidth: CGFloat = 55
    
    var isCarFrameSetUpped = false
    
    private var windowWidth: CGFloat = 0// ширина экрана
    private var carWidth: CGFloat = 0 // = windowWidth / 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseCarColor(carColor: Settings.shared.carColor)
        chooseHidrance(hidrance: Settings.shared.hindrance)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        moveDownHidrance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubviews()
    }
    
    private func setupSubviews() {
        if !isCarFrameSetUpped {
            windowWidth = self.view.frame.width
            carWidth = windowWidth / 4
            minx = carWidth * 0.25
            maxx = carWidth * 2.75
            point = carWidth * 1.25
            
            carWidtConstraint.constant = carWidth
            carView.layoutIfNeeded()
            carHeight = carView.frame.height
            isCarFrameSetUpped = true
            carLeadingConstraint.constant = carWidth * 1.5
        }
    }
    
    @IBAction func left(_ sender: UIButton) {
        let newX = max(carLeadingConstraint.constant - point, minx)
        moveCar(to: newX)
    }
    
    @IBAction func right(_ sender: UIButton) {
        let newX = min(carLeadingConstraint.constant + point, maxx)
        moveCar(to: newX)
    }
    
    private func moveCar(to point: CGFloat) {
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                self?.carLeadingConstraint.constant = point
                self?.view.layoutIfNeeded()
            },
            completion: { [weak self] _ in
                self?.carLeadingConstraint.constant = point
                self?.view.layoutIfNeeded()
                self?.leftButton.isEnabled = true
                self?.rightButton.isEnabled = true
            }
        )
    }
    
    
    func moveDownHidrance() {
        guard self.mainView.bounds.contains(self.leftFall.frame) || self.leftTopConstraint.constant < 0 else {
            self.leftTopConstraint.constant = 50
            self.centerTopConstraint.constant = 50
            self.rightTopConstraint.constant = 50
            self.view.layoutIfNeeded()
            return self.repeatAnimation()
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: { [weak self] in
            guard let self = self else { return }
            self.leftTopConstraint.constant += 40
            self.centerTopConstraint.constant += 55
            self.rightTopConstraint.constant += 35
            self.view.layoutIfNeeded()
        }, completion: {[weak self] _ in
            self?.repeatAnimation()
        })
    }

    func repeatAnimation() {
        moveDownHidrance()
    }
    
    
    func chooseCarColor(carColor: UIColor) {
        switch carColor {
        case .red:
            return carView.backgroundColor = UIColor.red
        case .blue:
            return carView.backgroundColor = UIColor.blue
        case .black:
            return carView.backgroundColor = UIColor.lightGray
        default:
            return carView.backgroundColor = UIColor.yellow
        }
}
    func chooseHidrance(hidrance: Hindrance) -> UIImage? {
       switch hidrance {
       case .tree:
           return UIImage(named: "tree")
       case .construction:
           return UIImage(named: "construction")
       case .conus:
           return UIImage(named: "conus")
       case .sign:
           return UIImage(named: "conus")
       }
    }
    
}
