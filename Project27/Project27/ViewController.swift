//
//  ViewController.swift
//  Project27
//
//  Created by BERAT ALTUNTAŞ on 2.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var currentDrawType = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectange()
    }

    @IBAction func redrawTUI(_ sender: Any) {
        currentDrawType += 1
        if currentDrawType > 6{
            currentDrawType = 0
        }
        
        switch currentDrawType{
        case 0:
            drawRectange()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawSmile()
        default:
            break
        }
    }
    
    func drawRectange(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    
    func drawCircle(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        imageView.image = image
    }
    func drawCheckerBoard(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8{
                for col in 0..<8{
                    if (row + col) % 2 == 0{
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
            
        }
        imageView.image = image
    }
    func drawRotatedSquares(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            let rotation = 16
            
            let amount = Double.pi / Double(rotation)
            
            for _ in 0..<rotation{
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = image
    }
    func drawLines(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            for  _ in 0..<256{
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first{
                    ctx.cgContext.move(to: CGPoint(x: length, y: -25))
                    first = false
                }else{
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: -25))
                }
                length *= 0.995
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
            
        }
        imageView.image = image
    }
    
    func drawImagesAndText(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key:Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            
            let attributedString = NSAttributedString(string: string,attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
            
        }
        imageView.image = image
    }
    func drawSmile(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            
            let head = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            
            ctx.cgContext.addEllipse(in: head)
            ctx.cgContext.drawPath(using:.fillStroke)
            
            let eye1 = CGRect(x: 280, y: 110, width: 120, height: 160).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: eye1)
            ctx.cgContext.drawPath(using:.fillStroke)
        
            
            let eye2 = CGRect(x: 120, y: 110, width: 120, height: 160).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addEllipse(in: eye2)
            ctx.cgContext.drawPath(using:.fillStroke)
            
            let smile = CGRect(x: 100, y: 370, width: 312, height: 15)
            ctx.cgContext.setFillColor(UIColor.brown.cgColor)
            ctx.cgContext.addRect(smile)
            ctx.cgContext.drawPath(using:.fillStroke)
        }
        imageView.image = image
    }
}

