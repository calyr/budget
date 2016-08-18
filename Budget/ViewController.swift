//
//  ViewController.swift
//  Budget
//
//  Created by calyr on 8/16/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var lbGastos: UILabel!
    @IBOutlet weak var lbCuentas: UILabel!
    var contexto : NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        cargarDatos()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func cargarDatos(){
        lbGastos.text = "Bs.  \(String(getTotal("Gasto", metodo: "getGastos")) )"
        lbCuentas.text = "Bs.  \( String(getTotal("Cuenta", metodo: "getCuentas")) )"

    }
    
    override func viewWillAppear(animated: Bool) {
        cargarDatos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func getTotal(entidad :String,metodo:String) -> Double{
        var totalEntidad : Double  = 0.0
        

        let cuentaEntity = NSEntityDescription.entityForName(entidad, inManagedObjectContext: self.contexto!)
        let peticion = cuentaEntity?.managedObjectModel.fetchRequestTemplateForName(metodo)
        do{
            let cuentasEntity = try self.contexto?.executeFetchRequest(peticion!)
            if cuentasEntity?.count == 0 {
                //menuData = []
                //menuDataTotal = []
            }
            for cuenta in cuentasEntity!{
                let total = cuenta.valueForKey("total") as! Double
                totalEntidad = totalEntidad + total
            }
            }catch{    }
        
        return totalEntidad
    }


}

