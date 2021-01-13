//
//  main.m
//  Object_C_Tutorial
//
//  Created by yoon tae soo on 2021/01/13.
//

//swift의 foundation과 동일함
#import <Foundation/Foundation.h>

void StringFuncion() {
    
    NSLog(@"Hello, World!");
    
    //IS is not existing
    NSString *nothing = nil;
    
    //Printf 와 동일한 방법
    NSLog(@"Location of nil : %p ,", nothing);
    //문자열 앞에는 반드시 @가 필요함
    NSString *quote = @"Dogs habe masters, while cats have staff";
    //문자열의 길이를 출력하는 방법
    NSLog(@"Size of String : %d" , (int)[quote length]) ;
    
    NSLog(@"Character at 5 : %c", [quote characterAtIndex:5]);
    
    //Dynamic String 생성 방법
    char *name = "Derek";
    NSString *myName = [NSString stringWithFormat:@"- %s", name];
    
    BOOL isStringEqual = [quote isEqualToString: myName];
    printf("Are String equal : %d \n", isStringEqual);
    
    const char *uCstring = [[myName uppercaseString]UTF8String];
    printf("%s\n", uCstring);
    
    NSString *wholeQuote = [quote stringByAppendingString:myName];
    
    NSRange searchResult = [wholeQuote rangeOfString:@"Derek"];
    
    //location은 찾은 첫 위치를 의미
    if (searchResult.location == NSNotFound) {
        NSLog(@"String not found");
    }
    else{
        //searchResult.length는 Range의 총 길이
        printf("Derek is at index %lu and is %lu long\n", searchResult.location, searchResult.length);
        NSLog(@"Character at 5 : %c", [wholeQuote characterAtIndex: searchResult.location]);
    }
    
    NSRange range = NSMakeRange(42, 5);
    const char *newQuote = [[wholeQuote stringByReplacingCharactersInRange:range withString:@"Anon"]UTF8String];
    printf("%s", newQuote);
    
    //문자열에 추가하고 삭제하고 이런거 만드는 방법
    //위에 것들은 새로운 변수를 만들고 추가하고 이랬는데, 이 친구는 그냥 변할 수 있는거
    NSMutableString *groceryList = [NSMutableString stringWithCapacity:50]; // String 크기 50
    [groceryList appendFormat:@"%s", "ABCD EFGH IJKL MNOP"];
    
    NSLog(@"groceryList : %@ %ld", groceryList, groceryList.length);
    
    [groceryList deleteCharactersInRange:NSMakeRange(0, 10)];
    
    NSLog(@"groceryList : %@ %ld", groceryList, groceryList.length);
    
    [groceryList replaceCharactersInRange:NSMakeRange(0, 4) withString:@"ABCD"];
    
    NSLog(@"groceryList : %@ %ld", groceryList, groceryList.length);
    
    [groceryList insertString:@" QRST UVWXYZ" atIndex:groceryList.length];
    
    NSLog(@"groceryList : %@ %ld", groceryList, groceryList.length);
    
    
}

void arrayFunction(){
    
    //Array 앞에는 @를 붙여준다.
    NSArray *officeSupplies = @[@"Pencils", @"Paper"];
    
    NSLog(@"First : %@", officeSupplies[0]);
    NSLog(@"Office Supplies : %@", officeSupplies);
    
    BOOL containsItem = [officeSupplies containsObject:@"Pencils"];
    NSLog(@"is contain Pencils %d", containsItem);
    
    //배열의 크기는 몇인가
    NSLog(@"Total : %ld", [officeSupplies count]);
    
    //배열의 어느 위치에 있는가
    NSLog(@"Index of Pencils is at %lu", [officeSupplies indexOfObject:@"Paper"]);
    
    //NSMutableArray().arrayWithCapacity(5)랑 같은 말
    NSMutableArray *heroes = [NSMutableArray arrayWithCapacity:5];
    [heroes addObject:@"Batman1"];
    [heroes addObject:@"Batman2"];
    [heroes addObject:@"Batman3"];
    [heroes addObject:@"Batman4"];
    
    [heroes insertObject:@"Superman" atIndex:2];
    
    NSLog(@"all items in heroes %@", heroes);
    
    [heroes removeObject:@"Flash"]; //heroes.removeObject 랑 같은 말
    [heroes removeObjectAtIndex: 0];
    
    NSLog(@"all items in heroes %@", heroes);
    
    //매개변수로 넘길 때는 []이런거 없어도 되나보다 ㅎㅎㅎ
    //범위 0 - 1 까지 에서 Superman과 동일한 값을 가진 것을 지워버림
    [heroes removeObjectIdenticalTo:@"Superman" inRange: NSMakeRange(0, 2)];
    
    NSLog(@"all items in heroes %@", heroes);
}

float (^getArea) (float h, float w);

enum Ratings {
    Poor = 1,
    Ok = 2,
    great = 5
};

#import "Animal.h"
#import "Koala.h"
#import "Animal+CategorieEx.h"
int main(int argc, const char * argv[]) {
    
    //ARC와 동일한 것
    @autoreleasepool {
        // insert code here...
//        StringFuncion();
//        arrayFunction();
        
        
        //객체 생성 방법 : Animal().init() 과 동일한 의미
        Animal *dog = [[Animal alloc] init];
        
        //dog.getInfo
        [dog getInfo];
        
        //[dog name] == dog.name
        NSLog(@"The dogs name is %@", [dog name]);
        
        
        //@Property로 선언 해줬기 때문에 set 함수 설정이 자동으로 되어 있다.
        [dog setName:@"Hello World"];
        
        NSLog(@"The dogs name is %@", [dog name]);
        
        Animal *cat = [[Animal alloc] initWithName:@"Hururuek"];
        
        NSLog(@"The cats name is %@", cat.name); // 꼭 [cat name] 이렇게 안해줘도 된다.
        
        //weigthInKg는 함수 이름이면서 매개변수 이름이 된다.
        NSLog(@"180 lbs = %.2f kg", [dog weightInKg:180]);
        
        NSLog(@"3 + 5 = %d", [dog getSum:5 nextNumber:2]);
        
        NSLog(@"%@", [dog takToMe:@"Derek"]);
        
        for (int i = 0; i < cat.sounds.count; i++) {
            NSLog(@"%@", cat.sounds[i]);
        }
        
        Koala *herbie = [[Koala alloc] initWithName:@"Herbie"];
        
        NSLog(@"%@", [herbie takToMe:@"Derick"]);
        
        NSLog(@"Did %@ receive shots : %d", herbie.name, [herbie checkedByVet]);
        
        [herbie getShots];
        
        [dog getInfo];
        
        
        //Block이라고 불리는데 전체적인 틀을 주고
        //나중에 ^반환타임(자료형 변수, 자료형 변수){내용}; 이렇게 해서 값을 반환하는 것 같다
        //약간 클로저 비슷한듯 아닌거 같은 그런 느낌
        getArea = ^float(float width , float height){
            return width * height;
        };
        
        NSLog(@"Area of 3 widht and 50 height : %.1f", getArea(3,50));
        
        enum Ratings matrixRating = great;
        
        //여기서 u는 unsing int를 의미한다.
        NSLog(@"Matrix %u", matrixRating);
        
    }
    return 0;
}
