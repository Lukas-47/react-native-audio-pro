// ios/AudioPro.mm

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

typedef NS_ENUM(NSInteger, AudioProEvent) {
    AudioProEventBuffering,
    AudioProEventPlaying,
    AudioProEventPaused,
    AudioProEventFinished,
    AudioProEventError,
    AudioProEventRemoteSeek,
    AudioProEventRemoteSkipNext,
    AudioProEventRemoteSkipPrevious,
    AudioProEventProgress
};

NSString *AudioProEventName(AudioProEvent event) {
    switch (event) {
        case AudioProEventBuffering: return @"BUFFERING";
        case AudioProEventPlaying: return @"PLAYING";
        case AudioProEventPaused: return @"PAUSED";
        case AudioProEventFinished: return @"FINISHED";
        case AudioProEventError: return @"ERROR";
        case AudioProEventRemoteSeek: return @"REMOTE_SEEK";
        case AudioProEventRemoteSkipNext: return @"REMOTE_SKIP_NEXT";
        case AudioProEventRemoteSkipPrevious: return @"REMOTE_SKIP_PREVIOUS";
        case AudioProEventProgress: return @"PROGRESS";
    }
}

@interface AudioPro : RCTEventEmitter <RCTBridgeModule>
@end

@implementation AudioPro

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
  return @[
    AudioProEventName(AudioProEventBuffering),
    AudioProEventName(AudioProEventPlaying),
    AudioProEventName(AudioProEventPaused),
    AudioProEventName(AudioProEventFinished),
    AudioProEventName(AudioProEventError),
    AudioProEventName(AudioProEventRemoteSeek),
    AudioProEventName(AudioProEventRemoteSkipNext),
    AudioProEventName(AudioProEventRemoteSkipPrevious),
    AudioProEventName(AudioProEventProgress)
  ];
}

- (void)sendEventWithType:(AudioProEvent)eventType andBody:(NSDictionary *)body {
    [self sendEventWithName:AudioProEventName(eventType) body:body];
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
  [self sendEventWithType:AudioProEventBuffering andBody:@{ @"message": @"Loading audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(play:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Playing audio");
  [self sendEventWithType:AudioProEventPlaying andBody:@{ @"message": @"Playing audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(pause:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Pausing audio");
  [self sendEventWithType:AudioProEventPaused andBody:@{ @"message": @"Pausing audio" }];
  resolve(@YES);
}

RCT_EXPORT_METHOD(stop:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"[AudioPro] Stopping audio");
  [self sendEventWithType:AudioProEventFinished andBody:@{ @"message": @"Stopping audio and releasing resources" }];
  resolve(@YES);
}

@end
