//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct SymbolicDistance<LocationKey, SourceRegion, TargetRegion>: Hashable
where LocationKey: SymbolicLocationKey, SourceRegion: SymbolicRegion, TargetRegion: SymbolicRegion {

    // MARK: SymbolicDistance

    @inlinable
    internal init(
        from source: SymbolicLocation<LocationKey, SourceRegion>,
        to target: SymbolicLocation<LocationKey, TargetRegion>,
        scale: Float64,
        bias: Float64
    ) {
        self.source = source
        self.target = target
        self.scale = scale
        self.bias = bias
    }

    @usableFromInline
    internal let source: SymbolicLocation<LocationKey, SourceRegion>

    @usableFromInline
    internal let target: SymbolicLocation<LocationKey, TargetRegion>

    @usableFromInline
    internal let scale: Float64

    @usableFromInline
    internal let bias: Float64
}

extension SymbolicDistance: CustomStringConvertible {

    // MARK: CustomStringConvertible

    @inlinable
    public var description: String {
        let distanceDescription = "(\(target) - \(source))"
        let scaleDescription = scale == 1 ? "" : " * \(scale)"
        let biasDescription = bias == 0 ? "" : " + \(bias)"
        return "\(distanceDescription)\(scaleDescription)\(biasDescription)"
    }
}

@inlinable
public func + <LocationKey, SourceRegion, TargetRegion>(
    _ `self`: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ bias: Float64
) -> SymbolicDistance<LocationKey, SourceRegion, TargetRegion> {
    return .init(from: self.source, to: self.target, scale: self.scale, bias: self.bias + bias)
}

@inlinable
public func - <LocationKey, SourceRegion, TargetRegion>(
    _ `self`: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ bias: Float64
) -> SymbolicDistance<LocationKey, SourceRegion, TargetRegion> {
    return self + (0 - bias)
}

@inlinable
public func * <LocationKey, SourceRegion, TargetRegion>(
    _ `self`: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ scale: Float64
) -> SymbolicDistance<LocationKey, SourceRegion, TargetRegion> {
    return .init(from: self.source, to: self.target, scale: self.scale * scale, bias: self.bias * scale)
}

@inlinable
public func / <LocationKey, SourceRegion, TargetRegion>(
    _ `self`: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ scale: Float64
) -> SymbolicDistance<LocationKey, SourceRegion, TargetRegion> {
    return self * (1 / scale)
}

@inlinable
public func <= <LocationKey, SourceRegion, TargetRegion>(
    _ source: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ target: Float64
) -> SymbolicConstraintForStaticDistance<LocationKey, SourceRegion, TargetRegion> {
    return .init(source, is: .lessThanOrEqual, to: target)
}

@inlinable
public func == <LocationKey, SourceRegion, TargetRegion>(
    _ source: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ target: Float64
) -> SymbolicConstraintForStaticDistance<LocationKey, SourceRegion, TargetRegion> {
    return .init(source, is: .equal, to: target)
}

@inlinable
public func >= <LocationKey, SourceRegion, TargetRegion>(
    _ source: SymbolicDistance<LocationKey, SourceRegion, TargetRegion>,
    _ target: Float64
) -> SymbolicConstraintForStaticDistance<LocationKey, SourceRegion, TargetRegion> {
    return .init(source, is: .greaterThanOrEqual, to: target)
}

@inlinable
public func <= <LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>(
    _ source: SymbolicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource>,
    _ target: SymbolicDistance<LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>
) -> SymbolicConstraintForDynamicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget> {
    return .init(source, is: .lessThanOrEqual, to: target)
}

@inlinable
public func == <LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>(
    _ source: SymbolicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource>,
    _ target: SymbolicDistance<LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>
) -> SymbolicConstraintForDynamicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget> {
    return .init(source, is: .equal, to: target)
}

@inlinable
public func >= <LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>(
    _ source: SymbolicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource>,
    _ target: SymbolicDistance<LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget>
) -> SymbolicConstraintForDynamicDistance<LocationKeyForSource, SourceRegionForSource, TargetRegionForSource, LocationKeyForTarget, SourceRegionForTarget, TargetRegionForTarget> {
    return .init(source, is: .greaterThanOrEqual, to: target)
}

extension SymbolicDistance
where LocationKey == SymbolicLocationKeyX {

    // MARK: SymbolicLocation - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticDistance? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .locationX(source: pragmaticSource, target: pragmaticTarget)
    }
}

extension SymbolicDistance
where LocationKey == SymbolicLocationKeyY {

    // MARK: SymbolicLocation - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticDistance? {
        guard
            let pragmaticSource = source.makePragmatic(using: registry),
            let pragmaticTarget = target.makePragmatic(using: registry)
        else {
            return nil
        }
        return .locationY(source: pragmaticSource, target: pragmaticTarget)
    }
}
