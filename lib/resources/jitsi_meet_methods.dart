import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:fluent_fusion/resources/auth_methods.dart';
import 'package:fluent_fusion/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      // FeatureFlag featureFlag = featureFlag();
      // featureFlag.welcomePageEnabled = false;
      // featureFlag.resolution = FeatureFlagVideoResolution
      //     .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetConferenceOptions(
          serverURL: "https://meet.jit.si",
          room: "jitsiIsAwesomeWithFlutter",
          configOverrides: {
            "startWithAudioMuted": false,
            "startWithVideoMuted": false,
            "subject" : "Jitsi with Flutter",
          },
        featureFlags: {
          "unsaferoomwarning.enabled": false
        },
        userInfo: JitsiMeetUserInfo(
            displayName: "Flutter user",
            email: "user@example.com"
        ),
      );
      _firestoreMethods.addToMeetingHistory(roomName);
      var jitsiMeet = JitsiMeet();
      await jitsiMeet.join(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
