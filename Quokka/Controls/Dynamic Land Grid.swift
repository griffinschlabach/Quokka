//
//  Dynamic Land Grid.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 4/1/25.
//

import Foundation
import SwiftUI

struct LandTile: Identifiable {
    let id = UUID()
    let imageName: String
}

struct DynamicLandGrid: View {
    @Binding var scaleValue: Double

    let tileImageNames: [String] = ["tile1"]

    private var gridDimensions: (rows: Int, columns: Int) {
        var tileCount = calculateTileCount(for: scaleValue)
        var rows = 1
        var columns = 1
        var addColumnNext = true

        while rows * columns < tileCount {
            if addColumnNext {
                columns += 1
            } else {
                rows += 1
            }
            addColumnNext.toggle()
        }
        return (rows: rows, columns: columns)
    }

    var gridTiles: [[LandTile]] {
        let dims = gridDimensions
        var tiles: [LandTile] = (0..<dims.rows * dims.columns).map { _ in
            LandTile(imageName: tileImageNames.randomElement() ?? "tile1")
        }

        return (0..<dims.rows).map { rowIndex in
            Array(tiles[rowIndex * dims.columns..<(rowIndex + 1) * dims.columns])
        }
    }

    var body: some View {
        GeometryReader { geo in
            let dims = gridDimensions
            let tileSize = min(geo.size.width / CGFloat(dims.columns), geo.size.height / CGFloat(dims.rows))
            let gridWidth = tileSize * CGFloat(dims.columns)
            let gridHeight = tileSize * CGFloat(dims.rows)

            ZStack {
                // The grid
                VStack(spacing: 0) {
                    ForEach(gridTiles) { row in
                        HStack(spacing: 0) {
                            ForEach(row) { tile in
                                Image(tile.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: tileSize, height: tileSize)
                                    .clipped()
                            }
                        }
                    }
                }

                // The center image that scales proportionately
                Image("centerIcon") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: tileSize, height: tileSize) // Scales with tiles
            }
            .frame(width: gridWidth, height: gridHeight, alignment: .center)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
    }

    private func calculateTileCount(for value: Double) -> Int {
        let scaled = pow(value, 1.8)
        return max(1, Int(scaled.rounded(.up)))
    }
}


extension Array: Identifiable where Element: Identifiable {
    public var id: UUID { UUID() }
}
