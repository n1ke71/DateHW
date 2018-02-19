//
//  AppDelegate.m
//  DateHW
//
//  Created by Ivan Kozaderov on 05.02.2018.
//  Copyright © 2018 Ivan Kozaderov. All rights reserved.
//

#import "AppDelegate.h"
#import "KIStudent.h"
#import "Names_Array.h"

//#define PUPIL
//#define STUDENT
//#define MASTER
//#define SUPERMANFIRST
//#define SUPERMANSECOND
#define SUPERMANTHIRD


#define ONESECOND 1
#define ONEMINUTE ONESECOND*60
#define ONEHOUR   ONEMINUTE*60
#define ONEDAY    ONEHOUR*24
#define YEAR      ONEDAY*365

@interface AppDelegate ()
@property(nonatomic,strong)    NSMutableArray* students;
@property(nonatomic,strong)    NSDate* date;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef PUPIL
    
    self.students = [NSMutableArray array];
    
    for (int i = 0; i<30; i++) {
        
        KIStudent* student  = [[KIStudent alloc]init];
        //2002 - 16
        //1968 - 50
        NSTimeInterval ti = (double)YEAR * (arc4random_uniform(34)+16);
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:-ti];
        student.dateOfBirth = date;
        [self.students addObject:student];
    }
    
    for (KIStudent* student in self.students) {
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSLog(@"%@",[formatter stringFromDate:student.dateOfBirth]);
        
    }
    
    
    
#endif
    
 #ifdef STUDENT
    
     [self.students sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        KIStudent* student1 = (KIStudent*)obj1;
        KIStudent* student2 = (KIStudent*)obj2;
        
        return [student1.dateOfBirth compare:student2.dateOfBirth];
    }];
    
    for (KIStudent* student in self.students) {
        
        student.name     = firstNames[arc4random_uniform(10)];
        student.lastName = lastNames [arc4random_uniform(10)];
    }
    
    for (KIStudent* student in self.students) {
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSLog(@"%@ %@ %@",student.name,student.lastName,[formatter stringFromDate:student.dateOfBirth]);
        
    }
   
#endif

#ifdef MASTER
  
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    
    [timer fire];
    
    self.date = [NSDate dateWithTimeIntervalSince1970: - 2 * YEAR];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
   // NSLog(@"self.date=%@ ",[formatter stringFromDate:self.date]);
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate*date1 = [[self.students firstObject] dateOfBirth];
    NSDate*date2 = [[self.students lastObject ] dateOfBirth];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear
                                               fromDate:date1 toDate:date2 options:0];

    NSLog(@"%@",components);
    
    
#endif
#ifdef SUPERMANFIRST

    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear fromDate:[NSDate date]];
    
    for (int i = 1; i <= 12; i++) {
        
        [components setMonth:i];
        [components setDay  :1];
        NSDate* date = [calendar dateFromComponents:components];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MMMM/EEEE"];
        NSLog(@"%@",[formatter stringFromDate:date]);
        
    }
#endif
    
#ifdef SUPERMANSECOND
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDate* date = [NSDate date];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear fromDate:date];

    components.day = 1;
  
    
    for (int i = 1; i <= 12; i++) {
        
        components.month = i;
        
        date = [calendar dateFromComponents:components];
        [self arrayOfDaysFromDate:date];
        
    }

#endif

#ifdef SUPERMANTHIRD
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDate* date = [NSDate date];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear fromDate:date];
    
    components.day = 1;
    
    for (int i = 1; i <= 12; i++) {
        
        components.month = i;
        
        date = [calendar dateFromComponents:components];
        [self arrayOfDaysFromDate:date];
        
    }
    
#endif

    return YES;
}

-(void) arrayOfDaysFromDate:(NSDate*) date{
    
  //  NSLog(@"%@",date);
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"MMMM"];
    NSString* month = [formatter1 stringFromDate:date];
    NSUInteger numberOfWorkingDays = 0;
    NSCalendar* calendar  = [NSCalendar currentCalendar];
    calendar.firstWeekday = 1 ;
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth fromDate:date];

    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MMMM/dd EEEE"];
    
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    for (ushort day = dayRange.location; day <= dayRange.length; day++){
        
        components.day = day;
        
        NSDate *d = [calendar dateFromComponents:components];
        NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday fromDate:d];
 
        
        if ((comp.weekday == 1) | (comp.weekday == 7)){
            
           // NSLog(@"%@",[formatter stringFromDate:d]);
        
        }
        else numberOfWorkingDays++;
        
    }
    
    NSLog(@"Number of working days in %@:%lu ",month,numberOfWorkingDays);
    
}

-(void)timerTick:(NSTimer*) timer{
    
    
    
    //NSLog(@"timer tick one day");
    
    self.date = [self.date dateByAddingTimeInterval:ONEDAY];
    
    NSLog(@"%@",self.date);
    
    if(self.date){
        
        BOOL isValid =  [self birthDay:self.date ofStudent:self.students];
   
        if (!isValid) [timer invalidate];

    }
}

-(BOOL)birthDay:(NSDate*)currentDate ofStudent:(NSMutableArray*)students{

    for (KIStudent*student in students) {
        
        NSCalendar* calendar  = [NSCalendar currentCalendar];
        NSInteger currentDay  = [calendar component:NSCalendarUnitDay  fromDate:currentDate];
        NSInteger studentsDay = [calendar component:NSCalendarUnitDay  fromDate:student.dateOfBirth];

        if (currentDay == studentsDay) {
            NSLog(@"Happy Birthday %@ %@!",student.name,student.lastName);
        }
        
    }
   
    BOOL result;
    NSCalendar* calendar   = [NSCalendar currentCalendar];
    NSInteger currentYear  = [calendar component:NSCalendarUnitYear  fromDate:currentDate];
    
    if(currentYear < 2002) {
        
         result = YES;
    }
    else result = NO;
    
  return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
