//
//  Animal.m
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

//우리가 정의했던 Anmial.h 파일을 가져오고 있다
#import "Animal.h"
#import "Animal+Vet.h"

//함수의 기능들을 자세하게 적는 공간 - Algoritm을 적는 공간
@implementation Animal

//init() 이거랑 같은 것이다.
//instaceType이 init을 가리키고
- (instancetype)init
{
    //self은 객체 자체를 Animal을 가리치고
    //[super init]은 super.init() 과 동일한 의미
    self = [super init];
    //self 객체가 존재한다면 그러니깐 super.init()으로 생성 해줬다면
    if (self) {
        self.name = @"No Name";
        //맨 마지막에 nil을 넣어줘야한다.
        self.sounds = [[NSArray alloc] initWithObjects:@1 , @2, @3, nil];
    }
    return self;
}

//우리가 정의한 init 함수
- (instancetype) initWithName:(NSString *)defaultName {
    
    self = [super init];
    
    if (self) {
        
        self.name = defaultName;
        //맨 마지막에 nil을 넣어줘야한다.
        self.sounds = [[NSArray alloc] initWithObjects:@"A" , @"B", @"C", nil];
        
    }
    
    return self;
}

- (void) getInfo{
    NSLog(@"Random Info");
    [self getExamResults];
}

- (float) weightInKg:(float)weightInLbs{
    return weightInLbs * 0.4535;
}

- (int) getSum:(int)num1 nextNumber:(int)num2{
    return num1 + num2;
}

- (NSString * ) takToMe:(NSString *)myName{
    
    //클래스의 프로퍼티를 사용하려면 _name 처럼 _을 붙여줘야한다.
    NSString *response = [NSString stringWithFormat:@"Hello %@ and %@", myName , _name];
    return response;
}

- (int) allSoundsCount:(NSArray *)soundlists{
    return (int)soundlists.count;
}

@end
