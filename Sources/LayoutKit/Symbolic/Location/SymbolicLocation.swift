//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct SymbolicLocation<Key, Region>: Hashable
where Key: SymbolicLocationKey, Region: SymbolicRegion {

    // MARK: SymbolicLocation

    @inlinable
    internal init(_ key: Key, in region: Region) {
        self.key = key
        self.region = region
    }

    @usableFromInline
    internal let key: Key

    @usableFromInline
    internal let region: Region
}

extension SymbolicLocation: CustomStringConvertible {

    // MARK: CustomStringConvertible

    @inlinable
    public var description: String {
        return "\(region)[\(key)]"
    }
}

@inlinable
public func ... <Key, SourceRegion, TargetRegion>(
    _ source: SymbolicLocation<Key, SourceRegion>,
    _ target: SymbolicLocation<Key, TargetRegion>
) -> SymbolicDistance<Key, SourceRegion, TargetRegion> {
    return .init(from: source, to: target, scale: 1, bias: 0)
}

extension SymbolicLocation
where Key == SymbolicLocationKeyX {

    // MARK: SymbolicLocation - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticLocationX? {
        guard let pragmaticRegion = region.makePragmatic(using: registry) else {
            return nil
        }
        return .init(key, in: pragmaticRegion)
    }
}

extension SymbolicLocation
where Key == SymbolicLocationKeyY {

    // MARK: SymbolicLocation - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticLocationY? {
        guard let pragmaticRegion = region.makePragmatic(using: registry) else {
            return nil
        }
        return .init(key, in: pragmaticRegion)
    }
}
