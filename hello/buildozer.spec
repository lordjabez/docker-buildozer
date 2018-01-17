[app]

title = Hello
package.name = hello
package.domain = com.example

source.dir = .
source.include_exts = py

version.regex = __version__ = '(.*)'
version.filename = %(source.dir)s/main.py

requirements = kivy

android.api = 19
android.minapi = 9
android.sdk = 21
android.ndk = 9c


[buildozer]
