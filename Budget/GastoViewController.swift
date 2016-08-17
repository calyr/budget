//
//  GastoViewController.swift
//  Budget
//
//  Created by Roberto Carlos Callisaya Mamani on 8/17/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData

class GastoViewController: UIViewController {

    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtSubcategoria: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var txtPagar: UITextField!
    @IBOutlet weak var txtDescripcion: UITextView!
    
    var contexto : NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

        // Do any additional setup after loading the view.
    }
    
    func getCantidad(value:String) -> NSNumber{
        
        let someString = value
        if let number = Int(someString) {
            let myNumber = NSNumber(integer:number)
            
            return myNumber
        } else {
            
            return NSNumber()
        }
        
    }

    @IBAction func guardarGasto(sender: UIBarButtonItem) {
        
        if (txtCategoria.text == "" || txtSubcategoria.text == "" ){
            let alert = UIAlertController(title: "Gastos", message: "El campo Categoria/Subcategoria no pueden estar vacios", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            
            //Verificar si existe la cuenta
            
            let cuentaEntitad = NSEntityDescription.entityForName("Gasto", inManagedObjectContext: self.contexto!)
            
            let peticionCuenta = cuentaEntitad?.managedObjectModel.fetchRequestFromTemplateWithName("getGasto", substitutionVariables: ["nombre": txtCategoria.text!])
            
            do{
                let cuentaEntidad2 = try self.contexto?.executeFetchRequest(peticionCuenta!)
                
                if( cuentaEntidad2?.count > 0){
                    
                    
                    let cuentaActual = cuentaEntidad2![0] as! NSManagedObject
                    
                    let nuevaSubgastoEntidad = NSEntityDescription.insertNewObjectForEntityForName("Subgasto", inManagedObjectContext: self.contexto!)
                    
                    
                    nuevaSubgastoEntidad.setValue(getCantidad(txtCantidad.text!), forKey: "cantidad")
                    
                    
                    let dateString = txtFecha.text // change to your date format
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let date = dateFormatter.dateFromString(dateString!)
                    
                    nuevaSubgastoEntidad.setValue(txtSubcategoria.text, forKey: "nombre")
                    nuevaSubgastoEntidad.setValue(txtCantidad.text, forKey: "cantidad")
                    nuevaSubgastoEntidad.setValue(date, forKey: "fecha")
                    nuevaSubgastoEntidad.setValue(txtDescripcion.text, forKey: "descripcion")
                    
                    let saldoTotalCuenta = cuentaActual.valueForKey("total") as! Double
                    let saldoTotalSubcuenta = Double(txtCantidad.text!)
                    
                    
                    let tot = saldoTotalSubcuenta! + saldoTotalCuenta
                    
                    cuentaActual.setValue(tot, forKey: "total")
                    
                    nuevaSubgastoEntidad.setValue(cuentaActual, forKey: "pertenece")
                    
                    do{
                        try self.contexto?.save()
                    }catch{
                        
                    }
                    
                    
                }else{
                    
                    //Creamos el Gasto
                    let nuevaGastoEntitidad = NSEntityDescription.insertNewObjectForEntityForName("Gasto", inManagedObjectContext: self.contexto!)
                    nuevaGastoEntitidad.setValue(txtSubcategoria.text , forKey: "nombre")
                    nuevaGastoEntitidad.setValue(getCantidad(txtCantidad.text!), forKey: "total")
                    nuevaGastoEntitidad.setValue(crearSubgasto(), forKey: "tiene")
                    
                    
                    do{
                        try self.contexto?.save()
                    }catch{
                    }
                    
                }
                
            }catch{
                
            }
            
            
        }
        
        
    }
    
    func crearSubgasto() -> Set<NSObject>{
        
        var entidades = Set<NSObject>()
        
        let nuevaSubgastoEntidad = NSEntityDescription.insertNewObjectForEntityForName("Subgasto", inManagedObjectContext: self.contexto!)
        
        let someString = txtCantidad.text
        if let number = Int(someString!) {
            let myNumber = NSNumber(integer:number)
            nuevaSubgastoEntidad.setValue(myNumber, forKey: "cantidad")
            
            print(myNumber)
        } else {
            print("'\(someString)' did not convert to an Int")
        }
        
        let dateString = txtFecha.text // change to your date format
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.dateFromString(dateString!)
        //print(date)
        
        nuevaSubgastoEntidad.setValue(txtSubcategoria.text, forKey: "nombre")
        nuevaSubgastoEntidad.setValue(date, forKey: "fecha")
        nuevaSubgastoEntidad.setValue(txtDescripcion.text, forKey: "descripcion")
        entidades.insert(nuevaSubgastoEntidad)
        
        return entidades
        
    }
    override func didReceiveMemoryWarning() {
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
