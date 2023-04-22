//
//  GameScene.swift
//  DombaTowers Shared
//
//  Created by devon tomlin on 2023-04-22.
//

import SpriteKit

class GameScene: SKScene
{
    
    // Flag to track if player node is added to the scene
    var playerNodeAdded = false

    // Called when the scene is presented by the view
    // In this case, we will create the grid and spawn an enemy
    override func didMove(to view: SKView)
    {
        // Calculate the grid size based on the view's dimensions
        let gridSize = CGSize(width: view.frame.width * 0.8,
                              height: view.frame.height * 0.8)
        let gridPosition = CGPoint(x: view.frame.midX, y: view.frame.midY)
        let grid = CreateGrid(size: gridSize)
        grid.position = gridPosition
        addChild(grid)
        
        // Spawn an enemy and add it to the scene
        SpawnEnemy(gridNode: grid)
    }

    
    // Creates a grid with the specified size and returns an SKNode containing the grid
    func CreateGrid(size: CGSize) -> SKNode
    {
        let gridPadding: CGFloat = 25.0 // Space around the grid
        let gridSize = CGSize(width: size.width - gridPadding * 2,
                              height: size.height - gridPadding * 2)

        // Create a grid node with the calculated size and position
        let gridNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: -gridSize.width / 2, y: -gridSize.height / 2), size: gridSize))
        gridNode.strokeColor = .black
        gridNode.lineWidth = 5.0
        gridNode.fillColor = .clear
        gridNode.position = CGPoint(x: size.width / 2, y: size.height / 2)

        // Define the number of rows, columns, and spacing for the grid
        let numRows = 4
        let numCols = 3
        let tileSpacing: CGFloat = 5.0

        // Calculate the size of each grid tile
        let tileSize = CGSize(
            width: (gridSize.width - CGFloat(numCols - 1) * tileSpacing) / CGFloat(numCols),
            height: (gridSize.height - CGFloat(numRows - 1) * tileSpacing) / CGFloat(numRows)
        )

        let tileColor = UIColor.systemGreen

        // Create the grid tiles and add them to the grid node
        for row in 0..<numRows
        {
            for col in 0..<numCols
            {
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

    
    // Spawns an enemy and adds it to the scene
    func SpawnEnemy(gridNode: SKNode)
    {
        let enemySize = CGSize(width: 40, height: 40)
        let enemy = SKSpriteNode(color: .red, size: enemySize)
        
        let gridPosition = gridNode.position
        let gridSize = gridNode.frame.size
        let padding: CGFloat = 10.0
        
        // Calculate enemy's initial position
        let enemyX = gridPosition.x + gridSize.width / 2 + enemySize.width / 2 + padding
        let enemyY = gridPosition.y - gridSize.height / 2 - enemySize.height / 2 - padding
        
        enemy.position = CGPoint(x: enemyX, y: enemyY)

        // Create actions for enemy movement
        let moveUp = SKAction.moveBy(x: 0, y: gridSize.height + enemySize.height + 2 * padding, duration: 4.0 * Double(gridSize.height / (gridSize.height + gridSize.width)))
        let moveLeft = SKAction.moveBy(x: -(gridSize.width + enemySize.width + 2 * padding), y: 0, duration: 4.0 * Double(gridSize.width / (gridSize.height + gridSize.width)))
        let moveDown = SKAction.moveBy(x: 0, y: -(gridSize.height + enemySize.height + 2 * padding), duration: 4.0 * Double(gridSize.height / (gridSize.height + gridSize.width)))
        let moveRight = SKAction.moveBy(x: gridSize.width + enemySize.width + 2 * padding, y: 0, duration: 4.0 * Double(gridSize.width / (gridSize.height + gridSize.width)))

        // Create a sequence of enemy movement actions
        let moveSequence = SKAction.sequence([moveUp, moveLeft, moveDown, moveRight])

        // Make the enemy repeat the sequence of actions indefinitely
        let repeatAction = SKAction.repeatForever(moveSequence)
        enemy.run(repeatAction)

        // Add the enemy to the scene
        addChild(enemy)
    }

    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval)
    {
        // Add any per-frame update logic here
    }
}
