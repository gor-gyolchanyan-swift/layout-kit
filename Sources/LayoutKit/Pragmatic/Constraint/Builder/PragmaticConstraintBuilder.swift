//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
@resultBuilder
public enum PragmaticConstraintBuilder {

    // MARK: PragmaticConstraintBuilder

    // This scope is intentionally left blank.
}

extension PragmaticConstraintBuilder {

    // MARK: PragmaticConstraintBuilder - ResultBuilder

    @inlinable
    public static func buildExpression<SourceRegion, TargetRegion>(
        _ constraint: SymbolicConstraintForStaticDistance<SymbolicLocationKeyX, SourceRegion, TargetRegion>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildExpression<SourceRegion, TargetRegion>(
        _ constraint: SymbolicConstraintForStaticDistance<SymbolicLocationKeyY, SourceRegion, TargetRegion>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildExpression<SourceRegionForSource, TargetRegionForSource, SourceRegionForTarget, TargetRegionForTarget>(
        _ constraint: SymbolicConstraintForDynamicDistance<SymbolicLocationKeyX, SourceRegionForSource, TargetRegionForSource, SymbolicLocationKeyX, SourceRegionForTarget, TargetRegionForTarget>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildExpression<SourceRegionForSource, TargetRegionForSource, SourceRegionForTarget, TargetRegionForTarget>(
        _ constraint: SymbolicConstraintForDynamicDistance<SymbolicLocationKeyX, SourceRegionForSource, TargetRegionForSource, SymbolicLocationKeyY, SourceRegionForTarget, TargetRegionForTarget>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildExpression<SourceRegionForSource, TargetRegionForSource, SourceRegionForTarget, TargetRegionForTarget>(
        _ constraint: SymbolicConstraintForDynamicDistance<SymbolicLocationKeyY, SourceRegionForSource, TargetRegionForSource, SymbolicLocationKeyX, SourceRegionForTarget, TargetRegionForTarget>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildExpression<SourceRegionForSource, TargetRegionForSource, SourceRegionForTarget, TargetRegionForTarget>(
        _ constraint: SymbolicConstraintForDynamicDistance<SymbolicLocationKeyY, SourceRegionForSource, TargetRegionForSource, SymbolicLocationKeyY, SourceRegionForTarget, TargetRegionForTarget>
    ) -> Constraint {
        return .init(description: constraint.description) { registry in
            return constraint.makePragmatic(using: registry)
        }
    }

    @inlinable
    public static func buildBlock(_ constraitList: Constraint...) -> [Constraint] {
        return constraitList
    }

    @inlinable
    public static func buildOptional(_ constraintList: [Constraint]?) -> [Constraint] {
        return constraintList ?? []
    }

    @inlinable
    public static func buildEither(first constraintList: [Constraint]) -> [Constraint] {
        return constraintList
    }

    @inlinable
    public static func buildEither(second constraintList: [Constraint]) -> [Constraint] {
        return constraintList
    }

    @inlinable
    public static func buildArray(_ constraintListList: [[Constraint]]) -> [Constraint] {
        return constraintListList.flatMap { $0 }
    }

    @inlinable
    public static func buildLimitedAvailability(_ constraintList: [Constraint]) -> [Constraint] {
        return constraintList
    }

    public static func buildFinalResult(_ constraintList: [Constraint]) -> [Constraint] {
        return constraintList
    }
}

extension PragmaticConstraintBuilder {

    // MARK: PragmaticConstraintBuilder - Constraint

    @frozen
    public struct Constraint {

        // MARK: PragmaticConstraintBuilder.Constraint

        @inlinable
        internal init(description: String, _ makePragmatic: @escaping (SymbolicRegionRegistry) -> PragmaticConstraint?) {
            self.description = description
            self.makePragmatic = makePragmatic
        }

        @usableFromInline
        internal let description: String

        @usableFromInline
        internal let makePragmatic: (SymbolicRegionRegistry) -> PragmaticConstraint?
    }
}
