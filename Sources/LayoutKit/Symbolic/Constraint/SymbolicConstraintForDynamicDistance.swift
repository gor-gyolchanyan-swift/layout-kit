//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct SymbolicConstraintForDynamicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>: Hashable
where LocationKeyForSource: SymbolicLocationKey, SourceRegionForSource: SymbolicRegion, TargetRegionForSource: SymbolicRegion, LocationKeyForTarget: SymbolicLocationKey, SourceRegionForTarget: SymbolicRegion, TargetRegionForTarget: SymbolicRegion {

    // MARK: SymbolicConstraintForDynamicDistance

    @inlinable
    internal init(
        _ source: SymbolicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource>,
        is relation: SymbolicRelation,
        to target: SymbolicDistance<LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>
    ) {
        self.source = source
        self.relation = relation
        self.target = target
    }

    @usableFromInline
    internal let source: SymbolicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource>

    @usableFromInline
    internal let relation: SymbolicRelation

    @usableFromInline
    internal let target: SymbolicDistance<LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>
}

extension SymbolicConstraintForDynamicDistance: CustomStringConvertible {

    // MARK: CustomStringConvertible

    @inlinable
    public var description: String {
        return "\(source) \(relation) \(target)"
    }
}

extension SymbolicConstraintForDynamicDistance
where LocationKeyForSource == SymbolicLocationKeyX, LocationKeyForTarget == SymbolicLocationKeyX {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: (distance: pragmaticTarget, scale: .init(target.scale / source.scale)),
            bias: .init((target.bias - source.bias) / source.scale)
        )
    }
}

extension SymbolicConstraintForDynamicDistance
where LocationKeyForSource == SymbolicLocationKeyX, LocationKeyForTarget == SymbolicLocationKeyY {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: (distance: pragmaticTarget, scale: .init(target.scale / source.scale)),
            bias: .init((target.bias - source.bias) / source.scale)
        )
    }
}

extension SymbolicConstraintForDynamicDistance
where LocationKeyForSource == SymbolicLocationKeyY, LocationKeyForTarget == SymbolicLocationKeyX {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: (distance: pragmaticTarget, scale: .init(target.scale / source.scale)),
            bias: .init((target.bias - source.bias) / source.scale)
        )
    }
}

extension SymbolicConstraintForDynamicDistance
where LocationKeyForSource == SymbolicLocationKeyY, LocationKeyForTarget == SymbolicLocationKeyY {

    // MARK: SymbolicConstraintForStaticDistance - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticConstraint? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .distance(
            source: pragmaticSource,
            relation: relation,
            target: (distance: pragmaticTarget, scale: .init(target.scale / source.scale)),
            bias: .init((target.bias - source.bias) / source.scale)
        )
    }
}
