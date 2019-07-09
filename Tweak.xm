#import <SafariServices/SafariServices.h>

@interface ZBPackageInfoView : UIView {
	NSMutableDictionary *infos;
}
@property (strong, nonatomic) UITableView *tableView;
+(NSArray *)packageInfoOrder;
@end

@interface ZBPackage : NSObject
@end

%hook ZBPackageInfoView

+ (NSArray *)packageInfoOrder {
	NSArray *origPkgInfoOrder = %orig;
	NSMutableArray *pkgInfoOrder = [NSMutableArray arrayWithArray:origPkgInfoOrder];
	int i = (int)[pkgInfoOrder count];
    [pkgInfoOrder insertObject:@"TweakCompatible" atIndex:i];
	return pkgInfoOrder;
}

- (UITableViewCell *)tableView:(UITableView *)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2 {
	if ([arg2 row] == [[[self class] packageInfoOrder] indexOfObject:@"TweakCompatible"]) {
		UITableViewCell *cell = %orig;
		[[cell textLabel] setText:@"Works with your device"];
		[[cell textLabel] setTextColor:[UIColor colorWithRed:.224 green:.792 blue:.459 alpha:1.0]];
		[[cell detailTextLabel] setText:@"TweakCompatible"];

		UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];

		UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
		[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		
		
		
    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
		[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
    	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
		[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
    	[buttonsStackView addArrangedSubview:viewReportsButton];
		[buttonsStackView addArrangedSubview:addReportButton];

		[cell setAccessoryView:buttonsStackView];
		return cell;
    } else {
		return %orig;
	}
}

-(void)setPackage:(ZBPackage *)arg1{
	%orig;
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
	[infoDict setObject:@"TweakCompatible" forKey:@"TweakCompatible"];
	MSHookIvar<NSMutableDictionary *>(self, "infos") = infoDict;
}


%new
-(void)tappedOnViewReports{
	
}

%new
-(void)tappedOnAddReport{

}
%end