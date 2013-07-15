
/*

 CreateMethodsJSON by Amnon Owed (July 2013)
 https://github.com/AmnonOwed
 http://vimeo.com/amnon

 Utility sketch that saves the network API's specific methods and parameters in a valid JSON file.
 It retreives these methods from the API's online documentation.
 Since these are (unfortunately) stored in HTML format, a Java HTML Parser called jsoup is used.

 USAGE:
 1. Copy-paste the relevant URL into the sketch.
 2. Run once.
 3. The JSON file is saved to the data folder.
 
 Built with Processing 2.0.1

 Dependencies: jsoup 1.7.2
 jsoup is a Java library for working with real-world HTML and it can be downloaded here: http://jsoup.org/download

*/

import org.jsoup.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;

import java.util.*;

final String urlFullVimeo = "http://developer.vimeo.com/apis/advanced/methods/";
final String urlFullTwitter = "https://dev.twitter.com/docs/api/1.1/";

boolean bDebug = false; // toggle debug mode to get console feedback

void setup() {
//  Api api = new ApiTwitter(urlFullTwitter);
  Api api = new ApiVimeo(urlFullVimeo);
  api.retrieve();
  api.save();
  exit();
}

