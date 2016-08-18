//
//  CuentasViewController.swift
//  Budget
//
//  Created by calyr on 8/16/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CuentasViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    @IBOutlet weak var txtMoneda: UITextField!
    @IBOutlet weak var txtSaldo: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var swIncluir: UISwitch!
    var contexto : NSManagedObjectContext? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crearSubcuenta() -> Set<NSObject>{
    
        var entidades = Set<NSObject>()
        
        let nuevaSubcuentaEntidad = NSEntityDescription.insertNewObjectForEntityForName("Subcuenta", inManagedObjectContext: self.contexto!)
        
        let someString = txtSaldo.text
        if let number = Int(someString!) {
            let myNumber = NSNumber(integer:number)
            nuevaSubcuentaEntidad.setValue(myNumber, forKey: "saldo")

            print(myNumber)
        } else {
            print("'\(someString)' did not convert to an Int")
        }
        
        let dateString = txtFecha.text // change to your date format
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.dateFromString(dateString!)
        //print(date)
        
        nuevaSubcuentaEntidad.setValue(txtNombre.text, forKey: "nombre")
        nuevaSubcuentaEntidad.setValue(txtMoneda.text, forKey: "moneda")
        nuevaSubcuentaEntidad.setValue(date, forKey: "fecha")
        nuevaSubcuentaEntidad.setValue(swIncluir.on, forKey: "incluirmenu")
        entidades.insert(nuevaSubcuentaEntidad)
        
        return entidades
        
    }

    
    func getSaldo(value:String) -> NSNumber{
        
        let someString = value
        if let number = Int(someString) {
            let myNumber = NSNumber(integer:number)
            
            return myNumber
        } else {
            
            return NSNumber()
        }
       
    }
   

    
    
    @IBAction func guardarCuenta(sender: UIBarButtonItem) {
        
        //Cargado del tipo de cuenta
        
        if (txtTipo.text == "" ){
            let alert = UIAlertController(title: "Crear Cuenta", message: "El campo Tipo no puede ser vacio", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            
            //Verificar si existe la cuenta
            
            let cuentaEntitad = NSEntityDescription.entityForName("Cuenta", inManagedObjectContext: self.contexto!)
            
            let peticionCuenta = cuentaEntitad?.managedObjectModel.fetchRequestFromTemplateWithName("getCuenta", substitutionVariables: ["nombre": txtTipo.text!])
            
            do{
                let cuentaEntidad2 = try self.contexto?.executeFetchRequest(peticionCuenta!)
                
                if( cuentaEntidad2?.count > 0){
                
                 
                    let cuentaActual = cuentaEntidad2![0] as! NSManagedObject
                    
                    let nuevaSubcuentaEntidad = NSEntityDescription.insertNewObjectForEntityForName("Subcuenta", inManagedObjectContext: self.contexto!)
                    
                    
                    nuevaSubcuentaEntidad.setValue(getSaldo(txtSaldo.text!), forKey: "saldo")

                    
                    let dateString = txtFecha.text // change to your date format
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let date = dateFormatter.dateFromString(dateString!)
                    
                    nuevaSubcuentaEntidad.setValue(txtNombre.text, forKey: "nombre")
                    nuevaSubcuentaEntidad.setValue(txtMoneda.text, forKey: "moneda")
                    nuevaSubcuentaEntidad.setValue(date, forKey: "fecha")
                    nuevaSubcuentaEntidad.setValue(swIncluir.on, forKey: "incluirmenu")
                    
                    let saldoTotalCuenta = cuentaActual.valueForKey("total") as! Double
                    let saldoTotalSubcuenta = Double(txtSaldo.text!)
                    
                    
                    let tot = saldoTotalSubcuenta! + saldoTotalCuenta
                    
                    cuentaActual.setValue(tot, forKey: "total")
                    
                    nuevaSubcuentaEntidad.setValue(cuentaActual, forKey: "pertenece")
                    
                    do{
                        try self.contexto?.save()
                        self.navigationController?.popViewControllerAnimated(true)
                    }catch{
                    
                    }
                    
                    
                }else{
                
                    //creamos la cuenta
                    let nuevaCuentaEntitidad = NSEntityDescription.insertNewObjectForEntityForName("Cuenta", inManagedObjectContext: self.contexto!)
                    nuevaCuentaEntitidad.setValue(txtTipo.text, forKey: "nombre")
                    nuevaCuentaEntitidad.setValue(getSaldo(txtSaldo.text!), forKey: "total")
                    nuevaCuentaEntitidad.setValue(crearSubcuenta(), forKey: "tiene")
                
                    
                    do{
                        try self.contexto?.save()
                        self.navigationController?.popViewControllerAnimated(true)
                    }catch{
                    }
                
                }
                
            }catch{
            
            }
            
            
        }
        
           
    
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
