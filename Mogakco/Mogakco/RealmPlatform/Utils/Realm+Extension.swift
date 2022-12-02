//
//  Realm+.swift
//  Mogakco
//
//  Created by taekki on 2022/12/03.
//

import Realm
import RealmSwift
import RxSwift

extension Results {
    func asArray() -> [Element] {
        return compactMap { $0 }
    }
}

extension Realm: ReactiveCompatible {}

extension Reactive where Base == Realm {
    
    func save<R: RealmConvertibleType>(entity: R, update: Bool = true) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity.asRealm(), update: update ? .all : .error)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
