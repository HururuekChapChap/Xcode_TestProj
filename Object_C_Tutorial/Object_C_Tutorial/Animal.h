//
//  Animal.h
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 프로퍼티나 함수들의 이름을 적는 공간
// 그러니깐 약간,,, 추상 클래스 같은 느낌? 프로퍼티 같은 느낌
// interface라고 되어 있으니 추상 클래스가 맞고 그것의 타임은 NSObject 이다
@interface Animal : NSObject

//interface 타입이라는 것은 클래스이고
//클래스는 고정된 값을 가질 수 없다,, 그래서 포인터를 반드시 해줘야한다.
@property NSString *name;
@property NSString *faveFood;
@property NSArray *sounds;

//float는 클래스 타입이 아니기 때문에 포인터가 필요 없다.
@property float weight;

// - 로 되어 있는 것은 외부에서 접근이 불가능 하다 그러니깐 private와 같은 용도?
// 같은 Animal.m에서는 접근이 아마 가능 할 것이다.
// instacetype은 현재 Animal을 반환하는 것을 의미한다.
// 그리고 매개 변수가 하나라면 함수이름 : (지료형)Animal.m에서 사용 할 매개변수이름
- (instancetype) initWithName:(NSString *)defaultName;

// void 타입의 함수이고
// 함수 이름이 getInfo
- (void) getInfo;

// 반환이 float 타입이고 함수 이름이 weightInKg 이고
// 매개변수 이름은 weightInLbs
- (float) weightInKg : (float) weightInLbs;

//NSStirng 타입이니깐 포인터가 들어가고 위와 동일하다
- (NSString *) takToMe : (NSString *) myName;

- (int) allSoundsCount : (NSArray *) soundlists;

// 매개변수가 두개 이상일 때는
// (반환 티입) 함수 이름(= 다른 파일에서 사용할 매개 변수 이름) : (지료형)Animal.m에서 사용 할 매개변수 이름
// 두번째 이름(= 다른 파일에서 사용할 매개 변수 이름 두번째) : (자료형) Animal.m에서 사용 할 두번째 매개변수 이름
- (int) getSum : (int) num1 nextNumber: (int) num2;


@end

NS_ASSUME_NONNULL_END
