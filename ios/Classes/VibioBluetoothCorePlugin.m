#import "VibioBluetoothCorePlugin.h"
#if __has_include(<vibio_bluetooth_core/vibio_bluetooth_core-Swift.h>)
#import <vibio_bluetooth_core/vibio_bluetooth_core-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vibio_bluetooth_core-Swift.h"
#endif

@implementation VibioBluetoothCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVibioBluetoothCorePlugin registerWithRegistrar:registrar];
}
@end
