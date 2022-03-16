//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@usableFromInline
internal struct PragmaticLocationX {

    // MARK: PragmaticLocationX

    @inlinable
    internal init(_ key: SymbolicLocationKeyX, in region: PragmaticRegion) {
        self.key = key
        self.region = region
    }

    @usableFromInline
    internal let key: SymbolicLocationKeyX

    @usableFromInline
    internal let region: PragmaticRegion
}

extension PragmaticLocationX {

    // MARK: PragmaticLocationX - Native

    @inlinable
    internal var native: NativeLocationX {
        switch region.variant {
            case .view(let view):
                switch key {
                    case .centerX:
                        return view.centerXAnchor
                    case .leading:
                        return view.leadingAnchor
                    case .trailing:
                        return view.trailingAnchor
                    case .left:
                        return view.leftAnchor
                    case .right:
                        return view.rightAnchor
                }
            case .layoutGuide(let layoutGuide):
                switch key {
                    case .centerX:
                        return layoutGuide.centerXAnchor
                    case .leading:
                        return layoutGuide.leadingAnchor
                    case .trailing:
                        return layoutGuide.trailingAnchor
                    case .left:
                        return layoutGuide.leftAnchor
                    case .right:
                        return layoutGuide.rightAnchor
                }
        }
    }
}
