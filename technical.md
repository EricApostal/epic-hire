# My notesheet.
I was originally doing this on a seperate document, however this may be important for others to understand my thought process.

## Current concerns.
I'm double caching. I have the cache handler with `.get`, as well as the riverpod provider. Refreshing the riverpod driver won't exactly force a refresh of the content. You can get around this with `.fetch` instead of using `.get` in the providers, which works fine. We still need caching because the `wrapper` library doesn't have any concept of riverpod internally.

There's a lot of managers that don't implement fetch and indexing (a requirement due to their inheritance). I should make sure that I am using those manager types correctly, and implement them properly.

The `Identified` objects are super dumb. Every day I think that we just need to go back down to an `int` and completely rid of identified. This structure should return if we were to use snowflakes.