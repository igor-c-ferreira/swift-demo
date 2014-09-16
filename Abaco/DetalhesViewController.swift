//
//  DetalhesViewController.swift
//  Abaco
//
//  Created by Igor Ferreira on 8/16/14.
//  Copyright (c) 2014 Igor Ferreira. All rights reserved.
//

import UIKit

protocol DetalhesViewControllerDelegate
{
    func didSaveData(sender:DetalhesViewController, dict:NSDictionary)
}

class DetalhesViewController: UIViewController, UITextFieldDelegate
{
    var dict:NSMutableDictionary?
    
    var delegate:DetalhesViewControllerDelegate?
    
    @IBOutlet weak var nomeTxt: UITextField?
    @IBOutlet weak var telefoneTxt: UITextField?
    @IBOutlet weak var emailTxt: UITextField?
    
    @IBAction func SaveData(sender: AnyObject)
    {
        if dict == nil {
            dict = NSMutableDictionary()
        }
        
        dict!["Nome"] = nomeTxt?.text
        dict!["Telefone"] = telefoneTxt?.text
        dict!["Email"] = emailTxt?.text
        
        self.delegate?.didSaveData(self, dict:dict!)
    }
    @IBAction func tapGesture(sender: AnyObject)
    {
        nomeTxt?.resignFirstResponder()
        telefoneTxt?.resignFirstResponder()
        emailTxt?.resignFirstResponder()
    }
    
    override func viewDidLoad()
    {
        if let info = dict
        {
            nomeTxt!.text = info["Nome"] as NSString
            telefoneTxt!.text = info["Telefone"] as NSString
            emailTxt!.text = info["Email"] as NSString
        }
        self.title = "Detalhes"
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
}
