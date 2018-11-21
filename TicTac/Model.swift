//
//  model.swift
//  TicTac
//
//  Created by Lucas McDonald on 2018-11-11.
//  Copyright © 2018 Lucas McDonald. All rights reserved.
//

import Foundation
public class Model{

    static let shared = Model();
    var gLogic: gameLogic?;
    var gVController: gameViewController?
    var nController: networkController?
    var grid : [[Node]]?
    public var currPlayerLocal = "1";
    public var mode = "Local";
    private init()
    {
        //gLogic = gameLogic();

        resetGrid();
    }
    
    

    public func resetGame()
    {
        resetGrid();
        gVController?.gridUpdateOccured();
    }
    
    
    public func resetGrid()
    {
        var singleGrid = [[Node]]();
        var nodeLine = [Node]();
        print("Reset called")
        for x in 0...2{
            for y in 0...2
            {
                print("creating:" + String(x) + "," + String(y))
                nodeLine.append(Node(x: x, y: y));
                
            }
            singleGrid.append(nodeLine);
            nodeLine.removeAll();
        }
        grid = singleGrid;
        print(grid?.count);
    }
    /*
    public func getGrid() -> [[Node]]
    {
        if(grid != nil)
        {
            return grid!;
        }
        else
        {
            print( "Hey theres an error in grid initalization")
            resetGrid();
            return grid!;
        }
            
            
    }
    */
    public func initalSetup(GameViewController:gameViewController, NetworkController:networkController)
    {
        gVController = GameViewController;
        nController = NetworkController;
        gLogic = gameLogic();
    }
    

    }

