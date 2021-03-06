//
//  LoadableView.swift
//  LoadableView
//
//  Created by Denys Telezhkin on 05.03.16.
//  Copyright © 2016 MLSDev Inc(https://mlsdev.com).
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

/// Protocol to define family of loadable views
public protocol NibLoadableProtocol : NSObjectProtocol {
    
    /// View that serves as a container for loadable view. Loadable views are added to container view in `setupNib(_:)` method.
    var nibContainerView: UIView { get }
    
    /// Method that loads view from single view xib with `nibName`.
    ///
    /// - returns: loaded from xib view
    func loadNib() -> UIView
    
    /// Method that is used to load and configure loadableView. It is then added to `nibContainerView` as a subview. This view receives constraints of same width and height as container view.
    func setupNib()
    
    /// Name of .xib file to load view from.
    var nibName : String { get }
}

extension UIView {
    /// View usually serves itself as a default container for loadable views
    public var nibContainerView : UIView { return self }
    
    /// Default nibName for all UIViews, equal to name of the class.
    public var nibName : String { return String(self.dynamicType) }
}

extension NibLoadableProtocol {
    /// Method that loads view from single view xib with `nibName`.
    ///
    /// - returns: loaded from xib view
    public func loadNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        return view
    }
    
    internal func setupView(view: UIView, inContainer container: UIView) {
        container.backgroundColor = .clearColor()
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:[], metrics:nil, views: bindings))
        container.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:[], metrics:nil, views: bindings))
    }
}

/// UIView subclass, that can be loaded into different xib or storyboard by simply referencing it's class.
public class LoadableView: UIView, NibLoadableProtocol {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    public func setupNib() {
        setupView(loadNib(), inContainer: nibContainerView)
    }
}

/// UITableViewCell subclass, which subview can be used as a container to loadable view. By default, xib with the same name is loaded and added as a subview to cell's contentView.
public class LoadableTableViewCell: UITableViewCell, NibLoadableProtocol {
    public override var nibContainerView: UIView {
        return contentView
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    public func setupNib() {
        setupView(loadNib(), inContainer: nibContainerView)
    }
}

/// UICollectionReusableView subclass, which subview can be used as a container to loadable view. By default, xib with the same name is loaded and added as a subview.
public class LoadableCollectionReusableView: UICollectionReusableView, NibLoadableProtocol {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    public func setupNib() {
        setupView(loadNib(), inContainer: nibContainerView)
    }
}

/// UICollectionViewCell subclass, which subview can be used as a container to loadable view. By default, xib with the same name is loaded and added as a subview to cell's contentView.
public class LoadableCollectionViewCell: UICollectionViewCell, NibLoadableProtocol {
    public override var nibContainerView: UIView {
        return contentView
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    public func setupNib() {
        setupView(loadNib(), inContainer: nibContainerView)
    }
}

/// UITextField subclass, which subview can be used as a container to loadable view. By default, xib with the same name is loaded and added as a subview.
public class LoadableTextField: UITextField, NibLoadableProtocol {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    public func setupNib() {
        setupView(loadNib(), inContainer: nibContainerView)
    }
}