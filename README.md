# SkipFuse

SkipFuse helps fuse the Swift and Android worlds for [native Skip](https://skip.tools/docs/modes/#native) modules and apps. It is an umbrella framework that vends cross-platform functionality. For example, SkipFuse:

- Vends OSLog APIs on Android so that your OSLog messages appear in Android's Logcat logging.
- Magically integrates your Swift `@Observables` into Jetpack Compose, so that they can transparently power Compose UI.
- Includes the `AnyDynamicObject` type for invoking Kotlin/Java API from compiled Swift with zero setup.

Skip will be enhancing SkipFuse over time to integrate many additional Swift foundational APIs with Android.

See the Skip [documentation](https://skip.tools/docs/) for details.




## License

This software is licensed under the
[GNU Lesser General Public License v3.0](https://spdx.org/licenses/LGPL-3.0-only.html),
with the following
[linking exception](https://spdx.org/licenses/LGPL-3.0-linking-exception.html)
to clarify that distribution to restricted envrionments (e.g., app stores)
is permitted:

> This software is licensed under the LGPL3, included below.
> As a special exception to the GNU Lesser General Public License version 3
> ("LGPL3"), the copyright holders of this Library give you permission to
> convey to a third party a Combined Work that links statically or dynamically
> to this Library without providing any Minimal Corresponding Source or
> Minimal Application Code as set out in 4d or providing the installation
> information set out in section 4e, provided that you comply with the other
> provisions of LGPL3 and provided that you meet, for the Application the
> terms and conditions of the license(s) which apply to the Application.
> Except as stated in this special exception, the provisions of LGPL3 will
> continue to comply in full to this Library. If you modify this Library, you
> may apply this exception to your version of this Library, but you are not
> obliged to do so. If you do not wish to do so, delete this exception
> statement from your version. This exception does not (and cannot) modify any
> license terms which apply to the Application, with which you must still
> comply.

