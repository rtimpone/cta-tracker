//
//  RouteColorFilterViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/25/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol RouteColorFilterViewControllerDelegate: class {
    func didUpdateRouteFilters(_ routesToShow: Set<Route>)
}

class RouteColorFilterViewController: UIViewController {
    
    weak var delegate: RouteColorFilterViewControllerDelegate?
    var selectedRoutes: Set<Route> = []
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var circleView1: RouteColorFilterView!
    @IBOutlet weak var circleView2: RouteColorFilterView!
    @IBOutlet weak var circleView3: RouteColorFilterView!
    @IBOutlet weak var circleView4: RouteColorFilterView!
    @IBOutlet weak var circleView5: RouteColorFilterView!
    @IBOutlet weak var circleView6: RouteColorFilterView!
    @IBOutlet weak var circleView7: RouteColorFilterView!
    @IBOutlet weak var circleView8: RouteColorFilterView!
    @IBOutlet weak var circleView9: RouteColorFilterView!

    lazy var circleViews = [circleView1, circleView2, circleView3, circleView4, circleView5, circleView6, circleView7, circleView8, circleView9]
    
    var buttonsToRoutesDictionary: [UIButton: Route] = [:]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let routes = RouteDataFetcher.fetchAllRoutes()
        let sortedRoutes = routes.sorted(by: { $0.title < $1.title })
        for (index, route) in sortedRoutes.enumerated() {
            guard let view = circleViews[index] else {
                continue
            }
            buttonsToRoutesDictionary[view.button] = route
            view.innerView.backgroundColor = route.color
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if let route = buttonsToRoutesDictionary[sender] {
            update(for: route, sender: sender)
        }
    }
}

extension RouteColorFilterViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        view.backgroundColor = theme.routeFilterTheme.backgroundColor
        separatorView.backgroundColor = theme.cellTheme.separatorColor
        
        for view in circleViews {
            view?.applyTheme(theme)
            view?.styleForUnselectedState()
        }
    }
}

private extension RouteColorFilterViewController {
    
    func update(for route: Route, sender: UIButton) {
        
        guard let view = circleViews.first(where: { $0?.button == sender }) else {
            return
        }
        
        if selectedRoutes.contains(route) {
            selectedRoutes.remove(route)
            view?.styleForUnselectedState()
        }
        else {
            selectedRoutes.insert(route)
            view?.styleForSelectedState()
        }
        
        delegate?.didUpdateRouteFilters(selectedRoutes)
    }
}

class RouteColorFilterView: CircleView {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var button: UIButton!
    
    var selectedColor: UIColor = .white
    var unselectedColor: UIColor = .white
    
    func styleForSelectedState() {
        backgroundColor = selectedColor
    }
    
    func styleForUnselectedState() {
        backgroundColor = unselectedColor
    }
}

extension RouteColorFilterView: Themeable {
    
    func applyTheme(_ theme: Theme) {
        selectedColor = theme.routeFilterTheme.selectedBorderColor
        unselectedColor = theme.routeFilterTheme.unselectedBorderColor
        outerView.backgroundColor = theme.routeFilterTheme.backgroundColor
    }
}
