import BuildKit
import RxSwift

public final class RxDataStore: ReactiveCompatible {
    fileprivate let dataStore: DataStore
    fileprivate init(_ dataStore: DataStore) {
        self.dataStore = dataStore
    }
}

public extension DataStore {
    var rx: Reactive<RxDataStore> {
        return RxDataStore(self).rx
    }
}

public extension Reactive where Base: RxDataStore {
    func readItem<T: Storable>() -> Observable<T> {
        do {
            return .just(try self.base.dataStore.readItem())
        } catch {
            return .error(error)
        }
    }

    func readItems<T: Storable>() -> Observable<[T]> {
        do {
            return .just(try self.base.dataStore.readItems())
        } catch {
            return .error(error)
        }
    }
    
    func create<T: Storable>(_ item: T) -> Observable<T> {
        do {
            try self.base.dataStore.create(item)
            return .just(item)
        } catch {
            return .error(error)
        }
    }
    
    func create<T: Storable>(_ items: [T]) -> Observable<[T]> {
        do {
            try self.base.dataStore.create(items)
            return .just(items)
        } catch {
            return .error(error)
        }
    }
}
