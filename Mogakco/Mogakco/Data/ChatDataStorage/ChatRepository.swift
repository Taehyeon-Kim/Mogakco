//
//  ChatRepository.swift
//  Mogakco
//
//  Created by taekki on 2022/12/03.
//

import Foundation

import Realm
import RealmSwift
import RxSwift

protocol ChatRepository {
    associatedtype T
    
    func fetchAllChat() -> Observable<[T]>
    func save(chat: T) -> Observable<Void>
    func fetchChat(for uid: String) -> Observable<[T]>
}

final class ChatRepositoryImpl<T: RealmConvertibleType>: ChatRepository where T == T.RealmType.DomainType, T.RealmType: Object {

    private var realm: Realm {
        do {
            return try Realm()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    /// 채팅방 입장 전, 과거 Chat 목록 가져오기
    func fetchAllChat() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
                .asArray()
                .map { $0.asDomain() }
            return Observable.just(objects)
        }
    }
    
    /// Post 요청 후 Chat 저장
    func save(chat: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.save(entity: chat)
        }
    }
    
    /// 특정 유저 채팅 필터링
    func fetchChat(for uid: String) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let predicate = NSPredicate(format: "uid == %@", uid)
            let objects = realm.objects(T.RealmType.self)
                .filter(predicate)
                // 기본적으로 날짜순으로 정렬해서 필터해오도록 구성(채팅의 경우 old > new)이기 때문
                .sorted(byKeyPath: "date")
                .asArray()
                .map { $0.asDomain() }
            return Observable.just(objects)
        }
    }
}
