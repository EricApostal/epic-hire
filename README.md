# Epic Hire Android Implementation
Implementation of the Epic Hire app for android, written in Flutter.

![README Banner Art](<Frame 1(2).png>)

## Technical Notes
- Some of the wrapper logic was recycled from a fork of the Nyxx library I made for another side project, so there's some leftover code from there. This is kept because there's some features that Epic Hire could implement (like ratelimiting), that could be handled. It's not changing the behavior of the program by being here because there's no implementation on the server side.

- Logins not saving is an easy fix, I just haven't implemented a UI for logging out so it's kept that way for testing.

- It may error if you try to login with your account because the only cases I've been able to test is with my own account.

- The `fetch` methods aren't implemented on most of the http managers; this is because the Epic Hire API usually over-sends data so they aren't often needed, but I'll implement them as they come up.