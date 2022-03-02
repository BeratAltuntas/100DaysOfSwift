//
//  ViewController.swift
//  Project15
//
//  Created by BERAT ALTUNTAŞ on 2.03.2022.
//

import UIKit

class ViewController: UIViewController {
    var imageView:UIImageView!
    var currentAnimation = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    @IBAction func tapped(_ sender: UIButton){
        sender.isHidden = true
        
        //UIView.animate(withDuration: 1, delay: 0, options: []) { sade bir şekilde verilen komutları yerine getirip yavaş bir animasyon gibi kodları yerine getiriyor.
        
        //fakat aşağıdaki kod UIView.animate with spring ise daha hareketli bir şekilde kendisi verilen komutların üzerine ekleme yaparak daha sallantılı bir animasyon göstermeyi sağlıyor.  ---usingSpringWithDamping: 1 e yaklaştıkça sabitleşiyor ve ekstra sallantı azalıyor.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []){
            switch self.currentAnimation{
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.imageView.transform = .identity
                break
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                break
            case 3:
                self.imageView.transform = CGAffineTransform(translationX: 256, y: 256)
                break
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                break
            case 5:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = .green
                
            default:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = .clear
                self.imageView.transform = .identity
                break
            }
        } completion: { finished in
            sender.isHidden = false
        }

        currentAnimation+=1
        if currentAnimation > 6 {
            
            currentAnimation = 0
        }
    }
}

