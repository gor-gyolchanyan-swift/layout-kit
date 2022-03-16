//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@usableFromInline
internal enum SymbolicRelation: Hashable {

    // MARK: SymbolicRelation

    case lessThanOrEqual

    case equal

    case greaterThanOrEqual
}

extension SymbolicRelation: CustomStringConvertible {

    @inlinable
    public var description: String {
        switch self {
            case .lessThanOrEqual:
                return "<="
            case .equal:
                return "=="
            case .greaterThanOrEqual:
                return ">="
        }
    }
}
