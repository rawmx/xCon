@interface DTVApplicationBase : NSObject {}
-(BOOL)isDeviceJailbroken;
@end

@interface ApplicationSettings : NSObject {}
@property(assign, nonatomic) BOOL optionJailbreakCheckEnabled;
@end