//
//  networkController.swift
//  TicTac
//
//  Created by Lucas McDonald on 2018-11-04.
//  Copyright © 2018 Lucas McDonald. All rights reserved.
//
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON
import CoreData
import Foundation
import UIKit;


extension NSDictionary {
    var swiftDictionary: Dictionary<String, Any> {
        var swiftDictionary = Dictionary<String, Any>()
        
        for key : Any in self.allKeys {
            let stringKey = key as! String
            if let keyValue = self.value(forKey: stringKey){
                swiftDictionary[stringKey] = keyValue
            }
        }
        
        return swiftDictionary
    }
}


public class networkController{
    private var isMyTurn = false;
    var infoLabel:UILabel;
    var ref: DatabaseReference!
    var userReferenceId = 0;
    var userName:String?
    var waitingInQueue = false;
    var foundMatch = false;
    var sym = "";
    init(infoLabel:UILabel)
    {
        self.infoLabel = infoLabel;
    }
    public var turnNumber:Int32?;
    public func checkIfCurrentTurn(completion: @escaping () -> Void)
    {
        print("-------Turn Calculation------")

        game =  ref.child("games").child(gameNumber!);
        game?.observeSingleEvent(of: .value, with: { (snapshot) in
           var tempDic = (snapshot.value as! NSDictionary);

           var tempNSString = tempDic["turn"] as! NSString
            self.turnNumber = (tempNSString.intValue)
            completion();
        
            
        })
 

    }
    
    public func checkIfUserName(newUserName:String) -> Bool
    {
        if(userName != nil && newUserName == userName)
        {
            return true;
        }
        else{
        return false;
        }
    }
    
    public func endGame()
    {
        if(waitingInQueue)
        {
            self.ref.child("queue").child(String(self.userReferenceId)).removeValue()
        }
        ref.removeAllObservers();
        game?.removeAllObservers();
        opponent = nil;
        waitingInQueue = false
        foundMatch = false
        sym = "";
        game = nil;
        
    }
    public func truncateIfNeeded(name: String ) -> String
    {
        if(name.count > 14)
        {
            return String(name.prefix(14));
        }
        return name;
        
    }
    
    
    public func startNetworking(username:String)
    {
        modelInstance.mode = "Internet";
        var foundMatch = false;
        ref = Database.database().reference()
        if(!checkIfUserName(newUserName: username)){
            if(username == "")
            {
                userName = "Onion"
            }
            else
            {
                userName = truncateIfNeeded(name: username)
            }
        userReferenceId = Int(arc4random_uniform(20000))
        userName = username;
        createUser();
        }
        checkIfQueueEmpty(){
            if(self.queue?.allKeys.count==0 || (self.queue?.allKeys.count) == nil)
            {
                self.infoLabel.text = "Waiting for Opponent!"

                self.enterQueue();
                self.sym = "O";
                self.waitingInQueue = true;
            }
            else{
                print("LETS LOG BAD THING")
                print(self.queue?.allKeys.count)
                
                self.findPartner(){
                    //print("player matched");
                }
            }
            
        }
    }
    
