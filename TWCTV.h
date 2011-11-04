@interface XXUnknownSuperclass
@end

@interface XXUnknownSuperclass (SecurityHelper)
-(BOOL)isJailbroken;
@end

@interface TWCCustomMessages : NSObject {}
@property(retain, nonatomic) NSString* jailbroken_device_not_allowed;
@end

@interface TWCTVAppDelegate : NSObject {}
-(void)handleJailbrokenDevice;
@end