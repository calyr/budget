//
//  CuentaDetalleTableViewController.swift
//  Budget
//
//  Created by Roberto Carlos Callisaya Mamani on 8/17/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData


class CuentaDetalleTableViewController: UITableViewController {
    var subcuentasList: Set = Set<NSObject>()
    var contexto : NSManagedObjectContext? = nil
    var dataName : [String] = []
    var dataValue : [String] = []
    var nombreCuenta : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        print("El nombre del acuenta es\(nombreCuenta)")
        cargarDatos()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func cargarDatos(){
         dataName  = []
         dataValue = []

        let cuentaEntity = NSEntityDescription.entityForName("Cuenta", inManagedObjectContext: self.contexto!)
        
        let peticion = cuentaEntity?.managedObjectModel.fetchRequestFromTemplateWithName("getCuenta", substitutionVariables: [ "nombre": self.nombreCuenta])
        
        do{
            let cuentasEntity = try self.contexto?.executeFetchRequest(peticion!)
            print("La cantidad es \(cuentasEntity?.count) ")
            if cuentasEntity?.count == 0 {
                
                
            }else{
                
                let cuentaActual = cuentasEntity![0] as! NSManagedObject
               
                self.subcuentasList = cuentaActual.valueForKey("tiene") as! Set<NSObject>

                for subcu in subcuentasList {
                    let nombreSub = subcu.valueForKey("nombre") as! String
                    let valueSub = subcu.valueForKey("saldo") as! Double
                    
                    dataName.append(nombreSub)
                    dataValue.append(String(valueSub))
                    
                }
                
            }
            
            
        }catch{
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subcuentasList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cuentaDetalle", forIndexPath: indexPath) as! CuentadetalleTableViewCell
        
       // print(subcuenta.valueForKey("nombre"))

        cell.lbSubcuenta.text = dataName[indexPath.row]
        cell.lbSaldo.text = dataValue[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
