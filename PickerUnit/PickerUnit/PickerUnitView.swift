//
//  PickerUnitView.swift
//  PickerUnit
//
//  Created by GOQii-Irshad on 13/01/19.
//  Copyright © 2019 GOQii-Irshad. All rights reserved.
//

/*
 2 comp :
 pickerData.numOfComp = 2
 pickerData.setUnitLabel("ft", comp: 0, alignment: .right)
 pickerData.setUnitLabel("cm", comp: 1, alignment: .center)
 
 
 1 Comp:
 pickerData.numOfComp = 1
 pickerData.setUnitLabel("Kg", comp: 0, alignment: .center)
 */

import UIKit

public enum PickerType {
    case HeightFt // ft/in 2 comp
    case HeightCm // CM 1 comp
    case WeightKg // kg/gm 2 comp,
    case WeightLb // lb 1 comp
    case Step // Steps 1 comp
    case Water // L/ml 2 comp
    case Sleep // hr/min 2 comp
}


class PickerUnitView: UIPickerView {

    var valComp0 = ""
    var valComp1 = ""
    var unitTitle0 = "xxx"
    var unitTitle1 = "yyy"
    var typeUnit:PickerType!// = .HeightFt
    var arrComp0:NSMutableArray = []
    var arrComp1:NSMutableArray = []
    
