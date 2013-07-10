Network Visualization
================

The three creative social networks I am active on are [Tumblr](http://artandcode.tumblr.com/),
[Twitter](https://twitter.com/AmnonOwed) and [Vimeo](http://vimeo.com/amnon).
I want to gain insight in my own social networks (friends & followers) and also download the images from my own Tumblr-blog.
Indeed, this is more an exercise in "ego data" than it is in "big data"! ;-)
Many social networks nowadays - including these three - have public API's that allow you to get direct access to their / my data.

All of these three networks authenticate requests through [OAUth](http://oauth.net/).
Although Tumblr also allows some requests via a key alone.
I have chosen to use the [Scribe OAuth library](https://github.com/fernandezpablo85/scribe-java) for Java.
There are network-specific options ([Twitter4j](http://twitter4j.org/en/index.html), [Jumblr](https://github.com/tumblr/jumblr)),
but I'd rather learn one library that can be applied to all situations instead of three different code bases.
Even if this requires some more manual tweaking, it also bundles my experience and learning effort.
And it gives complete and intricate control. Plus it might come in handy when I need OAuth for some other network in the future.

In addition, all of these three networks return data in the [JSON](http://www.json.org/) response format.
It's a bit like XML. Very clear for computers, but also human-readable.
This format is supported in the data package of Processing 2.0, so it can be used without additional libraries.

This uniformity in authentication and response format allows me to solve problems once and apply the solutions to multiple cases.
Even though there are of course always particularities between the different socials networks.

The code in this repository will focus on the following things:

- Authentication through OAuth
- Sending API requests
- Caching data locally in JSON files
- Visualizing the data
- Assorted utility sketches

Code is work-in-progress, no warranties, no guarantees, shared in the spirit of open source.

Code written in Processing 2.0.1

####CreateKeysJSON
Small utility sketch that saves the 4 required authentication strings and the network name in a JSON file.
