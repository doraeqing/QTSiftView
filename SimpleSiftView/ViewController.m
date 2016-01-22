//
//  ViewController.m
//  SimpleSiftView
//
//  Created by Lucius on 16/1/20.
//  Copyright © 2016年 L.Q. All rights reserved.
//

#import "ViewController.h"
#import "WLSiftView.h"
#import "WLSiftTabItem.h"

static  NSString * kCellIdentifier = @"SortCell";

@interface ViewController ()
<
WLSiftViewTypeDataSource,
WLSiftViewTypeDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) UITableView *tvSort1;

@property (nonatomic, weak) WLSiftView *siftView;

@end

@implementation ViewController
{
    NSMutableArray *arrItems;
    NSArray *arrSortData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadDefaultData];
}
- (void)loadDefaultData {
    arrSortData = @[@"呵呵",@"嘻嘻",@"哈哈",@"嘿嘿",@"咻咻"];
    
    arrItems = [NSMutableArray array];
    NSMutableArray *arrTemp = [NSMutableArray arrayWithObjects:@"美食",@"餐饮",@"人物",@"嘻嘻", nil];
    UIImage *image1 = [UIImage imageNamed:@"icon_price"];
    UIImage *image2 = [UIImage imageNamed:@"icon_location"];
    UIImage *image3 = [UIImage imageNamed:@"icon_theme"];
    UIImage *image4 = [UIImage imageNamed:@"icon_time"];
    NSMutableArray *arrIcons = [NSMutableArray arrayWithObjects:image1,image2,image3,image4 ,nil];
    for (int i = 0; i < 4; i++) {
        WLSiftTabItem *item = [[WLSiftTabItem alloc] initWithTitle:arrTemp[i]
                                                         defaultTitleColor:[UIColor whiteColor]
                                                        selectedTitleColor:[UIColor redColor]
                                                              defaultImage:arrIcons[i]
                                                               selectImage:nil
                                                                  selected:NO];
        [arrItems addObject:item];
    }
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    WLSiftView *siftView = [[WLSiftView alloc] initWithFrame:CGRectMake(0, height - 50, self.view.frame.size.width, 50)];
    siftView.delegate = self;
    siftView.dataSource = self;
    self.siftView = siftView;
    [self.view addSubview:siftView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - accessor
- (UITableView *)tvSort1 {
    if (!_tvSort1) {
        _tvSort1 = [[UITableView alloc] init];
        _tvSort1.delegate = self;
        _tvSort1.dataSource = self;
        [_tvSort1 registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tvSort1;
}
#pragma mark - siftDataSource siftDelegate
- (NSInteger)numberOfTabsInSitfView:(WLSiftView *)siftView {
    return 4;
}
- (id<WLSiftTabItem>)siftView:(WLSiftView *)siftView itemForTabAtIndex:(NSInteger)index {
    return arrItems[index];
}
- (UIView *)siftView:(WLSiftView *)siftView viewForContentAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            return self.tvSort1;
        }
            break;
        case 1:
        {
            UIView *v1 = [[UIView alloc] init];
            v1.backgroundColor = [UIColor whiteColor];
            return v1;
        }
            break;
        case 2:
        {
            UIView *v1 = [[UIView alloc] init];
            v1.backgroundColor = [UIColor greenColor];
            return v1;
        }
            break;
        case 3:
        {
            UIView *v1 = [[UIView alloc] init];
            v1.backgroundColor = [UIColor purpleColor];
            return v1;
        }
            break;
        default:
            return nil;
            break;
    }
}
- (void)siftView:(WLSiftView *)siftView didSelectdTabAtIndex:(NSInteger)index {
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tvSort1) {
        return arrSortData.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tvSort1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                                forIndexPath:indexPath];
        cell.textLabel.text = arrSortData[indexPath.row];
        return cell;
    }
    return UITableViewCell.new;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"------%@",arrSortData[indexPath.row]);
    [self.siftView dismissContentView];
}
@end
