//
//  Animal+CategorieEx.h
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

//메소드들을 정의하는 곳이다. Categories는 그러니깐 swift의 Extension이랑 비슷
@interface Animal (CategorieEx)

- (BOOL) checkedByVet;
- (void) getShots;

@end

NS_ASSUME_NONNULL_END
