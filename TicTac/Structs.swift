//
//  Structs.swift
//  TicTac
//
//  Created by Lucas McDonald on 2018-11-10.
//  Copyright © 2018 Lucas McDonald. All rights reserved.
//

import Foundation
import UIKit
public class Node{
    var x:Int;
    var y:Int;
    var sym:String;
    var player:String;
    var button:UIButton?;
    init(x:Int,y:Int)
    {
        self.x = x;
        self.y = y;
        sym = "0";
        player = ""; //unclaimed;
    }
    
    func setButton(Button:UIButton)
    {
        self.button = Button;
    }
    
    func claim(player: String, symbol:String) -> Bool
    {
        if(self.player == ""){
            print("CLAIM HAPPENED at [" + String(self.x) + " , " + String(self.y) + "]");
            print(player);
            print(symbol);

        self.player = player;
        self.sym = symbol;
            return true
        }
        else
        {
            return false;
        }
        
    }
}
