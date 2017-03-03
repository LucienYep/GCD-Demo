//
//  ViewController.m
//  gcd
//
//  Created by cib on 2017/3/1.
//  Copyright © 2017年 cib. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)sample1{
    
    NSLog(@"任务1");
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务2");
    });
    
    NSLog(@"任务3");
}

- (void)sample2{
    
    NSLog(@"\n");
    NSLog(@"任务1");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务2");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
              NSLog(@"任务3");
        });
        
        NSLog(@"任务4");
    });
    
    NSLog(@"任务5");
}

- (void)sample3{
 
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务1");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSLog(@"任务2");
        });
        
        NSLog(@"任务3");
    });
    
    NSLog(@"任务4");
    
    while (1) {}
    
    NSLog(@"任务5");
}

- (void)lock1
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        NSLog(@"任务1");
    });
}

- (void)lock2
{
    dispatch_queue_t queue = dispatch_queue_create("com.queue.serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        dispatch_sync(queue, ^{
            NSLog(@"任务1");
        });
    });
}

- (void)testLockOrNot
{
    dispatch_queue_t serialQueue = dispatch_queue_create("com.cib.serialQueue", NULL);
    
    dispatch_sync(serialQueue, ^{
        
        NSLog(@"------------");
    });
    
}

- (void)after
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"print in coming 3s");
    });
}

- (void)group
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    int count = 1000;
    
    dispatch_group_async(group, queue, ^{
        
        for (int i = 0; i < count; i++) {
            
            if (i == count - 1) {
                NSLog(@"task1 is completion");
            }
        }
    });
    
    dispatch_group_async(group, queue, ^{
        
        for (int i = 0; i < count; i++) {
            
            if (i == count - 1) {
                NSLog(@"task2 is completion");
            }
        }
    });
    
    dispatch_group_async(group, queue, ^{
        
        for (int i = 0; i < count; i++) {
            
            if (i == count - 1) {
                NSLog(@"task3 is completion");
            }
        }
    });
   
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"all task is completion");
    });
    
}

-(void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"这里只会打印一次");
    });
}

- (void)barrier
{
    NSLog(@"\n");
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_queue_t queue = dispatch_queue_create("com.queue.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        NSLog(@"task1 for reading");
    });
    
    dispatch_async(queue, ^{
        
         NSLog(@"task2 for reading");
    });
    
    dispatch_async(queue, ^{
         NSLog(@"task3 for reading");
    });
    
    dispatch_async(queue, ^{
         NSLog(@"task4 for reading");
    });
    
    dispatch_barrier_async(queue, ^{
        
         NSLog(@"task8 for writing");
    });
    
    dispatch_async(queue, ^{
         NSLog(@"task5 for reading");
    });
    
    dispatch_async(queue, ^{
         NSLog(@"task6 for reading");
    });
    
    dispatch_async(queue, ^{
         NSLog(@"task7 for reading");
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //案例1
//    [self sample1];
    
    //案例2
//    [self sample2];

    //案例3
//    [self sample3];
    
    //死锁1
//    [self lock1];
    
    //死锁2
//    [self lock2];

    //after
//    [self after];
    
    //group
//    [self group];
    
    //once
//    [self once];
 
    //barrier
    [self barrier];
}

@end
