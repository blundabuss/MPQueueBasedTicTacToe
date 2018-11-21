//
//  ViewController.swift
//  TicTac
//
//  Created by Lucas McDonald on 2018-11-04.
//  Copyright © 2018 Lucas McDonald. All rights reserved.
//

import UIKit
public class gameViewController: UIViewController {
    @IBOutlet weak var topLeftGridOutlet: UIButton!
    @IBOutlet weak var topRightGridOutlet: UIButton!
    @IBOutlet weak var topMidGridOutlet: UIButton!
    
    @IBOutlet weak var midLeftGridOutlet: UIButton!
    
    @IBOutlet weak var midMidGridOutlet: UIButton!
    
    @IBOutlet weak var midRightGridOutlet: UIButton!
    
    @IBOutlet weak var botLeftGridOutlet: UIButton!
    var buttonArray: [[UIButton]]?
    @IBOutlet weak var networkInformationOutlet: UILabel!
    
    @IBOutlet weak var nameAndConnectView: UIView!
    @IBOutlet weak var botMidGridOutlet: UIButton!
    @IBOutlet weak var botRightGridOutlet: UIButton!
    public var model = Model.shared
    override public func viewDidLoad() {
        super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
        let netController = networkController(infoLabel: networkInformationOutlet);
        model.initalSetup(GameViewController: self, NetworkController: netController)
        gridUpdateOccured();
        
        endGameOutlet.isEnabled = false;

        topLeftGridOutlet.isExclusiveTouch = true;
        topMidGridOutlet.isExclusiveTouch = true;
        topRightGridOutlet.isExclusiveTouch = true;
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        // Pabs123 and Esqarrouth provided the answer to this at https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        
        midLeftGridOutlet.isExclusiveTouch = true;
        midMidGridOutlet.isExclusiveTouch = true;
        midRightGridOutlet.isExclusiveTouch = true;
        
        botLeftGridOutlet.isExclusiveTouch = true;
        botMidGridOutlet.isExclusiveTouch = true;
        botRightGridOutlet.isExclusiveTouch = true;
        
        model.grid?[0][0].button = botLeftGridOutlet;
        model.grid?[1][0].button = botMidGridOutlet;
        model.grid?[2][0].button = botRightGridOutlet;

        model.grid?[0][1].button = midLeftGridOutlet;
        model.grid?[1][1].button = midMidGridOutlet;
        model.grid?[2][1].button = midRightGridOutlet;

        model.grid?[0][2].button = topLeftGridOutlet;
        model.grid?[1][2].button = topMidGridOutlet;
        model.grid?[2][2].button = topRightGridOutlet;

        botLeftGridOutlet.titleLabel?.numberOfLines = 0;
        botMidGridOutlet.titleLabel?.numberOfLines = 0;
        botRightGridOutlet.titleLabel?.numberOfLines = 0;
        
        midLeftGridOutlet.titleLabel?.numberOfLines = 0;
         midMidGridOutlet.titleLabel?.numberOfLines = 0;
         midRightGridOutlet.titleLabel?.numberOfLines = 0;
        
        topLeftGridOutlet.titleLabel?.numberOfLines = 0;
        topMidGridOutlet.titleLabel?.numberOfLines = 0;
        topRightGridOutlet.titleLabel?.numberOfLines = 0;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func enterPressedName(_ sender: Any) {
                view.endEditing(true)
    }
    
    @IBOutlet weak var connectButtonOutlet: UIButton!
    
    
    public func gridUpdateOccured(){

        if(model.grid![0][0].sym == "0")
        {
            botLeftGridOutlet.setTitle("", for: .normal)

        }
        else{
        botLeftGridOutlet.setTitle(model.grid![0][0].sym, for: .normal)
        }
        
        
           // botLeftGridOutlet.setTitleColor(UIColor.black, for: .normal)

        if(model.grid![1][0].sym == "0")
        {
            botMidGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            botMidGridOutlet.setTitle(model.grid![1][0].sym, for: .normal)
        }
        
        
        if(model.grid![2][0].sym == "0")
        {
            botRightGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            botRightGridOutlet.setTitle(model.grid![2][0].sym, for: .normal)
        }
        
        if(model.grid![0][1].sym == "0")
        {
            midLeftGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            midLeftGridOutlet.setTitle(model.grid![0][1].sym, for: .normal)
        }
        
        if(model.grid![1][1].sym == "0")
        {
            midMidGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            midMidGridOutlet.setTitle(model.grid![1][1].sym, for: .normal)
        }
        
        if(model.grid![2][1].sym == "0")
        {
            midRightGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            midRightGridOutlet.setTitle(model.grid![2][1].sym, for: .normal)
        }
        
        if(model.grid![0][2].sym == "0")
        {
            topLeftGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            topLeftGridOutlet.setTitle(model.grid![0][2].sym, for: .normal)
        }
        
        if(model.grid![1][2].sym == "0")
        {
            topMidGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            topMidGridOutlet.setTitle(model.grid![1][2].sym, for: .normal)
        }
        
        if(model.grid![2][2].sym == "0")
        {
            topRightGridOutlet.setTitle("", for: .normal)
            
        }
        else{
            topRightGridOutlet.setTitle(model.grid![2][2].sym, for: .normal)
        }
        
        
        
        
        
        
    

        
        
        //topLeftGridOutlet.setTitle(model.grid![0][2].sym, for: .normal)
        //topMidGridOutlet.setTitle(model.grid![1][2].sym, for: .normal)
        //topRightGridOutlet.setTitle(model.grid![2][2].sym, for: .normal)

    }
    
    public func handleButton(buttonID: Int)
    {
        print(model.mode);
        if(model.mode == "Local")
        {
            if((model.gLogic?.checkIfEmpty(buttonLocation: buttonID))!)
            {
                print("This happened")
                model.gLogic?.place(buttonLocation: buttonID)
                convertToArrayLocationAndCheck(buttionID: buttonID)
                gridUpdateOccured()
                endGameOutlet.isEnabled = true;
                if(model.currPlayerLocal == "1")
                {
                    model.currPlayerLocal = "2";
                }
                else
                {
                    model.currPlayerLocal = "1"
                }
            }
        }
        if(model.mode == "AI")
        {
            
        }
        if(model.mode == "Internet" && (model.nController?.foundMatch)!)
        {
            //model.nController?.placeMark(markToPlace: buttonID, completion: {
            model.nController?.checkIfCurrentTurn {
                if((self.model.nController?.turnNumber)! % 2 == 0) //mod is useful as it can tell us even numbered turns 2 mod 2 = 0, 4 mod 2 = 0 etc
                {
                    if(self.model.nController?.sym == "O")
                    {
                        self.model.nController?.placeMark(markToPlace: buttonID, playerToPlace: "2" , symbolToUse: "O")
                        
                    }

                }
                else
                {
                    if(self.model.nController?.sym == "X")
                    {
                        self.model.nController?.placeMark(markToPlace: buttonID, playerToPlace: "1" , symbolToUse: "X")
                    }

                    
                }
            }
        }
    }
    
    /*
    if((turnNumber?.intValue)! % 2 == 0) //mod is useful as it can tell us even numbered turns 2 mod 2 = 0, 4 mod 2 = 0 etc
    {
    if(sym == "O")
    {
    return true
    }
    else
    {
    return false
    }
    }
    else
    {
    if(sym == "X")
    {
    return true
    }
    else
    {
    return false
    }
    
    }
 */
    @IBOutlet weak var Player1Outlet: UILabel!
    
    @IBOutlet weak var Player2Outlet: UILabel!
    @IBAction func TLButtonUp(_ sender: Any) {
        handleButton(buttonID:6);

    }
    
    @IBAction func TMButtonUp(_ sender: Any) {
        handleButton(buttonID:7);

    }
    
    @IBAction func TRButtonUp(_ sender: Any) {
        handleButton(buttonID:8);

    }
    
    @IBAction func MLButtonUp(_ sender: Any) {
        handleButton(buttonID:3);

    }
    
    @IBAction func MMButtonUp(_ sender: Any) {
        handleButton(buttonID:4);
    }
    @IBAction func MRButtonUp(_ sender: Any) {
        handleButton(buttonID:5);

    }
    

    @IBAction func EndGameButton(_ sender: Any) {
        Player1Outlet.text = "";
        Player2Outlet.text = "";
        versusOutlet.text =  "";
        if(model.mode == "Internet"){
            model.nController?.endGame();
            connectButtonOutlet.isEnabled = true;
            networkInformationOutlet.text = "What name do you want to go by?"
            model.nController? = networkController(infoLabel: networkInformationOutlet);
        }
        model.resetGame();
        botLeftGridOutlet.setTitleColor(UIColor.black, for: .normal)
        botMidGridOutlet.setTitleColor(UIColor.black, for: .normal)
        botRightGridOutlet.setTitleColor(UIColor.black, for: .normal)
        
        //botRightGridOutlet.setTitle(model.grid![2][0].sym, for: .normal)
        
        
        midLeftGridOutlet.setTitleColor(UIColor.black, for: .normal)
        midMidGridOutlet.setTitleColor(UIColor.black, for: .normal)
        midRightGridOutlet.setTitleColor(UIColor.black, for: .normal)
        
        //midLeftGridOutlet.setTitle(model.grid![0][1].sym, for: .normal)
        //midMidGridOutlet.setTitle(model.grid![1][1].sym, for: .normal)
        //midRightGridOutlet.setTitle(model.grid![2][1].sym, for: .normal)
        
        topLeftGridOutlet.setTitleColor(UIColor.black, for: .normal)
        topMidGridOutlet.setTitleColor(UIColor.black, for: .normal)
        topRightGridOutlet.setTitleColor(UIColor.black, for: .normal)
        model.mode = "Local";
        networkInformationOutlet.text = "";
        endGameOutlet.isEnabled = false;

        
        
    }
    @IBAction func BLButtonUp(_ sender: Any) {
        handleButton(buttonID:0);
    }
    
    @IBAction func BMButtonUp(_ sender: Any) {
        handleButton(buttonID:1);

    }
    
    @IBAction func BRButtonUp(_ sender: Any) {
        handleButton(buttonID:2);

    }
    
    @IBOutlet weak var endGameOutlet: UIButton!
    @IBOutlet weak var versusOutlet: UILabel!
    @IBAction func NetworkTestButton(_ sender: Any) {
        model.resetGame();

      connectButtonOutlet.isEnabled = false;
        model.mode = "Internet"
        endGameOutlet.isEnabled = true;
        model.nController?.startNetworking(username: textOutletForUserName.text!)
        
    
    }
    
    @IBOutlet weak var textOutletForUserName: UITextField!
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    public func convertToArrayLocationAndCheck(buttionID:Int)
    {
        if(buttionID == 0)
        {
            model.gLogic?.checkIfWin(localX: 0, localY: 0, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 1)
        {
            model.gLogic?.checkIfWin(localX: 1, localY: 0, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 2)
        {
            model.gLogic?.checkIfWin(localX: 2, localY: 0, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        
        
        if(buttionID == 3)
        {
            model.gLogic?.checkIfWin(localX: 0, localY: 1, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 4)
        {
            model.gLogic?.checkIfWin(localX: 1, localY: 1, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 5)
        {
            model.gLogic?.checkIfWin(localX: 2, localY: 1, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        
        if(buttionID == 6)
        {
            model.gLogic?.checkIfWin(localX: 0, localY: 2, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 7)
        {
            model.gLogic?.checkIfWin(localX: 1, localY: 2, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        if(buttionID == 8)
        {
            model.gLogic?.checkIfWin(localX: 2, localY: 2, Player:model.currPlayerLocal, winText: networkInformationOutlet)
        }
        
        
    }

}

