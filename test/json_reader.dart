import 'dart:io';

String mockJsonAsString(String jsonPathFromTest) =>
    File('test/$jsonPathFromTest').readAsStringSync();
