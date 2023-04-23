//
//  GameScene.swift
//  DombaTowers Shared
//
//  Created by devon tomlin on 2023-04-22.
//

import SpriteKit

class GameScene: SKScene {
    
    let numRows = 10
    let numCols = 10
    let tileSpacing: CGFloat = 2.0
    
    override func didMove(to view: SKView) {
        let gridSize = CGSize(width: view.frame.width, height: view.frame.height * 0.8)
        let deckHeight: CGFloat = 75.0 // Set the height of the deck
        
        let grid = Grid(numRows: numRows, numCols: numCols, tileSpacing: tileSpacing, deckHeight: deckHeight, size: gridSize)
        
        grid.position = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.1 + gridSize.height / 2 + deckHeight / 2)
        
        addChild(grid)
    }
}




