//
//  HTMLCollectionViewCell.swift
//  TravelBuds-Laws
//
//  Created by Krys Welch on 11/28/22.
//

import UIKit
import WebKit

class HTMLCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var htmlContent: WKWebView!
}
