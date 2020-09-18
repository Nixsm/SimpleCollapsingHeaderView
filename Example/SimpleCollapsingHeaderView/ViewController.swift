//
//  ViewController.swift
//  SimpleCollapsingHeaderView
//
//  Created by nixsm on 01/13/2018.
//  Copyright (c) 2018 nixsm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var viewTopCons: NSLayoutConstraint!
	@IBOutlet weak var viewHeightCons: NSLayoutConstraint!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: SimpleCollapsingHeaderView!
    @IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
		tableView.backgroundColor = nil
        headerView?.delegate = self
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
        headerView?.collapseHeaderView(using: tableView)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate {
	
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.collapseHeaderView(using: scrollView)
    }
	
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController: SimpleCollapsingHeaderViewDelegate {
	func headerDidAnimate(to currentValueWithMinMax: (CGFloat, CGFloat) -> CGFloat) {
        titleLabel.alpha = currentValueWithMinMax(0, 1)
		self.viewTopCons.constant = currentValueWithMinMax(20, 44)
		self.viewHeightCons.constant = currentValueWithMinMax(40, 73)
		self.imageViewHeightConstraint.constant = currentValueWithMinMax(64, 170)
		imageViewLeadingConstraint.constant = currentValueWithMinMax(0, -50)
		imageViewTrailingConstraint.constant = currentValueWithMinMax(0, -50)
    }
	
}
