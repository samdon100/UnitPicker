//
//  ViewController.swift
//  PickerUnit
//
//  Created by GOQii-Irshad on 13/01/19.
//  Copyright © 2019 GOQii-Irshad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
        
    
    
    @IBOutlet weak var pickerData : PickerUnitView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPressedValChange(_ sender: Any) {
        print(pickerData.getSelectedValueForComp(0))
        print(pickerData.getSelectedValueForComp(1))

    }
    @IBAction func btnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Unit Picker", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Height in ft", style: .default , handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.HeightFt)
            self.pickerData.reloadAllComponents()
            self.pickerData.setDefaultValue(0, value: 5, myType: .HeightFt)
            self.pickerData.setDefaultValue(1, value: 10, myType: .HeightFt)
        }))
        alert.addAction(UIAlertAction(title: "Height in cm", style: .default , handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.HeightCm)
            self.pickerData.reloadAllComponents()
        }))
        
        alert.addAction(UIAlertAction(title: "Weight in kg", style: .default , handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.WeightKg)
            self.pickerData.reloadAllComponents()
        }))
        alert.addAction(UIAlertAction(title: "Weight in lb", style: .default , handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.WeightLb)
            self.pickerData.reloadAllComponents()
        }))
        
        alert.addAction(UIAlertAction(title: "Step", style: .default , handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.Step)
            self.pickerData.reloadAllComponents()
            self.pickerData.setDefaultValue(0, value: 53000, myType: .Step)
        }))
        
        alert.addAction(UIAlertAction(title: "Water", style: .default, handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.Water)
            self.pickerData.reloadAllComponents()
        }))
        alert.addAction(UIAlertAction(title: "Sleep", style: .default, handler:{ (UIAlertAction)in
            self.pickerData.setPickerType(PickerType.Sleep)
            self.pickerData.reloadAllComponents()
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}

