// ios/AudioPro.mm

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface AudioPro : RCTEventEmitter <RCTBridgeModule>
@end

@implementation AudioPro

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[
    @"BUFFERING",
    @"PLAYING",
    @"PAUSED",
    @"FINISHED",
    @"ERROR",
    @"REMOTE_SEEK",
    @"REMOTE_SKIP_NEXT",
    @"REMOTE_SKIP_PREVIOUS",
    @"PROGRESS"
  ];
}

RCT_EXPORT_METHOD(load:(NSDictionary *)mediaFile
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSString *url = mediaFile[@"url"];
  NSString *title = mediaFile[@"title"];
  NSString *artist = mediaFile[@"artist"];
  NSString *artwork = mediaFile[@"artwork"];

  if (url == nil || title == nil || artist == nil || artwork == nil) {
    reject(@"E_MISSING_PARAMS", @"Missing required parameters", nil);
    return;
  }

  NSLog(@"[AudioPro] Loading media file: %@", mediaFile);
  [self sendEventWithName:@"BUFFERING" body:@{ @"message": @"Loading audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(play:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Playing audio");
  [self sendEventWithName:@"PLAYING" body:@{ @"message": @"Playing audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(pause:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Pausing audio");
  [self sendEventWithName:@"PAUSED" body:@{ @"message": @"Pausing audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(stop:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Stopping audio");
  [self sendEventWithName:@"FINISHED" body:@{ @"message": @"Stopping audio and releasing resources" }];
  resolve(@YES);
}

@end
