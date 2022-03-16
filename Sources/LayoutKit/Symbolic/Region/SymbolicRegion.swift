//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

public protocol SymbolicRegion: Hashable {

    // MARK: SymbolicRegion

    // This scope is intentionally left blank.
}

extension SymbolicRegion {

    // MARK: SymbolicRegion - Location

    @inlinable
    public subscript(_ key: SymbolicLocationKeyX) -> SymbolicLocation<SymbolicLocationKeyX, Self> {
        return .init(key, in: self)
    }

    @inlinable
    public subscript(_ key: SymbolicLocationKeyY) -> SymbolicLocation<SymbolicLocationKeyY, Self> {
        return .init(key, in: self)
    }

    @inlinable
    public var width: SymbolicDistance<SymbolicLocationKeyX, Self, Self> {
        return self[.trailing] - self[.leading]
    }

    @inlinable
    public var height: SymbolicDistance<SymbolicLocationKeyY, Self, Self> {
        return self[.bottom] - self[.top]
    }
}

extension SymbolicRegion {

    // MARK: SymbolicRegion - Registry

    @inlinable
    internal func makePragmatic(using registry: SymbolicRegionRegistry) -> PragmaticRegion? {
        return registry.makePragmatic(self)
    }
}
