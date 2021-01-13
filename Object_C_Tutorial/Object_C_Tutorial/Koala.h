//
//  Koala.h
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN


//Animal NSObject를 상속받은 객체
@interface Koala : Animal

@property NSString * name2;

- (void) performTrick;
- (void) makeSound;

@end

NS_ASSUME_NONNULL_END
