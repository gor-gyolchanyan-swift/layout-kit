//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

@frozen
public struct SymbolicRegionRegistry {

    // MARK: SymbolicRegionRegistry - Storage

    @usableFromInline
    internal struct StorageKey {

        // MARK: SymbolicRegionRegistry.StorageKey

        @inlinable
        internal init<Region>(_ regionType: Region.Type)
        where Region: SymbolicRegion {
            type = regionType
        }

        @usableFromInline
        internal let type: Any.Type
    }

    @usableFromInline
    internal typealias StorageValue = (AnyHashable) -> PragmaticRegion?

    @usableFromInline
    internal typealias Storage = [StorageKey: StorageValue]

    @inlinable
    internal init(storage: Storage) {
        self.storage = storage
    }

    @usableFromInline
    internal var storage: Storage
}

extension SymbolicRegionRegistry {

    // MARK: SymbolicRegionRegistry - Registering

    @inlinable
    public func isRegistered<Region>(_ regionType: Region.Type = Region.self) -> Bool
    where Region: SymbolicRegion {
        return storage[StorageKey(regionType)] != nil
    }

    @inlinable
    public mutating func register<Region>(_ regionType: Region.Type = Region.self, with routine: @escaping (Region) -> PragmaticRegion?)
    where Region: SymbolicRegion {
        storage[StorageKey(regionType)] = { region in
            guard let region = region as? Region else {
                return nil
            }
            return routine(region)
        }
    }

    @inlinable
    public mutating func unregister<Region>(_ regionType: Region.Type = Region.self)
    where Region: SymbolicRegion {
        storage[StorageKey(regionType)] = nil
    }
}

extension SymbolicRegionRegistry {

    // MARK: SymbolicRegionRegistry

    @inlinable
    internal init() {
        self.init(storage: [:])
    }

    @inlinable
    internal func makePragmatic<Region>(_ region: Region) -> PragmaticRegion?
    where Region: SymbolicRegion {
        return storage[StorageKey(type(of: region))]?(region)
    }
}

extension SymbolicRegionRegistry {

    // MARK: SymbolicRegionRegistry - StorageKey

}

extension SymbolicRegionRegistry.StorageKey: Equatable {

    // MARK: Equatable

    @inlinable
    internal static func == (_ some: Self, _ other: Self) -> Bool {
        return ObjectIdentifier(some.type) == ObjectIdentifier(other.type)
    }
}

extension SymbolicRegionRegistry.StorageKey: Hashable {

    // MARK: Hashable

    @inlinable
    internal func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
    }
}
