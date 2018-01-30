//
//  ActivityLoaderHelper.swift
//  DHCC_iOS
//
//  Created by Ayman Ibrahim Abdel Alim on 12/14/16.
//  Copyright © 2016 LinkDev. All rights reserved.
//

import UIKit
import SpinKit

var spinner = RTSpinKitView(style: .stylePulse, color: UIColor.white)
let style = RTSpinKitViewStyle.styleFadingCircleAlt
let x = UIScreen.main.bounds.midX
let y = UIScreen.main.bounds.midY

//MAKR: - Loader -
func showLoaderFor(view:UIView, style:RTSpinKitViewStyle)
{
    spinner = RTSpinKitView(style: style, color: ColorMainGreen)
    view.addSubview(spinner!)
    spinner?.center = CGPoint(x:x, y:y)
}

func showLoaderFor(view:UIView, style:RTSpinKitViewStyle, color:UIColor)
{
    spinner = RTSpinKitView(style: style, color: color)
    view.addSubview(spinner!)
    spinner?.center = CGPoint(x:x, y:y)
}

func showLoaderFor(view:UIView)
{
    let spinner = RTSpinKitView(style: style, color: ColorMainGreen)
    view.addSubview(spinner!)
    
    spinner?.center = CGPoint(x:x, y:y)
}

func showLoaderWithBGFor(view:UIView, bgColor:UIColor?)
{
    spinner = RTSpinKitView(style: style, color: ColorMainGreen)
    let screenBounds = UIScreen.main.bounds
    let bgView = UIView(frame: screenBounds)
    bgView.tag = 999
    bgView.backgroundColor = ((bgColor != nil) ? bgColor! : ColorMainGreen).withAlphaComponent(0.4)
    bgView.addSubview(spinner!)
    spinner?.center = CGPoint(x: x, y: (y - (spinner?.frame.size.height)!));
    view.addSubview(bgView)
}

func showLoaderForCustomView(view:UIView, color:UIColor)
{
    let spinner = RTSpinKitView(style: style, color: color)
    view.addSubview(spinner!)
    let viewFrame = view.bounds
   let halfButtonHeight = view.bounds.size.height / 2;
//    let buttonWidth = view.bounds.size.width / 2;
//    spinner?.center = CGPoint(x: buttonWidth - halfButtonHeight , y: halfButtonHeight)
//    spinner?.frame.origin.x = view.frame.width / 2 - halfButtonHeight
    spinner?.spinnerSize = halfButtonHeight
    spinner?.center = CGPoint(x:viewFrame.midX, y:viewFrame.midY)
    
}

func showLoaderForProfile(view:UIView, color:UIColor)
{
    
    let spinner = RTSpinKitView(style: style, color: color)
    view.addSubview(spinner!)
    spinner?.spinnerSize = 20
    let viewFrame = view.bounds
    spinner?.center = CGPoint(x:viewFrame.midX, y:viewFrame.midY)
    spinner?.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(spinner!)
    spinner?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
}

func showLoaderInsideButton(view:UIView, color:UIColor)
{
    let spinner = RTSpinKitView(style: style, color: color)
    spinner?.spinnerSize = 10.0
    view.addSubview(spinner!)
    let halfButtonHeight = view.bounds.size.height / 2;
    let buttonWidth = view.bounds.size.width;
    spinner?.center = CGPoint(x: buttonWidth - halfButtonHeight, y: halfButtonHeight)
    spinner?.frame.origin.y = view.frame.height/3 - 2
}

func showLoaderInsideCell(view:UIView, color:UIColor)
{
    let spinner = RTSpinKitView(style: style, color: color)
    spinner?.spinnerSize = 15.0
    view.addSubview(spinner!)
    let halfButtonHeight = view.bounds.size.height / 2;
    let buttonWidth = view.bounds.size.width;
    spinner?.center = CGPoint(x: buttonWidth - halfButtonHeight, y: halfButtonHeight)
    spinner?.frame.origin.y = view.frame.height/2 - 7.5
}

//MARK: - hideLoader -
func hideLoaderForBG(view:UIView)
{
    let parentView = spinner?.superview
    if(parentView?.tag == 999)
    {
        parentView?.removeFromSuperview()
    }
    spinner?.removeFromSuperview()
}

func hideLoaderFor(view:UIView)
{
    hideLoaderForBG(view: view)
    for v in view.subviews
    {
        if v is RTSpinKitView
        {
            v.removeFromSuperview()
            return
        }
    }
}

func hideLoaderFor(spinner:RTSpinKitView)
{
    spinner.removeFromSuperview()
}

// Labib : method needed to check if there is a spinner already in the in the view so as to use to check before hidding the spinner

