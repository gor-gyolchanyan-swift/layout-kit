//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct PragmaticRegion {

    // MARK: PragmaticRegion - Variant

    @inlinable
    internal init(variant: Variant) {
        self.variant = variant
    }

    @usableFromInline
    internal let variant: Variant
}

extension PragmaticRegion {

    // MARK: PragmaticRegion - Variant

    @frozen
    @usableFromInline
    internal enum Variant {

        // MARK: PragmaticRegion.Variant

        case view(_ view: NativeView)

        case layoutGuide(_ layoutGuide: NativeLayoutGuide)
    }
}

extension PragmaticRegion {

    // MARK: PragmaticRegion

    @inlinable
    public init(_ view: NativeView) {
        self.init(variant: .view(view))
    }

    @inlinable
    public init(_ layoutGuide: NativeLayoutGuide) {
        self.init(variant: .layoutGuide(layoutGuide))
    }
}

extension PragmaticRegion {

    // MARK: PragmaticRegion - NativeOwningView

    @inlinable
    internal var owningView: NativeView? {

        get {
            switch variant {
                case .view(let view):
                    return view.superview
                case .layoutGuide(let layoutGuide):
                    return layoutGuide.owningView
            }
        }

        set(owningView) {
            switch variant {
                case .view(let view):
                    if let owningView = owningView {
                        owningView.addSubview(view)
                    } else {
                        view.removeFromSuperview()
                    }
                case .layoutGuide(let layoutGuide):
                    if let owningView = owningView {
                        owningView.addLayoutGuide(layoutGuide)
                    } else {
                        self.owningView?.removeLayoutGuide(layoutGuide)
                    }
            }
        }
    }

    @inlinable
    internal var frameInOwningView: NativeRectangle {
        switch variant {
            case .view(let view):
                return view.frame
            case .layoutGuide(let layoutGuide):
                #if os(macOS)
                    return layoutGuide.frame
                #elseif os(iOS) || os(tvOS)
                    return layoutGuide.layoutFrame
                #endif
        }
    }
}
