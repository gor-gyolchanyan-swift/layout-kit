//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@usableFromInline
internal enum PragmaticDistance {

    // MARK: PragmaticDistance

    case locationX(source: PragmaticLocationX, target: PragmaticLocationX)

    case locationY(source: PragmaticLocationY, target: PragmaticLocationY)
}

extension PragmaticDistance {

    // MARK: PragmaticDistance - Native

    @inlinable
    internal var native: NativeDistance {
        switch self {
            case .locationX(let source, let target):
                return source.native.anchorWithOffset(to: target.native)
            case .locationY(let source, let target):
                return source.native.anchorWithOffset(to: target.native)
        }
    }
}
