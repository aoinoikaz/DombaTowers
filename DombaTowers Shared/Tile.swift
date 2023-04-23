//
//  Tile.swift
//  DombaTowers
//
//  Created by devon tomlin on 2023-04-22.
//

import SpriteKit

class Tile: SKSpriteNode {
    
    var isPath = false
    var isTowerSpot = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.color = color
        self.colorBlendFactor = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func togglePath() {
        isPath = !isPath
        color = isPath ? .systemRed : .systemGreen
    }
    
    func toggleTowerSpot() {
        isTowerSpot = !isTowerSpot
        color = isTowerSpot ? .systemBlue : .systemGreen
    }
}


