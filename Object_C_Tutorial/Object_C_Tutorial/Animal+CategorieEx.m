//
//  Animal+CategorieEx.m
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

#import "Animal+CategorieEx.h"

//카테고리는 약간 Swift에서 Extension이랑 비슷한 것 같다.
@implementation Animal (CategorieEx)

- (BOOL) checkedByVet{
    return 1;
}

- (void) getShots{
    NSLog(@"%@ got its shots", self.name);
}

@end
