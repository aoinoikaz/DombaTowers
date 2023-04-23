//
//  Grid.swift
//  DombaTowers
//
//  Created by devon tomlin on 2023-04-22.
//

import SpriteKit

class Grid: SKNode {
    let numRows: Int
    let numCols: Int
    let tileSize: CGFloat
    let tileSpacing: CGFloat
    var tiles: [[Tile]] = []
    
    var towerSpotsByRow: [Int: [Tile]] = [:]

    var path: [Tile] = [] // Define path as an instance variable

    init(numRows: Int, numCols: Int, tileSpacing: CGFloat, deckHeight: CGFloat, size: CGSize) {
        self.numRows = numRows
        self.numCols = numCols
        self.tileSpacing = tileSpacing

        let availableHeight = size.height - deckHeight
        let tileSizeWidth = (size.width - (CGFloat(numCols) * tileSpacing)) / CGFloat(numCols)
        let tileSizeHeight = (availableHeight - (CGFloat(numRows) * tileSpacing)) / CGFloat(numRows)
        self.tileSize = min(tileSizeWidth, tileSizeHeight)

        super.init()

        let gridNode = SKNode()
        self.addChild(gridNode)
        

        let actualGridWidth = (tileSize * CGFloat(numCols)) + (tileSpacing * CGFloat(numCols - 1))
        let actualGridHeight = (tileSize * CGFloat(numRows)) + (tileSpacing * CGFloat(numRows - 1))
        let offsetX = (size.width - actualGridWidth) / 2
        let offsetY = (availableHeight - actualGridHeight) / 2
        
        gridNode.position = CGPoint(x: -size.width / 2 + offsetX + tileSize / 2, y: -size.height / 2 + offsetY + tileSize / 2 + deckHeight + (availableHeight - actualGridHeight) / 2)

        let tileSizeWithSpacing = tileSize + tileSpacing

        for row in 0..<numRows {
            var tileRow: [Tile] = []
            for col in 0..<numCols {
                let tile = Tile(texture: nil, color: .systemBrown, size: CGSize(width: tileSize, height: tileSize))
                tile.colorBlendFactor = 1.0
                tile.position = CGPoint(
                    x: CGFloat(col) * tileSizeWithSpacing,
                    y: CGFloat(row) * tileSizeWithSpacing
                )
                gridNode.addChild(tile)
                tileRow.append(tile)
            }
            tiles.append(tileRow)
        }

        let deckBarNode = SKSpriteNode(color: .systemPink, size: CGSize(width: size.width, height: deckHeight))
        self.addChild(deckBarNode)
        deckBarNode.position = CGPoint(x: 0.0, y: -size.height / 2 + deckHeight / 2)
        
        generatePathAndTowerSpots()
    }
    
    
    func generatePathAndTowerSpots()
    {
        // Pick a random starting column
        var currentCol = Int.random(in: 0..<numCols)

        // Create a path on the top row
        for row in 0..<1 {
            let tile = tiles[row][currentCol]
            tile.togglePath()
            path.append(tile)
        }

        // Create a path on each subsequent row
        for row in 1..<numRows {
            // Pick a new column within a certain distance from the previous column
            let minCol = max(currentCol - 1, 0)
            let maxCol = min(currentCol + 1, numCols - 1)
            currentCol = Int.random(in: minCol...maxCol)

            let tile = tiles[row][currentCol]
            tile.togglePath()
            path.append(tile)

            // Randomly designate some tiles as tower spots
            if row % 3 == 0 {
                let numTowerSpots = Int.random(in: 1...3)
                var towerSpots: [Tile] = []
                for _ in 0..<numTowerSpots {
                    let towerSpotCol = Int.random(in: 0..<numCols)
                    let towerSpot = tiles[row][towerSpotCol]
                    if !towerSpot.isPath && !towerSpot.isTowerSpot {
                        towerSpot.toggleTowerSpot()
                        towerSpots.append(towerSpot)
                    }
                }
                if !towerSpots.isEmpty {
                    towerSpotsByRow[row] = towerSpots
                }
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



