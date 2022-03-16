//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@usableFromInline
internal enum PragmaticConstraint {

    // MARK: PragmaticConstraint

    case distance(
        source: PragmaticDistance,
        relation: SymbolicRelation,
        target: (distance: PragmaticDistance, scale: NativeScalar)?,
        bias: NativeScalar
    )
}

extension PragmaticConstraint {

    // MARK: PragmaticConstraint - Native

    @inlinable
    internal var native: NativeConstraint {
        switch self {
            case .distance(source: let source, relation: let relation, target: let target, bias: let bias):
                switch (relation, target) {
                    case (.lessThanOrEqual, nil):
                        return source.native.constraint(lessThanOrEqualToConstant: bias)
                    case (.lessThanOrEqual, let target?):
                        return source.native.constraint(lessThanOrEqualTo: target.distance.native, multiplier: target.scale, constant: bias)
                    case (.equal, nil):
                        return source.native.constraint(equalToConstant: bias)
                    case (.equal, let target?):
                        return source.native.constraint(equalTo: target.distance.native, multiplier: target.scale, constant: bias)
                    case (.greaterThanOrEqual, nil):
                        return source.native.constraint(greaterThanOrEqualToConstant: bias)
                    case (.greaterThanOrEqual, let target?):
                        return source.native.constraint(greaterThanOrEqualTo: target.distance.native, multiplier: target.scale, constant: bias)
                }
        }
    }
}
