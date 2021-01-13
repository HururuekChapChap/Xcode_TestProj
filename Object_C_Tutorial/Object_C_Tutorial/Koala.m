//
//  Koala.m
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

#import "Koala.h"

@implementation Koala


- (instancetype) initWithName:(NSString *)defaultName{
    
    self = [super initWithName:@"Hururuek"];
    
    if (self){
        self.name2 = defaultName;
    }
    
    return self;
}

- (NSString *) takToMe:(NSString *)myName{
    
    NSString * response = [NSString stringWithFormat:@"Hello %@ says %@ and %@", myName, _name2, self.name];
    
    return response;
    
}

- (void) performTrick{
    NSLog(@"%@ performs a hand stand", self.name2);
}

- (void ) makeSound{
    NSLog(@"%@ syas Yawn", self.name);
}

@end
