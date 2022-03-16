//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

#if os(macOS)
    import AppKit
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

public protocol LayoutContext {

    // MARK: LayoutContext

    associatedtype Region: SymbolicRegion

    func registerRegion(in registry: inout SymbolicRegionRegistry)
}

extension LayoutContext {

    // MARK: LayoutContext

    @inlinable
    public func layout(@PragmaticConstraintBuilder _ makeLayout: () -> [PragmaticConstraintBuilder.Constraint]) -> [NSLayoutConstraint] {
        var registry = SymbolicRegionRegistry()
        registerRegion(in: &registry)
        return makeLayout().compactMap {
            let native = $0.makePragmatic(registry)?.native
            native?.identifier = $0.description
            return native
        }
    }
}
