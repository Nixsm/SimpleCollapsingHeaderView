//
//  SimpleCollapsingHeaderViewDelegate.swift
//  SimpleCollapsingHeaderView
//
//  Created by Nicholas Meschke on 01/13/2018.
//  Copyright (c) 2018 Nicholas Meschke. All rights reserved.
//

public protocol SimpleCollapsingHeaderViewDelegate: class {
    func onHeaderDidAnimate(with percentage: CGFloat) 
}
