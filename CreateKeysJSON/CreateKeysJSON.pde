
/*

 CreateKeysJSON by Amnon Owed (July 2013)
 https://github.com/AmnonOwed
 http://vimeo.com/amnon

 Utility sketch that saves the following data into a valid JSON file: 
 - The 4 required OAUTH authentication strings.
 - The name of the social network the keys apply to.

 This is useful because:
 - You can store the keys in a single file in a central location on your computer, instead of in each sketch individually.
 - When you upload sketches to github they don't accidently contain secret keys! ;-)

 USAGE:
 1. Copy-paste the data into the sketch.
 2. Run once.
 3. The JSON file is saved to the data folder.
 
 Built with Processing 2.0.1

*/

// Insert your network & keys here!
final String NETWORK = "";
final String CONSUMER_KEY = "";
final String CONSUMER_SECRET = "";
final String ACCESS_TOKEN = "";
final String ACCESS_TOKEN_SECRET = "";

// create the JSON object
JSONObject json = new JSONObject();
json.setString("NETWORK", NETWORK);
json.setString("CONSUMER_KEY", CONSUMER_KEY);
json.setString("CONSUMER_SECRET", CONSUMER_SECRET);
json.setString("ACCESS_TOKEN", ACCESS_TOKEN);
json.setString("ACCESS_TOKEN_SECRET", ACCESS_TOKEN_SECRET);

// saves the JSON object
saveJSONObject(json,"data/" + NETWORK + "-keys.json");

// ends the sketch
println(NETWORK + "-keys.json saved to data folder.");
exit();

