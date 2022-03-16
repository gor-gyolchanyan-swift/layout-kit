//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@usableFromInline
internal struct PragmaticLocationY {

    // MARK: PragmaticLocationY

    @inlinable
    internal init(_ key: SymbolicLocationKeyY, in region: PragmaticRegion) {
        self.key = key
        self.region = region
    }

    @usableFromInline
    internal let key: SymbolicLocationKeyY

    @usableFromInline
    internal let region: PragmaticRegion
}

extension PragmaticLocationY {

    // MARK: PragmaticLocationY - Native

    @inlinable
    internal var native: NativeLocationY {
        switch region.variant {
            case .view(let view):
                switch key {
                    case .centerY:
                        return view.centerYAnchor
                    case .top:
                        return view.topAnchor
                    case .bottom:
                        return view.bottomAnchor
                    case .firstBaseline:
                        return view.firstBaselineAnchor
                    case .lastBaseline:
                        return view.lastBaselineAnchor
                }
            case .layoutGuide(let layoutGuide):
                switch key {
                    case .centerY:
                        return layoutGuide.centerYAnchor
                    case .top:
                        return layoutGuide.topAnchor
                    case .bottom:
                        return layoutGuide.bottomAnchor
                    case .firstBaseline:
                        // layout guide doesn't have first baseline anchor, so we use closest match: top anchor
                        return layoutGuide.topAnchor
                    case .lastBaseline:
                        // layout guide doesn't have last baseline anchor, so we use closest match: bottom anchor
                        return layoutGuide.bottomAnchor
                }
        }
    }
}
