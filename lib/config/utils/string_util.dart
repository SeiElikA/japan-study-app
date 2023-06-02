extension ExtensionString on String {
  String replaceException() {
    return replaceAll("Exception: ", "");
  }
}