//
//  ViewController.swift
//  ZCCalculator
//
//  Created by 赵隆杰 on 2017/12/25.
//  Copyright © 2017年 赵隆杰. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var disPlay: AlignmentLabel!
    
    var isClearDisplay = false //是否清除显示
    var isDivisorZore = false //除以0产生的错误，必须点清除键才能清除掉
    
    var operandStack = Array<Double>() //每次输入的数值保存到栈中
    var tempStack = Array<Double>() //待计算容器
    
    var operationString = String() //操作符
    
    var disPlayValue : Double {
        get {
            if disPlay.text! != "0." && disPlay.text! != "错误" {
                return NumberFormatter().number(from: disPlay.text!)!.doubleValue
            }
            return 0
        }
        set {
            disPlay.text = "\(newValue)"
        }
    }
    
    //自检操作符
    @IBAction func selfOperation(_ sender: UIButton) {
        //按钮点击系统声音效果
        AudioServicesPlaySystemSound(1104)
        
        switch sender.currentTitle! {
        case "AC":
            if !operandStack.isEmpty {
                operandStack.removeAll()
            }
            if !tempStack.isEmpty {
                tempStack.removeAll()
            }
            isDivisorZore = false
            disPlay.text = "0" //这里不写disPlayValue的原因是保证显示的只有一位整数0
        case "+/-":
            if disPlayValue == 0 {
                disPlay.text! = "-0"
            } else {
                disPlayValue = -disPlayValue
            }
            //显示结果去除多余的0
            disPlay.text = removeExtraZore(disPlay.text!)
            //保存每次输入后的数值
            operandStack.append(disPlayValue)
        case "%":
            disPlayValue /= 100
            //显示结果去除多余的0
            disPlay.text = removeExtraZore(disPlay.text!)
            //保存每次输入后的数值
            operandStack.append(disPlayValue)
            //将结果保存到tempStack中，为下次计算使用
            tempStack.append(disPlayValue)
        default:
            break
        }
        
    }
    
    //输入数字 0 1 2 3 4 5 6 7 8 9 .
    @IBAction func appendDigit(_ sender: UIButton) {
        //按钮点击系统声音效果
        AudioServicesPlaySystemSound(1104)
        
        let digit = sender.currentTitle!
        
        if isClearDisplay {
            if !operandStack.isEmpty {
                operandStack.removeAll()
            }
            disPlay.text = "0"
            isClearDisplay = false
        }
        
        //小数点最多只能输入一个
        if (disPlay.text! == "-0" && digit == "0") || (disPlay.text!.contains(".") && digit == ".") {return}
        
        if disPlay.text! == "-0" && digit != "." {
            disPlay.text = "-\(digit)"
        } else if disPlayValue == 0 && !disPlay.text!.contains(".") && digit != "." {
            disPlay.text = digit
        } else {
            //最多输入9位数
            if digitIsMax(disPlay.text!) {return}
            
            disPlay.text = disPlay.text! + digit
        }
        
        //保存每次输入后的数值
        operandStack.append(disPlayValue)
        
    }
    
    @IBAction func operation(_ sender: UIButton) {
        //按钮点击系统声音效果
        AudioServicesPlaySystemSound(1104)
        
        //先取出保存数组中的最后一个值
        if !operandStack.isEmpty {
            if tempStack.isEmpty {
                tempStack.append(operandStack.last!)
            }
            isClearDisplay = true
            operationString = sender.currentTitle!
        }
        
    }
    
    //等于
    @IBAction func equal() {
        //按钮点击系统声音效果
        AudioServicesPlaySystemSound(1104)
        
        if operandStack.isEmpty {return}
        
        if isDivisorZore {
            disPlay.text = "错误"
            return;
        }
        if !tempStack.isEmpty {
            let double1 = tempStack.last!
            let double2 = operandStack.last!
            
            switch operationString {
            case "+":
                disPlayValue = double1 + double2
            case "−":
                disPlayValue = double1 - double2
            case "×":
                disPlayValue = double1 * double2
            case "÷":
                if double2 == 0 {
                    disPlay.text = "错误"
                    isDivisorZore = true
                    return;
                } else {
                    disPlayValue = double1 / double2
                }                
            default:
                break
            }

            //将结果保存到tempStack中，为下次计算使用
            tempStack.append(disPlayValue)
            //显示结果去除多余的0
            disPlay.text = removeExtraZore(disPlay.text!)
        } else {
            //没有任何计算，则标记可清除，在下次输入数字时清除前面保存的数字
            isClearDisplay = true
        }
        
    }
    
    //去掉小数点后面多余的0
    func removeExtraZore(_ input:String) -> String{
        
        var output = input
        var i = 1
        
        if output.contains(".") {
            while i < output.indices.count {
                if output.hasSuffix("0"){
                    output.removeLast()
                    i += 1
                }else{
                    break
                }
            }
            if output.hasSuffix("."){
                output.removeLast()
            }
            return output
        }
        else{
            return input
        }
    }
    
    //判断位数
    func digitIsMax(_ text: String) -> Bool {
        let count = text.indices.count
        switch (text.contains("."),text.contains("-")) {
        case (true,true):
            return count == 11 ? true : false
        case (true,false),(false,true):
            return count == 10 ? true : false
        default:
            return count == 9 ? true : false
        }
    }
    
}

