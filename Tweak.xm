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
						return cell;
                    } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"]) {
                        [[cell textLabel] setText:@"Probably works with your device (not 100% sure!)"];
                        [[cell textLabel] setTextColor:[UIColor colorWithRed:.941 green:.765 blue:.188 alpha:1.0]];
                        [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
                    } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
                        [[cell textLabel] setText:@"Does not work with your device"];
                        [[cell textLabel] setTextColor:[UIColor colorWithRed:.894 green:.302 blue:.259 alpha:1.0]];
                        [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
                    } else {
						[[cell textLabel] setText:@"Unknown compatibility/No reports"];
            			[[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
					}
        } else {
            [[cell textLabel] setText:@"Unknown compatibility/No reports"];
            [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
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
	NSMutableDictionary *packageInfo = MSHookIvar<NSMutableDictionary *>(self, "infos");
	NSString *versionString = [packageInfo objectForKey:@"Version"];
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [packageInfo objectForKey:@"packageID"], versionString]];
	SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
	[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
}

%new
-(void)tappedOnAddReport{
	
}

%end