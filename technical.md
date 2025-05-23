# My notesheet.
I was originally doing this on a seperate document, however this may be important for others to understand my thought process.

## Current concerns.
I'm double caching. I have the cache handler with `.get`, as well as the riverpod provider. Refreshing the riverpod driver won't exactly force a refresh of the content. You can get around this with `.fetch` instead of using `.get` in the providers, which works fine. We still need caching because the `wrapper` library doesn't have any concept of riverpod internally.

There's a lot of managers that don't implement fetch and indexing (a requirement due to their inheritance). I should make sure that I am using those manager types correctly, and implement them properly.

The `Identified` objects are super dumb. Every day I think that we just need to go back down to an `int` and completely rid of identified. This structure should return if we were to use snowflakes.

The way theming works is kinda dumb. There is Theme.of(context), and EpicHireTheme.of(context), and both are needed (Theme for TextTheme, EpicHireTheme for colors). I should find a better way of doing that.

For the `Manager`s in the `Wrapper` library, I think I want to make any entity that's fetchable a manager. Right now I have quite a few objects associated with others that should be fetchable on their own, but are not. (ie: in Discord you'd have a channel manager which fetches a list of messages, then message manager which handles each independently). For the sake of Talos, a good start to this would probably be a `ConversationMember`. Are they fetchable independently? How does it inherit? Etc. Just something to look out for to avoid spaghetti.