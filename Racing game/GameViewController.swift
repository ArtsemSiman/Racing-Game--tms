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
    
    private var userScore = 0
    
    
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
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.carView.frame.intersects(self.leftFall.frame) {
                timer.invalidate()
                self.gameOverScreen()
            } else if self.carView.frame.intersects(self.centerFall.frame) {
                timer.invalidate()
                self.gameOverScreen()
            } else if self.carView.frame.intersects(self.rightFall.frame) {
                timer.invalidate()
                self.gameOverScreen()
            }
        }
    }
                  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        moveDownHidrance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubviews()
    }
    
    private func checkUserScore() {
        userScore += 1
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
            self.checkUserScore()
            self.centerTopConstraint.constant = 50
            self.checkUserScore()
            self.rightTopConstraint.constant = 50
            self.checkUserScore()
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
           carView.backgroundColor = UIColor.red
        case .blue:
            carView.backgroundColor = UIColor.blue
        case .black:
            carView.backgroundColor = UIColor.lightGray
        default:
            carView.backgroundColor = UIColor.yellow
        }
}
    func chooseHidrance(hidrance: Hindrance) {
       switch hidrance {
       case .tree:
           return changeHidrance(to: UIImage(named: "tree"))
       case .construction:
           return changeHidrance(to: UIImage(named: "construction"))
       case .conus:
           return changeHidrance(to: UIImage(named: "conus"))
       case .sign:
           return changeHidrance(to:UIImage(named: "sign"))
       }
    }
    
    private func changeHidrance(to image: UIImage?) {
        leftFall.image = image
        centerFall.image = image
        rightFall.image = image
    }
    
    func gameOverScreen() {
        let endScreen = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GO") as! GameOverView
        self.navigationController?.pushViewController(endScreen, animated: true)
    }
}