    override init(frame: CGRect) {
        
        print("override init")
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("required init")
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        print("awakeFrom nib")
        super.awakeFromNib()
        self.delegate = self as? UIPickerViewDelegate
        self.dataSource = self as? UIPickerViewDataSource
    }
    func setPickerType(_ myType:PickerType) {
        typeUnit = myType
        self.setUpDataArray()
        
    }
    func setUnitLabel(_ comp:Int, alignment: NSTextAlignment) {
        
        removeUnitLabels()
        DispatchQueue.delay(.milliseconds(10)) {
            let lbl = UILabel()
            if comp == 0 {
                lbl.text = self.unitTitle0
            }else {
                lbl.text = self.unitTitle1
            }
            
            lbl.font = UIFont(name: "Arial", size: 30)
            lbl.backgroundColor = UIColor.gray
            lbl.textColor = UIColor(red: 58.0/255.0, green: 177.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            self.setPickerLabels(labels: [comp : lbl], alignment: alignment)
        }
        
        
    }

    func getSelectedValueForComp(_ compNumber:Int) -> String {
        
        if compNumber == 0 {
            return self.valComp1
        }else {
            return self.valComp0
        }
        
    }
    func componentValFor0() -> String {
        return self.valComp0
    }
    func componentValFor1() -> String {
        return self.valComp1
    }
    func removeUnitLabels() {
        self.valComp1 = ""
        self.valComp0 = ""
        for lbl in self.subviews {
            if lbl.tag == 888 {
                lbl.removeFromSuperview()
            }
        }
    }
    func setUpDataArray() {
        self.arrComp0.removeAllObjects()
        self.arrComp1.removeAllObjects()
        switch typeUnit {
        case .HeightFt:
            arrComp0 = [2,3,4,5,6,7,8]
            arrComp1 = [1,2,3,4,5,6,7,8,9,10,11]
            unitTitle0 = "ft"
            unitTitle1 = "in"
            self.setUnitLabel(0, alignment: .right)
            self.setUnitLabel(1, alignment: .center)
            break;
            
        case .HeightCm:
            for i in 90...241 {
                arrComp0.add(i)
            }
            unitTitle0 = "cm"
            self.setUnitLabel(0, alignment: .center)
            break;
        case .WeightKg:
            unitTitle0 = "kg"
            for i in 30...150 {
                arrComp0.add(i)
            }
            self.setUnitLabel(0, alignment: .center)
            break;
        case .WeightLb:
            unitTitle0 = "lb"
            for i in 66...330 {
                arrComp0.add(i)
            }
            self.setUnitLabel(0, alignment: .center)
            break;
        case .Step:
            unitTitle0 = "steps"
            var x = 1000
            
            repeat {
                arrComp0.add(x)
                x += 500
            } while x <= 25000
            
            self.setUnitLabel(0, alignment: .center)
            break;
        case .Sleep:
            unitTitle0 = "hr"
            unitTitle1 = "min"
            arrComp0 = [4,5,6,7,8,9,10,11,12]
            arrComp1 = [15,30,45]
            self.setUnitLabel(0, alignment: .right)
            self.setUnitLabel(1, alignment: .center)
            break;
        case .Water:
            arrComp0 = [2,3,4,5,6,7,8]
            arrComp1 = [100,200,300,400,500,600,700,800,900]
            unitTitle0 = "L"
            unitTitle1 = "ml"
            self.setUnitLabel(0, alignment: .right)
            self.setUnitLabel(1, alignment: .center)
            break;
        
        case .none:
            break;
            
        case .some(_):
            break;
            
        }
    }
    
    func setDefaultValue(_ forComponent:Int, value:Int, myType:PickerType) {
        var reloadIndex = 0
        if forComponent == 0 {
            for i in 0..<arrComp0.count {
                let val:Int = arrComp0.object(at: i) as! Int
                if val >= value {
                    if val == value {
                        reloadIndex = i
                        break;
                    }else {
                        if i != 0 {
                            reloadIndex = i - 1
                            break;
                        }
                    }
                }
            }
            self.selectRow(reloadIndex, inComponent: forComponent, animated: true)
        }else{
            for i in 0..<arrComp1.count {
                let val:Int = arrComp1.object(at: i) as! Int
                if val >= value {
                    if val == value {
                        reloadIndex = i
                        break;
                    }else {
                        if i != 0 {
                            reloadIndex = i - 1
                            break;
                        }
                    }
                }
            }
            self.selectRow(reloadIndex, inComponent: forComponent, animated: true)
        }
    }
    
}
extension DispatchQueue {
    static func delay(_ delay: DispatchTimeInterval, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
extension PickerUnitView {
    
    func setPickerLabels(labels: [Int:UILabel], alignment: NSTextAlignment) { // [component number:label]
        
        let fontSize:CGFloat = 25
        let labelWidth:CGFloat = UIScreen.main.bounds.size.width / CGFloat(self.numberOfComponents)
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
        
        for i in 0...self.numberOfComponents {
            
            if let label = labels[i] {
                if label.tag != 999 {
                    label.tag = 888
                    if self.subviews.contains(label) {
                        label.removeFromSuperview()
                    }
                    if numberOfComponents == 1 {
                        if self.typeUnit == PickerType.HeightCm{
                            label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) + 50, y: y, width: labelWidth, height: fontSize + 2)
                        }else if self.typeUnit == PickerType.Step{
                            label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) + 75, y: y, width: labelWidth, height: fontSize + 2)
                        }else{
                            label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) + 50, y: y, width: labelWidth, height: fontSize + 2)
                        }
                    } else {
                        
                        if self.typeUnit == PickerType.HeightFt {
                            if i == 0{
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) - 25, y: y, width: labelWidth, height: fontSize + 2)
                            }else {
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) - 5, y: y, width: labelWidth, height: fontSize + 2)
                            }
                        }else if self.typeUnit == PickerType.Water {
                            if i == 0{
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) - 25, y: y, width: labelWidth, height: fontSize + 2)
                            }else{
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) + 15, y: y, width: labelWidth, height: fontSize + 2)
                            }
                        }else if self.typeUnit == PickerType.Sleep {
                            if i == 0{
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) - 15, y: y, width: labelWidth, height: fontSize + 2)
                            }else{
                                label.frame = CGRect(x: (x + labelWidth * CGFloat(i)) + 10, y: y, width: labelWidth, height: fontSize + 2)
                            }
                        }

                        else {
                            label.frame = CGRect(x: x + labelWidth * CGFloat(i), y: y, width: labelWidth, height: fontSize + 2)
                        }
                    }
                    label.font = UIFont(name: "Arial", size: fontSize)//UIFont.boldSystemFont(ofSize: fontSize)
                    label.backgroundColor = .clear
                    label.textAlignment = alignment
                    
                    self.addSubview(label)
                }
            }
        }
    }
}
extension PickerUnitView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
        }
        pickerLabel?.tag = 999
        let paragraphStyle = NSMutableParagraphStyle()
        if pickerView.selectedRow(inComponent: component) == row {
            paragraphStyle.alignment = NSTextAlignment.center
            if component == 0 {
                self.valComp0 = "\(arrComp0[row])"
                let attributedStringA = NSAttributedString(string:self.valComp0, attributes:
                    [NSAttributedStringKey.foregroundColor:UIColor(red: 58.0/255.0, green: 177.0/255.0, blue: 74.0/255.0, alpha: 1.0),NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 30)!,NSAttributedStringKey.paragraphStyle: paragraphStyle])
                pickerLabel?.attributedText = attributedStringA
                
                return pickerLabel!
            }else {
                self.valComp1 = "\(arrComp1[row])"
                let attributedStringA = NSAttributedString(string:self.valComp1, attributes:
                    [NSAttributedStringKey.foregroundColor:UIColor(red: 58.0/255.0, green: 177.0/255.0, blue: 74.0/255.0, alpha: 1.0),NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 30)!,NSAttributedStringKey.paragraphStyle: paragraphStyle])
                pickerLabel?.attributedText = attributedStringA
                
                return pickerLabel!
            }
            
            
        }else{
            paragraphStyle.alignment = NSTextAlignment.center
            var valText = ""
            if component == 0 {
                valText = "\(arrComp0[row])"
            }else{
                valText = "\(arrComp1[row])"
            }
            
            let attributedStringA = NSAttributedString(string:valText, attributes:
                [NSAttributedStringKey.foregroundColor:UIColor.gray,NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 28)!,NSAttributedStringKey.paragraphStyle: paragraphStyle])
            pickerLabel?.attributedText = attributedStringA
            
            
            return pickerLabel!
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 120.0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{

        if typeUnit == PickerType.HeightFt || typeUnit == PickerType.Sleep || typeUnit == PickerType.Water {
            return 2
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return arrComp0.count
        }
        return arrComp1.count
    }
}
