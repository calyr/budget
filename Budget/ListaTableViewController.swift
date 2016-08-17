//
//  ListaTableViewController.swift
//  Budget
//
//  Created by Roberto Carlos Callisaya Mamani on 8/17/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData



class ListaTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var menuData: [String] = []
    var menuDataTotal: [String] = []

    @IBOutlet weak var tableViewCuentas: UITableView!
    var contexto : NSManagedObjectContext? = nil

    func cargarDatos(){
        menuData = []
        menuDataTotal = []
        let cuentaEntity = NSEntityDescription.entityForName("Cuenta", inManagedObjectContext: self.contexto!)
        
        let peticion = cuentaEntity?.managedObjectModel.fetchRequestTemplateForName("getCuentas")
        
        do{
            let cuentasEntity = try self.contexto?.executeFetchRequest(peticion!)
            print("La cantidad es \(cuentasEntity?.count) ")
            if cuentasEntity?.count == 0 {
                menuData = []
                menuDataTotal = []
            }
            for cuenta in cuentasEntity!{
                let nombre  = cuenta.valueForKey("nombre") as! String
                let total = cuenta.valueForKey("total") as! Double
                
                
                
                let subcuentasList = cuenta.valueForKey("tiene") as! Set<NSObject>
                
               // print(cuenta)
                print(nombre)
                print("Imprimiendo los valores de la cuenta [ \(subcuentasList.count) ]")
                
                for subcuenta in subcuentasList {
                    
                    print(subcuenta.valueForKey("nombre"))
                    print(subcuenta.valueForKey("saldo"))
                    //var saldoCuenta = subcuenta.valueForKey("total")
                    
                }
                
                menuData.append(nombre)
                menuDataTotal.append(String(total) )
                print("**********************")

                
            }
            
        }catch{
        }

    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        cargarDatos()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func viewWillAppear(animated: Bool) {
        cargarDatos()
        self.tableViewCuentas.reloadData()
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuData.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)
        //let cell = tableView.dequeueReusableCellWithIdentifier("Celdacuenta", forIndexPath: indexPath) as! CuentaTableViewCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! CuentaTableViewCell
        print( indexPath.row )
        
        cell.lbTitle.text? = menuData[indexPath.row]
        cell.lbTotal.text? = menuDataTotal[indexPath.row]
        
        //cell.imgMenuTitle.image = UIImage(named: menuDataIcon[indexPath.row])
        
        
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
