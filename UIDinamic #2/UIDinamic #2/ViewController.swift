//
//  ViewController.swift
//  UIDinamic #2
//
//  Created by MacBook on 14.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //UISnapBehavior
    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createGesrureRecognizer()
        createSmallSquareView()
        createAnimatorAndBehaviors()
    }
    
    func createGesrureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
        view.addGestureRecognizer(tap)
    }
    
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        squareView.backgroundColor = UIColor.green
        squareView.center = view.center
        view.addSubview(squareView)
    }
    
    func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        //Зацеп
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
    
    @objc func handleTap(paramTap: UITapGestureRecognizer) {
        //Получаем угол между центром квадрата View и точкой касания
        let tapPoint = paramTap.location(in: view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 1.0  //Средняя осцилляция
        animator.addBehavior(snapBehavior!)
    }
    


}

