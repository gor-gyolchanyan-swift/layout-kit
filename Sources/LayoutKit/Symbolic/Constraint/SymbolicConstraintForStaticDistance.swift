//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct SymbolicConstraintForStaticDistance<LocationKey, SourceRegion, TargetRegion>: Hashable
where LocationKey: SymbolicLocationKey, SourceRegion: SymbolicRegion, TargetRegion: SymbolicRegion {

    // MARK: SymbolicConstraintForDynamicDistance

    @inlinable
    internal init(
        _ source: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
        is relation: SymbolicRelation,
        to target: Float64
    ) {
        self.source = source
        self.relation = relation
        self.target = target
    }

    @usableFromInline
    internal let source: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>

    @usableFromInline
    internal let relation: SymbolicRelation

    @usableFromInline
    internal let target: Float64
}

extension SymbolicConstraintForStaticDistance: CustomStringConvertible {

    // MARK: CustomStringConvertible

    @inlinable
    public var description: String {
        return "\(source) \(relation) \(target)"
    }
}

extension SymbolicConstraintForStaticDistance
where LocationKey == SymbolicLocationKeyX {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard let pragmaticSource = source.makePragmatic(using: registry) else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: nil,
            bias: .init((target - source.bias) / source.scale)
        )
    }
}

extension SymbolicConstraintForStaticDistance
where LocationKey == SymbolicLocationKeyY {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard let pragmaticSource = source.makePragmatic(using: registry) else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: nil,
            bias: .init((target - source.bias) / source.scale)
        )
    }
}
