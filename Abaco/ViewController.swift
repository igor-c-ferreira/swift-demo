//
//  ViewController.swift
//  Abaco
//
//  Created by Igor Ferreira on 8/16/14.
//  Copyright (c) 2014 Igor Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetalhesViewControllerDelegate
{
    var dadosPath:String?
    var indexCell:NSIndexPath?
    var arrayPessoas:NSMutableArray = [
        ["Nome":"Juvenal", "Telefone":"8888888", "Email":"ju33@hot.com"],
        ["Nome":"Astrubal", "Telefone":"9999999", "Email":"astro@hot.com"]
    ]
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Contatos"
        // Do any additional setup after loading the view, typically from a nib.
        self.dadosPath = NSBundle.mainBundle().pathForResource("Dados", ofType: "plist")
        self.arrayPessoas = NSMutableArray(contentsOfFile: self.dadosPath!)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPessoas.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            self.arrayPessoas.removeObjectAtIndex(indexPath.row)
            self.arrayPessoas.writeToFile(self.dadosPath!, atomically: true)
            self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "batata"
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier)
        }
        
        var mDict:NSMutableDictionary = NSMutableDictionary(dictionary: self.arrayPessoas[indexPath.row] as NSDictionary)
        
        cell?.textLabel?.text = mDict["Nome"] as? String
        cell?.detailTextLabel?.text = mDict["Telefone"] as? String
        
        return cell!
    }
    func didSaveData(sender: DetalhesViewController, dict:NSDictionary)
    {
        self.navigationController?.popViewControllerAnimated(false)
        self.tableView?.beginUpdates()
        if self.indexCell == nil
        {
            arrayPessoas.addObject(dict)
            self.tableView?.insertRowsAtIndexPaths([NSIndexPath(forRow: self.arrayPessoas.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        } else
        {
            arrayPessoas[indexCell!.row] = dict
            self.tableView?.reloadRowsAtIndexPaths([self.indexCell!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        self.tableView?.endUpdates()
        
        self.arrayPessoas.writeToFile(self.dadosPath!, atomically: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "voa"
        {
            let viewDestination = segue.destinationViewController as DetalhesViewController
            viewDestination.delegate = self
            self.indexCell = self.tableView?.indexPathForCell(sender as UITableViewCell)
            viewDestination.dict = NSMutableDictionary(dictionary:self.arrayPessoas[indexCell!.row] as NSDictionary)
            self.tableView?.deselectRowAtIndexPath(indexCell!, animated: true)
        }
        else if segue.identifier == "qualquer"
        {
            let viewDestination = segue.destinationViewController as DetalhesViewController
            viewDestination.delegate = self
            self.indexCell = nil
        }
    }
}

