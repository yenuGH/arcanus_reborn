
# arcanus reborn

An app made for managing your anime and manga lists, with the functionality to search for new ones - all built in Flutter. Made for Android and iOS devices.
This app uses AniList's public API v2. It grabs and stores (locally, so none of your data leaves your device) your account's authentication token (which you must manually grab on Android, not on iOS) using Hive.
It then uses that authentication token to make authorized requests to the AnilList API with graphql_flutter's client, querying and mutating account data as you see fit.

This was a personal project aimed towards learning the Dart programming language along with the Flutter SDK, meaning it most likely won't be maintained after version 1.0 is released.

Pending approval from the Google Play Store.


![Logo](https://b.catgirlsare.sexy/LNVHn2VGZZD_.png)


## Installation

You can install the demo-release build via Android Studio or VS Code (both with the Dart/Flutter extensions), after installing the Flutter SDK and adding it to PATH. Once that's done, run the following commands within the root directory of the project:

```bash
  flutter pub get
  flutter run
```

Or you can head over to the [latest release](https://github.com/yenuGH/arcanus_reborn/releases/tag/v1.0.0) and download the Android APK from there directly.
    
## License

[MIT License](https://choosealicense.com/licenses/mit/)
```
MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

