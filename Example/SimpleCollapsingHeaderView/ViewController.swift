//
//  ViewController.swift
//  SimpleCollapsingHeaderView
//
//  Created by nixsm on 01/13/2018.
//  Copyright (c) 2018 nixsm. All rights reserved.
//

import UIKit
import SimpleCollapsingHeaderView

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: SimpleCollapsingHeaderView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        headerView.delegate = self
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
	func onHeaderDidAnimate(with currentValue: (CGFloat, CGFloat) -> CGFloat) {
		titleLabel.alpha = currentValue(0, 1)
    }
}