    var gameNumber:String?;
    var opponent: String?;
    func findPartner(completion: @escaping () -> Void)
    {
       // print("matching with partner");
        self.sym = "X"
        ref.child("queue").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChildren(){
                
                
                self.queue = (snapshot.value as! NSDictionary);
                let lower = self.queue![(self.queue?.allKeys[0]) as! String] as! NSDictionary;
                if(lower["opponent"] as? String == nil)
                {
                    self.gameNumber =  String(Int(arc4random_uniform(20000)))
                    self.opponent = lower["userName"] as? String
                    self.ref.child("queue").child(self.queue?.allKeys[0] as! String).child("opponent").setValue([self.userName!:self.gameNumber])
                    self.createGame(completion: {
                        self.isMyTurn = true;
                        self.foundMatch = true;
                        //startGameUpdate(completion: ])
                    })
                }

            }
        })
    }
    var game:DatabaseReference?;
    var playerNumber:Int?
    func createGame(completion: @escaping () -> Void)
    {
        infoLabel.text = "You're X!"
        var gameDictionary = [String: String]()
        gameDictionary["grid"] = "000 000 000";
         gameDictionary["player1"] = userName
         gameDictionary["player2"] = opponent
        gameDictionary["turn"] = "1"
        self.modelInstance.gVController?.Player1Outlet.text = self.userName;
        self.modelInstance.gVController?.Player2Outlet.text =  self.opponent;
         self.modelInstance.gVController?.versusOutlet.text =  "VS";
        playerNumber = 1;
       // var gameDictionary = [gameNumber:[["grid":"000 000 000"],["player1":userName],["player2":opponent]]]
        
        self.ref.child("games").child(gameNumber!).setValue(gameDictionary);
        startGameUpdate()

    }
    
 
    public func placeMark(markToPlace: Int, playerToPlace: String, symbolToUse: String)
    {
        var temp = false;
        var x = -1;
        var y = -1;
        
        switch markToPlace { //
        case 0:
            temp = modelInstance.grid![0][0].claim(player: playerToPlace, symbol: symbolToUse)
            x=0;
            y=0;
            break;
        case 1:
            temp = modelInstance.grid![1][0].claim(player: playerToPlace, symbol: symbolToUse)
            x=1;
            y=0;
            break
        case 2:
            temp = modelInstance.grid![2][0].claim(player: playerToPlace, symbol: symbolToUse)
            x=2;
            y=0;
            break
        case 3:
            
            temp = modelInstance.grid![0][1].claim(player: playerToPlace, symbol: symbolToUse)
            x=0;
            y=1;
            break
        case 4:
            temp = modelInstance.grid![1][1].claim(player: playerToPlace, symbol: symbolToUse)
            x=1;
            y=1;
            break
        case 5:
            temp = modelInstance.grid![2][1].claim(player: playerToPlace, symbol: symbolToUse)
            x=2;
            y=1;
            break
        case 6:
            temp = modelInstance.grid![0][2].claim(player: playerToPlace, symbol: symbolToUse)
            x=0;
            y=2;
            break
        case 7:
            temp = modelInstance.grid![1][2].claim(player: playerToPlace, symbol: symbolToUse)
            x=1;
            y=2;
            break;
        case 8:
            temp = modelInstance.grid![2][2].claim(player: playerToPlace, symbol: symbolToUse)
            x=2;
            y=2;
            break;
        default:
            print("ERROR networkcontroller placemark out of bounds, something is up")
            
        }
        if(temp)
        {
      
             if(symbolToUse == sym)
             {
                let tempTurnString = String(turnNumber! + 1)
                game?.child("turn").setValue(tempTurnString)
                updateGrid()
            }
            modelInstance.gVController?.gridUpdateOccured();
            if(symbolToUse == "O")
            {
                if((modelInstance.gLogic?.checkIfWin(localX: x, localY: y, Player: "2", winText: infoLabel))!)
                {
                    if(sym=="O")
                    {
                        infoLabel.text = "THE WINNER IS " + userName!;
                          endGame()
                    }
                    else
                    {
                        infoLabel.text = "THE WINNER IS " + opponent!;
                        endGame()
                    }
                }
                else
                {
                    if(!(modelInstance.gLogic?.checkIfMovesAvailible())!)
                    {
                        infoLabel.text = "TIE between " + userName! + "and" + opponent!;
                          endGame()
                        
                    }
                }
                
            }
            else{
                if((modelInstance.gLogic?.checkIfWin(localX: x, localY: y, Player: "1", winText: infoLabel))!)
                {
                    if(sym=="X")
                    {
                infoLabel.text = "THE WINNER IS " + userName!;
                          endGame()
                    }
                    else
                    {
                        infoLabel.text = "THE WINNER IS " + opponent!;
                          endGame()

                    }
                }
                else
                {
                    if(!(modelInstance.gLogic?.checkIfMovesAvailible())!)
                    {
                        infoLabel.text = "TIE between " + userName! + "and" + opponent!;
                          endGame()
                        
                    }
                }
            }
            
    
        }
 
    }
    
    public func getPlayerName(FirstOrSecond:Int) -> String
    {
     if(FirstOrSecond == 1)
     {
        return self.ref.child("games").child(gameNumber!).child("player1") as! String;

     }else
        if(FirstOrSecond == 2)
        {
            return self.ref.child("games").child(gameNumber!).child("player2") as! String;

        }else{
            return "ERROR AT GPN"

        print("ERROR AT GET PLAYER NAME WITH WRONG PLAYER NUMBER:" + String(FirstOrSecond));
        }
    }
    
    func updateGrid()
    {
       self.ref.child("games").child(gameNumber!).child("grid").setValue(convertBackToString())

    }
    
    func convertBackToString() ->String
    {
            //there should only be one node changed between turns but there was some difficulty finding just the change, so this checks the whole grid.
            //var grid = [[Node]]();
        var tempString = modelInstance.grid![0][0].sym
        tempString.append(modelInstance.grid![1][0].sym)
        tempString.append(modelInstance.grid![2][0].sym)
        tempString.append(" ")
        tempString.append(modelInstance.grid![0][1].sym)
        tempString.append(modelInstance.grid![1][1].sym)
        tempString.append(modelInstance.grid![2][1].sym)
        tempString.append(" ")
        tempString.append(modelInstance.grid![0][2].sym)
        tempString.append(modelInstance.grid![1][2].sym)
        tempString.append(modelInstance.grid![2][2].sym)

        return tempString;

    }
    
    
    func startGameUpdate()
    {
         foundMatch = true;

        game =  ref.child("games").child(gameNumber!);
        game?.observe(.childChanged, with: { (snapshot) in
            print("updateOccured");
            var tempDic = snapshot.value as? NSDictionary;
            print(snapshot.value);
            self.updateGridFromString(refString: snapshot.value as! String)
           /*
            if(tempDic!["gameOver"] as? String != nil)
            {
                self.gameOver(gameOverString: (tempDic!["gameOver"] as? String)!)
                print("GAME OVEER MAN!")
            }
            else
            {
                self.isMyTurn = !self.isMyTurn;
            }
             */


        })
    }
    

    
