//
//  CollageView.swift
//  AssessmentNO2
//
//  Created by Muhammad  Farhan Akram on 22/10/2024.
//

import UIKit

class CollageView: UIView {
    private var imageLayers: [CAShapeLayer] = []
    private var borderLayers: [CAShapeLayer] = [] // To hold border layers
    private var images: [UIImage?] = [nil, nil, nil] // Array to hold images for each section
    private var imagePickerManager: ImagePickerManager?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        imagePickerManager = ImagePickerManager()
        addGestureRecognizers()
        setupLayers() // Setup shape layers for the sections
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayers() // Update layers when layout changes
    }

    private func setupLayers() {
        // Clear previous layers
        imageLayers.forEach { $0.removeFromSuperlayer() }
        imageLayers.removeAll()
        
        let width = bounds.width
        let height = bounds.height
        
        // Create UIBezierPaths for three distinct sections
        let path1 = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width / 2, height: height / 2)) // Top left
        let path2 = UIBezierPath(rect: CGRect(x: width / 2, y: 0, width: width / 2, height: height / 2)) // Top right
        let path3 = UIBezierPath(rect: CGRect(x: 0, y: height / 2, width: width, height: height / 2)) // Bottom full width
        
        // Create shape layers for each rectangle using UIBezierPaths
        let layer1 = CAShapeLayer.rectangle(roundedRect: CGRect(x: 0, y: 0, width: width / 2, height: height / 2), cornorRadius: 10, color: .clear)
        layer1.path = path1.cgPath
        
        let layer2 = CAShapeLayer.rectangle(roundedRect: CGRect(x: width / 2, y: 0, width: width / 2, height: height / 2), cornorRadius: 10, color: .clear)
        layer2.path = path2.cgPath
        
        let layer3 = CAShapeLayer.rectangle(roundedRect: CGRect(x: 0, y: height / 2, width: width, height: height / 2), cornorRadius: 10, color: .clear)
        layer3.path = path3.cgPath
        
        // Add shape layers to the imageLayers array
        imageLayers.append(layer1)
        imageLayers.append(layer2)
        imageLayers.append(layer3)
        
        // Draw the shape layers on the view
        draw(layer1, layer2, layer3)
        
        // Add borders for each layer
        addBorders()
    }

    private func addBorders() {
        let borderColor = UIColor.orange.cgColor
        let borderWidth: CGFloat = 2.0
        
        for layer in imageLayers {
            let borderLayer = CAShapeLayer()
            borderLayer.path = layer.path
            borderLayer.strokeColor = borderColor
            borderLayer.lineWidth = borderWidth
            borderLayer.fillColor = UIColor.clear.cgColor
            
            layer.addSublayer(borderLayer) // Add border layer to each image layer
            borderLayers.append(borderLayer) // Keep track of the border layers
        }
    }

    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture) // Add tap gesture recognizer
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: self)
        
        // Check which section was tapped
        for (index, layer) in imageLayers.enumerated() {
            if layer.path?.boundingBox.contains(touchPoint) == true {
                selectImage(for: index) // Trigger image selection for the tapped section
                break
            }
        }
    }

    private func selectImage(for index: Int) {
        guard let viewController = UIApplication.topViewController() else {
            print("Error: viewController is not set.")
            return
        }

        imagePickerManager?.pickImages(viewController) { [weak self] selectedImages in
            guard let self = self else { return }
            if let image = selectedImages.first {
                self.images[index] = image // Update the image for the tapped section
                self.setNeedsDisplay() // Redraw the view
            } else {
                print("Error: No image selected or selection canceled.")
            }
        }
    }

    override func draw(_ rect: CGRect) {
        for (index, image) in images.enumerated() {
            if let image = image {
                let imageRect = rectForImage(at: index)
                image.draw(in: imageRect) // Draw the image in its respective section
            }
        }

        // Draw text in each section
        drawText()
    }

    private func drawText() {
        let text = "Tap Here"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.white
        ]

        for index in 0..<3 {
            let imageRect = rectForImage(at: index)
            let textSize = text.size(withAttributes: attributes)
            let textRect = CGRect(
                x: imageRect.origin.x + (imageRect.width - textSize.width) / 2,
                y: imageRect.origin.y + (imageRect.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
            text.draw(in: textRect, withAttributes: attributes) // Draw the text in the center of each section
        }
    }

    private func rectForImage(at index: Int) -> CGRect {
        let width = bounds.width
        let height = bounds.height
        
        switch index {
        case 0: return CGRect(x: 0, y: 0, width: width / 2, height: height / 2) // Top left
        case 1: return CGRect(x: width / 2, y: 0, width: width / 2, height: height / 2) // Top right
        case 2: return CGRect(x: 0, y: height / 2, width: width, height: height / 2) // Bottom full width
        default: return CGRect.zero
        }
    }
}





