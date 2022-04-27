//
//  ViewController.swift
//  lbta-facebook-stream-animation
//
//  Created by Maxim Tsyganov on 27.04.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2

        let curvedView = CurvedView(frame: view.frame)
        curvedView.backgroundColor = .yellow
        view.addSubview(curvedView)


        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))


    }

    @objc func handleTap() {
        (0...10).forEach { _ in
            generateAnimatedViews()
        }
    }

    fileprivate func generateAnimatedViews() {

        let imageName = drand48() > 0.5 ? "thumbs_up" : "heart"
        let imageView = UIImageView(image: UIImage(named: imageName))
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)

        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath

        // this code for object dont return his place (made for groupAnimation)
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation]
        groupAnimation.duration = 5.4 + drand48() * 5
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false

        imageView.layer.add(groupAnimation, forKey: nil)
        view.addSubview(imageView)

    }

}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))

    let endPoint = CGPoint(x: -500, y: UIScreen.main.bounds.height * 3/4)

    let biggerRandomYShift = 200 + drand48() * 800
    let cp1 = CGPoint(x: UIScreen.main.bounds.width * 9/10, y: UIScreen.main.bounds.height * 2/5 - biggerRandomYShift)
   // let cp2 = CGPoint(x: UIScreen.main.bounds.width * 1/4, y: UIScreen.main.bounds.height * 1/6 + randomYShift)


    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: endPoint)
    return path
}

class CurvedView: UIView {

    override func draw(_ rect: CGRect) {

        let path = customPath()
        path.lineWidth = 0
        path.stroke()

    }
}
