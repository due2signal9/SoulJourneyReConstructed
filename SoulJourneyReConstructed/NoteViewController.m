//
//  NoteViewController.m
//  SoulJourneyReConstructed
//
//  Created by CH on 2017/3/23.
//  Copyright © 2017年 CH. All rights reserved.
//

#import "NoteViewController.h"
#import "DataModel.h"
#import "EditViewController.h"
#import "NoteTableViewCell.h"

@interface NoteViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation NoteViewController {
    
    NSString *homePath;
    NSString *notesPath;
    NSMutableArray<DataModel *> *dataArray;
}

-(void)viewWillAppear:(BOOL)animated {
    
    //=======
    dataArray = [self getNotes];
    [self.myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //dataArray = [NSMutableArray arrayWithCapacity:5];
    
    homePath = NSHomeDirectory();
    notesPath = [homePath stringByAppendingString:@"/Documents/Notes"];
    //NSError *error = [[NSError alloc] init];
    @try {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:notesPath withIntermediateDirectories:YES attributes:nil error:nil];
    } @catch (NSException *exception) {
        
        NSLog(@"already exist!!");
    } @finally {
        
        //NSLog(@"%@", error);
    }
    self.navigationItem.title = @"我的记事本";
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.estimatedRowHeight = 100.0;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoteTVCID"];
    // Do any additional setup after loading the view from its nib.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteTVCID" forIndexPath:indexPath];
    DataModel *model = dataArray[indexPath.row];
    cell.timeLabel.text = model.time;
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.summary;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditViewController *detail = [[EditViewController alloc] init];
    [detail setModel:dataArray[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self deleteData:indexPath.row];
    [dataArray removeObjectAtIndex:indexPath.row];
    [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
}

- (IBAction)addBtnClicked:(id)sender {
    
    EditViewController *editView = [[EditViewController alloc] init];
    [self.navigationController pushViewController:editView animated:YES];
}

- (NSMutableArray *)getNotes {
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:5];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@%@", notesPath, @"/fileName.text"]];
    NSString *str;
    if (handle != nil) {
        
        [handle seekToFileOffset:0];
        NSData *data = [handle readDataToEndOfFile];
        str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return tmpArray;
    }
    for (int i = 0; i < str.length/19; i++) {
        
        NSString *timeStr = [str substringWithRange:NSMakeRange(i*19, 19)];
        NSFileHandle *handle0 = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/%@title.text", notesPath, timeStr]];
        NSFileHandle *handle1 = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/%@summary.text", notesPath, timeStr]];
        [handle0 seekToFileOffset:0];
        NSString *titleStr = [[NSString alloc] initWithData:[handle0 readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        [handle1 seekToFileOffset:0];
        NSString *summaryStr = [[NSString alloc] initWithData:[handle1 readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        DataModel *model = [[DataModel alloc] init];
        model.title = titleStr;
        model.summary = summaryStr;
        model.time = timeStr;
        [tmpArray addObject:model];
    }
    return tmpArray;
}

- (void)deleteData: (NSInteger) index {
    
    NSData *fileNameArray = [[NSData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/fileName.text", notesPath]];
    if (fileNameArray != nil) {
        
        NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/fileName.text", notesPath]];
        [handle seekToFileOffset:0];
        NSData *data = [handle readDataToEndOfFile];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *timeStr = [str substringWithRange:NSMakeRange(index*19, 19)];
        NSString *path = [NSString stringWithFormat:@"%@/%@title.text", notesPath, timeStr];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            @try {
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
        NSString *path1 = [NSString stringWithFormat:@"%@/%@summary.text", notesPath, timeStr];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path1]) {
            
            @try {
                [[NSFileManager defaultManager] removeItemAtPath:path1 error:nil];
            } @catch (NSException *exception) {
            
            } @finally {
                
            }
        }
        
        NSMutableString *strstr = [NSMutableString stringWithString:str];
        [strstr deleteCharactersInRange:NSMakeRange(index*19, 19)];
        [[strstr dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/fileName.text", notesPath] atomically:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
