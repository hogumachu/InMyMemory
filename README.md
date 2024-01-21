# InMyMemory

[![codecov](https://codecov.io/gh/hogumachu/InMyMemory/graph/badge.svg?token=EHJTO5HDZK)](https://codecov.io/gh/hogumachu/InMyMemory)

InMyMemory는 자신의 기억을 저장할 수 있는 앱입니다.

### 앱 소개

![image](https://github.com/hogumachu/DDU-DO/assets/74225754/da11a74d-2c0a-4610-b44a-6f7f234a83d8)


### 기술

* RxSwift, ReactorKit
* RxFlow
* Clean Architecture

### 모듈 구조

* Shared: 공용으로 사용되는 모듈
* Domain: Entity, Interface, UseCase
* Data: DB, Repository (Implementation)
* Presentation: View, Reactor, etc (UI)

### 테스팅

* XCTest
* Quick, Nimble
* SnapshotTesting
