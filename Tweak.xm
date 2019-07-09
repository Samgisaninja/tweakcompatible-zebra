#import <SafariServices/SafariServices.h>

NSMutableDictionary *all_packages;

@interface ZBPackageInfoView : UIView {
	NSMutableDictionary *infos;
}
@property (strong, nonatomic) UITableView *tableView;
@property UIViewController *parentVC;
+(NSArray *)packageInfoOrder;
@end

@interface ZBPackage : NSObject
@end

%hook ZBPackageDepictionViewController

-(void)viewDidLoad{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   	NSString *basePath = [paths.firstObject stringByAppendingPathComponent:@"TweakCompatible.plist"];
	all_packages = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:basePath]];
	%orig;
}

%end



%hook ZBPackageInfoView

+(NSArray *)packageInfoOrder {
	NSArray *origPkgInfoOrder = %orig;
	NSMutableArray *pkgInfoOrder = [NSMutableArray arrayWithArray:origPkgInfoOrder];
	int i = (int)[pkgInfoOrder count];
    [pkgInfoOrder insertObject:@"TweakCompatible" atIndex:i];
	return pkgInfoOrder;
}

- (UITableViewCell *)tableView:(UITableView *)arg1 cellForRowAtIndexPath:(NSIndexPath *)arg2 {
    if ([arg2 row] == [[[self class] packageInfoOrder] indexOfObject:@"TweakCompatible"]) {
        UITableViewCell *cell = %orig;
        NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
        NSString *packageID = [infoDict objectForKey:@"packageID"];
        if ([[all_packages allKeys] containsObject:packageID] ) {
            NSDictionary *compatibilityInfo = [NSJSONSerialization JSONObjectWithData:[all_packages objectForKey:packageID] options:0 error:NULL];
            NSArray *allVersions = [compatibilityInfo objectForKey:@"versions"];
			NSDictionary *outcomeDict;
            for (NSDictionary *versionInfo in allVersions){
                if ([[versionInfo objectForKey:@"tweakVersion"] isEqualToString:[compatibilityInfo objectForKey:@"latest"]]) {
                    if (sizeof(void*) == 4) {
                        outcomeDict = [NSDictionary dictionaryWithDictionary:[[versionInfo objectForKey:@"outcome"] objectForKey:@"arch32"]];
                    } else  {
                        outcomeDict = [NSDictionary dictionaryWithDictionary:[versionInfo objectForKey:@"outcome"]];
                    }
                }
            }
			if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"]){
            	[[cell textLabel] setText:@"Works with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.224 green:.792 blue:.459 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		   	 	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
				[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"]) {
                [[cell textLabel] setText:@"**Probably** works with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.941 green:.765 blue:.188 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    		[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    		[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
                [[cell textLabel] setText:@"Does not work with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.894 green:.302 blue:.259 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
		    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else {
				[[cell textLabel] setText:@"Unknown compatibility/No reports"];
				[[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	   		 	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
			}
        } else {
            [[cell textLabel] setText:@"Unknown compatibility/No reports"];
            [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
			UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
			UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
			[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
			[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
			[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    	[buttonsStackView addArrangedSubview:viewReportsButton];
			[buttonsStackView addArrangedSubview:addReportButton];
	
			[cell setAccessoryView:buttonsStackView];
			return cell;
        }
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
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
    NSString *packageID = [infoDict objectForKey:@"packageID"];
	NSString *versionString = [infoDict objectForKey:@"Version"];
	NSString *summary = [[NSString alloc] init];
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
    if ([[all_packages allKeys] containsObject:packageID] ) {
        NSDictionary *compatibilityInfo = [NSJSONSerialization JSONObjectWithData:[all_packages objectForKey:packageID] options:0 error:NULL];
        NSArray *allVersions = [compatibilityInfo objectForKey:@"versions"];
		NSDictionary *outcomeDict;
        for (NSDictionary *versionInfo in allVersions){
            if ([[versionInfo objectForKey:@"tweakVersion"] isEqualToString:[compatibilityInfo objectForKey:@"latest"]]) {
                if (sizeof(void*) == 4) {
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[[versionInfo objectForKey:@"outcome"] objectForKey:@"arch32"]];
                } else  {
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[versionInfo objectForKey:@"outcome"]];
                }
            }
        }
		if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
            summary = [NSString stringWithFormat:@"%@ version %@ is marked as %@ on iOS %@\n\n(%@ reports, %@ working and %@ non-working)", [infoDict objectForKey:@"packageID"], versionString, [outcomeDict objectForKey:@"calculatedStatus"], [[UIDevice currentDevice] systemVersion], [outcomeDict objectForKey:@"total"], [outcomeDict objectForKey:@"good"], [outcomeDict objectForKey:@"bad"]];
        } else {
			summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
		}
    } else {
		summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
    }
	UIAlertController *compatibilityAlert = [UIAlertController alertControllerWithTitle:@"Compatibility Report" message:summary preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *viewAllReportsAction = [UIAlertAction actionWithTitle:@"View all reports" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [infoDict objectForKey:@"packageID"], versionString]];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
    }];
    [compatibilityAlert addAction:viewAllReportsAction];
    [compatibilityAlert addAction:dismissAction];
    [[self parentVC] presentViewController:compatibilityAlert animated:TRUE completion:nil];
}

%new
-(void)tappedOnAddReport{
	
}

%end