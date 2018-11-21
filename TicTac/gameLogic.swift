//
//  gameLogic.swift
//  TicTac
//
//  Created by Lucas McDonald on 2018-11-15.
//  Copyright © 2018 Lucas McDonald. All rights reserved.
//

import Foundation
import UIKit
class gameLogic
{
   
    var model:Model;
    
    init() {
         model = Model.shared;

    }
    
    func checkIfMovesAvailible() ->Bool
    {
        if(model.grid?[0][0].sym != "0" &&  model.grid?[1][0].sym != "0" &&  model.grid?[2][0].sym != "0" &&  model.grid?[2][1].sym != "0" &&  model.grid?[1][1].sym != "0" &&  model.grid?[0][1].sym != "0" &&  model.grid?[2][2].sym != "0" &&  model.grid?[1][2].sym != "0" &&  model.grid?[0][2].sym != "0")
        {
            return false;
        }
        else
        {
            return true;
        }
        
        
        
        
        
        
    }
    
    public func place(buttonLocation: Int)
    {
        if(buttonLocation == 0)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[0][0].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[0][0].claim(player: "2", symbol: "O")

            }
        }
        
        if(buttonLocation == 1)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[1][0].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[1][0].claim(player: "2", symbol: "O")
                
            }
        }
        if(buttonLocation == 2)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[2][0].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[2][0].claim(player: "2", symbol: "O")
                
            }
        }
        
        
        if(buttonLocation == 3)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[0][1].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[0][1].claim(player: "2", symbol: "O")
                
            }
        }
        
        if(buttonLocation == 4)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[1][1].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[1][1].claim(player: "2", symbol: "O")
                
            }
        }
        if(buttonLocation == 5)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[2][1].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[2][1].claim(player: "2", symbol: "O")
                
            }
        }
        
        if(buttonLocation == 6)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[0][2].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[0][2].claim(player: "2", symbol: "O")
                
            }
        }
        
        if(buttonLocation == 7)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[1][2].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[1][2].claim(player: "2", symbol: "O")
                
            }
        }
        if(buttonLocation == 8)
        {
            if(model.currPlayerLocal == "1")
            {
                model.grid?[2][2].claim(player: "1", symbol: "X")
            }
            else
            {
                model.grid?[2][2].claim(player: "2", symbol: "O")
                
            }
        }
    }
    
    
    
    
    
    public func checkIfEmpty(buttonLocation: Int) -> Bool
    {
       if(buttonLocation == 0)
       {
        if(model.grid?[0][0].sym == "0")
        {
            return true;
        }
        else
        {
            return false;
        }
      }
        
        if(buttonLocation == 1)
        {
            if(model.grid?[1][0].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 2)
        {
            if(model.grid?[2][0].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        
        if(buttonLocation == 3)
        {
            if(model.grid?[0][1].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 4)
        {
            if(model.grid?[1][1].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 5)
        {
            if(model.grid?[2][1].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 6)
        {
            if(model.grid?[0][2].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 7)
        {
            if(model.grid?[1][2].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        if(buttonLocation == 8)
        {
            if(model.grid?[2][2].sym == "0")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        return false;
    }
    
    
    func checkIfWin(localX:Int,localY:Int, Player:String,winText:UILabel) -> Bool
    {
        var Score = 1;
        //right
        var right = probeDirection(xValueToAdd: 1, yValueToAdd: 0, currX: localX, currY: localY, player: Player)
        //left
        var left = probeDirection(xValueToAdd: -1, yValueToAdd: 0, currX: localX, currY: localY,player: Player)
        Score = Score + right + left;
        if(Score>=3){
            animateWin(xValueToAdd: 1, yValueToAdd: 0, currX: localX, currY: localY, player: Player)
            animateWin(xValueToAdd: -1, yValueToAdd: 0, currX: localX, currY: localY, player: Player)
            winText.text = "Player:" + String(Player) + " wins";
            winText.isHidden = false;
            
            return true;
        }
        Score = 1;
        //up
        var up = probeDirection(xValueToAdd: 0, yValueToAdd: 1, currX: localX, currY: localY,player: Player)
        //down
        var down = probeDirection(xValueToAdd: 0, yValueToAdd: -1, currX: localX, currY: localY,player: Player)
        Score = Score + up + down;
        if(Score>=3){
            animateWin(xValueToAdd: 0, yValueToAdd: 1, currX: localX, currY: localY, player: Player)
            animateWin(xValueToAdd: 0, yValueToAdd: -1, currX: localX, currY: localY, player: Player)
            //winText.text = "Player:" + String(Player) + " wins";
            //winText.isHidden = false;
            
            return true;
        }
        Score =  1;
        //upright
        var uR = probeDirection(xValueToAdd: 1, yValueToAdd: 1, currX: localX, currY: localY,player: Player)
        //botleft
        var bL = probeDirection(xValueToAdd: -1, yValueToAdd: -1, currX: localX, currY: localY,player: Player)
        Score = Score + uR + bL;
        if(Score>=3){
            animateWin(xValueToAdd: 1, yValueToAdd: 1, currX: localX, currY: localY, player: Player);
            animateWin(xValueToAdd: -1, yValueToAdd: -1, currX: localX, currY: localY, player: Player)
            winText.text = "Player:" + String(Player) + " wins";
            winText.isHidden = false;
            
            return true;
        }
        Score = 1;
        //upleft
        var uL = probeDirection(xValueToAdd: -1, yValueToAdd: 1, currX: localX, currY: localY,player: Player)
        //botright
        var bR = probeDirection(xValueToAdd: 1, yValueToAdd: -1, currX: localX, currY: localY,player: Player)
        Score = uL + bR + Score;
        if(Score>=3){
            animateWin(xValueToAdd: 1, yValueToAdd: -1, currX: localX, currY: localY,player: Player)
            animateWin(xValueToAdd: -1, yValueToAdd: 1, currX: localX, currY: localY,player: Player);
            winText.text = "Player:" + String(Player) + " wins";
            winText.isHidden = false;
            return true;
        }
        
        return false
        
    }
    
    func animateWin(xValueToAdd:Int,yValueToAdd:Int,currX:Int,currY:Int,player:String)
    {
        var yValueMod = 0;
        var xValueMod = 0;
        var foundWall = false;
        var count = 0;
        while(!foundWall)
        {
            if(currX+xValueMod>=0 && currX+xValueMod <= 2)
            {
                if(currY+yValueMod>=0 && currY+yValueMod <= 2)
                {
                    //print("CHECKING THIS LOCATION:" + String(currX+xValueMod) + "," + String(currY+yValueMod))
                    //print(player);
                    if(model.grid?[currX+xValueMod][currY+yValueMod].player == player)
                    {
                        print(count);
                        /*
                        UIButton.animate(withDuration: 0.7, delay: 0.3, options: [ .allowUserInteraction, .autoreverse], animations: {
                            /*
                            self.model.grid?[currX+xValueMod][currY+yValueMod].button?.frame.origin.y -= 15; //need to change
                             */ self.model.grid?[currX+xValueMod][currY+yValueMod].button?.setTitleColor(UIColor.red, for: .normal)
                            
                        })
                        */
                        
                        self.model.grid?[currX+xValueMod][currY+yValueMod].button?.setTitleColor(UIColor.red, for: .normal)
                        yValueMod = yValueMod + yValueToAdd;
                        xValueMod = xValueMod + xValueToAdd;
                        count = count+1;
                        
                    }
                    else
                    {
                        // blocked by player
                        foundWall = true;
                    }
                    
                }
                else
                {
                    
                    //blocked by y wall
                    foundWall = true;
                }
                
                
            }
            else
            {
                
                //blocked by x wall
                foundWall = true;
            }
            
            
        }
        
        
    }
    
    
    func probeDirection(xValueToAdd:Int,yValueToAdd:Int,currX:Int,currY:Int,player: String) -> Int
    {
        var yValueMod = yValueToAdd;
        var xValueMod = xValueToAdd;
        var foundWall = false;
        var count = 0;
        while(!foundWall)
        {
            if(currX+xValueMod>=0 && currX+xValueMod <= 2)
            {
                if(currY+yValueMod>=0 && currY+yValueMod <= 2)
                {
                    print("CHECKING THIS LOCATION:" + String(currX+xValueMod) + "," + String(currY+yValueMod))
                    
                    
                    print(model.grid?[currX+xValueMod][currY+yValueMod].player == player)
                    print((model.grid?[currX+xValueMod][currY+yValueMod].player)! + "vs" + player)
                    if(model.grid?[currX+xValueMod][currY+yValueMod].player == player)
                    {
                        count = count+1;
                        print(count);
                        yValueMod = yValueMod + yValueToAdd;
                        xValueMod = xValueMod + xValueToAdd;
                    }
                    else
                    {
                        print("Playerblocked or unusued spot");
                        // blocked by player
                        return count;
                    }
                    
                }
                else
                {
                    print("y blocked");
                    
                    //blocked by y wall
                    return count;
                }
                
                
            }
            else
            {
                print("x blocked");
                
                //blocked by x wall
                return count;
            }
            if(count >= 3)
            {
                print("we have a winner");
                return count;
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    /*
    public static func checkIfWin(X:Int, Y:Int) -> Bool{
        /*
        var grid = Model.shared.grid;
        
        
        
        
    }
    
    static func recursiveCallWin(Symbol:String,X:Int, Y:Int, Count: Int) ->Bool
    {
        var grid = Model.shared.grid;
        if(grid?[X][Y].sym == Symbol)
        {
            var newCount = Count+1;
            if(Count==3)
            {
                return true;
            }
        }
        
    */
    }
 */
    
    
    
}
