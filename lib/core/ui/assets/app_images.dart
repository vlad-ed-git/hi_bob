/// Defines all asset images used in the app
enum AppImages {
  appLogoGreenBg('assets/images/app_logo_green_bg.png'),
  mascotHappy('assets/images/mascot_happy.png'),
  mascotCry('assets/images/mascot_cry.png'),
  mascotResult('assets/images/mascot_result.png'),
  mascotTeach('assets/images/mascot_teach.png');

  const AppImages(this.assetPath);

  final String assetPath;
}
