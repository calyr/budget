//
//  CuentasViewController.swift
//  Budget
//
//  Created by calyr on 8/16/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData

class CuentasViewController: UIViewController {

    var contexto : NSManagedObjectContext? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        let cuentaEntity = NSEntityDescription.entityForName("Cuenta", inManagedObjectContext: self.contexto!)
        
        let peticion = cuentaEntity?.managedObjectModel.fetchRequestTemplateForName("getCuentas")
        
        do{
            let cuentasEntity = try self.contexto?.executeFetchRequest(peticion!)
            
            for cuenta in cuentasEntity!{
                let nombre  = cuenta.valueForKey("mombre") as! String
                
            }
            
        }catch{
        }
        
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