/*
    public func updateGrid(Grid: String){
        for indexY in 0...2
        {
            for indexX in 0...2
            {
                
            }
            
            
        }
  */
    

    func createUser()
    {
        ref.child("users").child(String(userReferenceId)).setValue(userName);
    }
    //var grid : [[Node]]?;
    var modelInstance = Model.shared;
  
    func enterQueue()
    {
        ref.child("queue").child(String(userReferenceId)).setValue(["userName":userName]);
        waitingInQueue = true;
        let queueRef =  ref.child("queue").child(String(userReferenceId))
        queueRef.observe(.childAdded, with: { (snapshot) in
            let nsDicTemp = snapshot.value as? NSDictionary;

            if(nsDicTemp?.allKeys[0] != nil){
               // print(nsDicTemp?.allKeys[0] as Any);
            var temp =  nsDicTemp![nsDicTemp?.allKeys[0]] as! String;
                self.gameNumber = temp;
                print(self.gameNumber);
            self.opponent = nsDicTemp?.allKeys[0] as? String;
                self.infoLabel.text = "You're O!"
                self.modelInstance.gVController?.Player1Outlet.text = self.userName;
                self.modelInstance.gVController?.Player2Outlet.text =  self.opponent;
                self.modelInstance.gVController?.versusOutlet.text =  "VS";

                queueRef.removeAllObservers();
                self.ref.child("queue").child(String(self.userReferenceId)).removeValue() // garbage collection
                self.startGameUpdate()
            print("player found");
            }
        })
    }
    var queue:NSDictionary?;
    func checkIfQueueEmpty(completion: @escaping () -> Void)
    {
        
        
        ref.child("queue").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChildren(){
                self.queue = (snapshot.value as! NSDictionary);
                print("room has players")

                completion();
                
            }else{
                print("room has no queueplayers")
                completion();
            }
            
            
        })
        
        
        
        
    }
    
    
    func updateGridFromString(refString: String)
    {
        //there should only be one node changed between turns but there was some difficulty finding just the change, so this checks the whole grid.
        //var grid = [[Node]]();
        if(refString[0] !=  modelInstance.grid![0][0].sym && modelInstance.grid![0][0].sym == "0")
        {
            if(refString[0] == "X")
            {
              
                placeMark(markToPlace: 0, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[0] == "O")
                {
                    placeMark(markToPlace: 0, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        if(refString[1] !=  modelInstance.grid![1][0].sym && modelInstance.grid![1][0].sym == "0")
        {
            if(refString[1] == "X")
            {
                placeMark(markToPlace: 1, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[1] == "O")
                {
                    placeMark(markToPlace: 1, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        if(refString[2] !=  modelInstance.grid![2][0].sym && modelInstance.grid![2][0].sym == "0")
        {
            if(refString[2] == "X")
            {
                placeMark(markToPlace: 2, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[2] == "O")
                {
                    placeMark(markToPlace: 2, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        if(refString[4] !=  modelInstance.grid![0][1].sym && modelInstance.grid![0][1].sym == "0")
        {
            if(refString[4] == "X")
            {
                placeMark(markToPlace: 3, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[4] == "O")
                {
                    placeMark(markToPlace: 3, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        
        if(refString[5] !=  modelInstance.grid![1][1].sym && modelInstance.grid![1][1].sym == "0")
        {
            if(refString[5] == "X")
            {
                placeMark(markToPlace: 4, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[5] == "O")
                {
                    placeMark(markToPlace: 4, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        if(refString[6] !=  modelInstance.grid![2][1].sym && modelInstance.grid![2][1].sym == "0")
        {
            if(refString[6] == "X")
            {
                placeMark(markToPlace: 5, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[6] == "O")
                {
                    placeMark(markToPlace: 5, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        if(refString[8] !=  modelInstance.grid![0][2].sym && modelInstance.grid![0][2].sym == "0")
        {
            if(refString[8] == "X")
            {
                placeMark(markToPlace: 6, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[8] == "O")
                {
                    placeMark(markToPlace: 6, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        if(refString[9] !=  modelInstance.grid![1][2].sym && modelInstance.grid![1][2].sym == "0")
        {
            if(refString[9] == "X")
            {
                placeMark(markToPlace: 7, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[9] == "O")
                {
                    placeMark(markToPlace: 7, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        
        if(refString[10] !=  modelInstance.grid![2][2].sym[0] && modelInstance.grid![2][2].sym == "0")
        {
            if(refString[10] == "X")
            {
                placeMark(markToPlace: 8, playerToPlace: "1", symbolToUse: "X")
            }
            else
            {
                if(refString[10] == "O")
                {
                    placeMark(markToPlace: 8, playerToPlace: "2", symbolToUse: "O")
                }
            }
        }
        
        

    }
    
    
    

    
    
}
