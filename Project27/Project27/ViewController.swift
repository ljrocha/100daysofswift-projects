//
//  ViewController.swift
//  Project27
//
//  Created by Leandro Rocha on 5/29/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawText()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Awesome drawing code
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = image
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // Face
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.addEllipse(in: rectangle)
            
            ctx.cgContext.drawPath(using: .fill)
            
            // Eyes
            ctx.cgContext.setFillColor(UIColor.black.cgColor.copy(alpha: 0.7)!)
            
            let leftRectangle = CGRect(x: 128, y: 128, width: 64, height: 90)
            ctx.cgContext.addEllipse(in: leftRectangle)
            
            let rightRectangle = CGRect(x: 320, y: 128, width: 64, height: 90)
            ctx.cgContext.addEllipse(in: rightRectangle)
            
            ctx.cgContext.drawPath(using: .fillStroke)
            
            // Mouth
            ctx.cgContext.setLineWidth(15)
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor.copy(alpha: 0.7)!)
            
            ctx.cgContext.move(to: CGPoint(x: 128, y: 320))
            ctx.cgContext.addLine(to: CGPoint(x: 384, y: 320))
            
            ctx.cgContext.drawPath(using: .stroke)
        }
        
        imageView.image = image
    }
    
    func drawText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // "T"
            ctx.cgContext.move(to: CGPoint(x: 81, y: 128))
            ctx.cgContext.addLine(to: CGPoint(x: 206, y: 128))
            
            ctx.cgContext.move(to: CGPoint(x: 143.5, y: 128))
            ctx.cgContext.addLine(to: CGPoint(x: 143.5, y: 256))
            
            // "W"
            ctx.cgContext.move(to: CGPoint(x: 210, y: 128))
            ctx.cgContext.addLine(to: CGPoint(x: 241.25, y: 256))
            
            ctx.cgContext.addLine(to: CGPoint(x: 272.5, y: 128))
            
            ctx.cgContext.addLine(to: CGPoint(x: 303.75, y: 256))
            
            ctx.cgContext.addLine(to: CGPoint(x: 335, y: 128))
            
            // "I"
            ctx.cgContext.move(to: CGPoint(x: 341, y: 128))
            ctx.cgContext.addLine(to: CGPoint(x: 341, y: 256))
            
            // "N"
            ctx.cgContext.move(to: CGPoint(x: 347, y: 256))
            ctx.cgContext.addLine(to: CGPoint(x: 347, y: 128))
            
            ctx.cgContext.addLine(to: CGPoint(x: 447, y: 256))
            
            ctx.cgContext.addLine(to: CGPoint(x: 447, y: 128))
            
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }

    
}

