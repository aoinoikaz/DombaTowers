//
//  GameScene.swift
//  DombaTowers Shared
//
//  Created by devon tomlin on 2023-04-22.
//

import SpriteKit

class GameScene: SKScene
{
    
    var playerNodeAdded = false

    
    // Life cycle method in sprite kit framework that is called
    // when the scene is first presented - in this case
    // we will simply call our grid creation method
    override func didMove(to view: SKView)
    {
        let gridSize = CGSize(width: view.frame.width * 0.8,
                              height: view.frame.height * 0.8)
        let gridPosition = CGPoint(x: view.frame.midX, y: view.frame.midY)
        let grid = CreateGrid(size: gridSize)
        grid.position = gridPosition
        addChild(grid)
        
        SpawnEnemy(gridNode: grid)
    }

    
    func CreateGrid(size: CGSize) -> SKNode
    {
        let gridPadding: CGFloat = 25.0 // adjust as necessary
        let gridSize = CGSize(width: size.width - gridPadding * 2,
                              height: size.height - gridPadding * 2)
        
        let gridNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: -gridSize.width / 2, y: -gridSize.height / 2), size: gridSize))
        gridNode.strokeColor = .black
        gridNode.lineWidth = 5.0
        gridNode.fillColor = .clear
        gridNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let numRows = 4
        let numCols = 3
        let tileSpacing: CGFloat = 5.0
        
        
        let tileSize = CGSize(
            width: (gridSize.width - CGFloat(numCols - 1) * tileSpacing) / CGFloat(numCols),
            height: (gridSize.height - CGFloat(numRows - 1) * tileSpacing) / CGFloat(numRows)
        )
    
        let tileColor = UIColor.systemGreen
        
        for row in 0..<numRows {
            for col in 0..<numCols {
                let tile = SKSpriteNode(color: tileColor, size: tileSize)
                tile.position = CGPoint(
                    x: -gridSize.width / 2 + tileSize.width / 2 + CGFloat(col) * (tileSize.width + tileSpacing),
                    y: -gridSize.height / 2 + tileSize.height / 2 + CGFloat(row) * (tileSize.height + tileSpacing)
                )
                gridNode.addChild(tile)
            }
        }
        
        return gridNode
    }
    
    func SpawnEnemy(gridNode: SKNode)
    {
        let enemySize = CGSize(width: 40, height: 40)
        let enemy = SKSpriteNode(color: .red, size: enemySize)

        let gridPosition = gridNode.position
        let gridSize = gridNode.frame.size
        let padding: CGFloat = 10.0

        let enemyX = gridPosition.x + gridSize.width / 2 + enemySize.width / 2 + padding
        let enemyY = gridPosition.y - gridSize.height / 2 - enemySize.height / 2 - padding
        enemy.position = CGPoint(x: enemyX, y: enemyY)

        let moveUp = SKAction.moveBy(x: 0, y: gridSize.height + enemySize.height + 2 * padding, duration: 4.0 * Double(gridSize.height / (gridSize.height + gridSize.width)))
        let moveLeft = SKAction.moveBy(x: -(gridSize.width + enemySize.width + 2 * padding), y: 0, duration: 4.0 * Double(gridSize.width / (gridSize.height + gridSize.width)))
        let moveDown = SKAction.moveBy(x: 0, y: -(gridSize.height + enemySize.height + 2 * padding), duration: 4.0 * Double(gridSize.height / (gridSize.height + gridSize.width)))
        let moveRight = SKAction.moveBy(x: gridSize.width + enemySize.width + 2 * padding, y: 0, duration: 4.0 * Double(gridSize.width / (gridSize.height + gridSize.width)))

        let moveSequence = SKAction.sequence([moveUp, moveLeft, moveDown, moveRight])
        let repeatAction = SKAction.repeatForever(moveSequence)
        enemy.run(repeatAction)

        addChild(enemy)
    }



    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

