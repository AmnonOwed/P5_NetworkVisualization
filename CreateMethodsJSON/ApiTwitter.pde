
class ApiTwitter extends Api {

  ApiTwitter(String urlFull, String urlBase, String urlHook) {
    super(urlFull, urlBase, urlHook);
  }

  ApiTwitter(String urlFull) {
    super(urlFull);
  }

  @Override
  JSONObject getMethod(String methodUrl) {
    JSONObject method = null;
  
    Document doc = getPage(methodUrl);
    
    if (doc != null) {
      if (bDebug) { println("Title: " + doc.title() + "\n"); }
      method = new JSONObject();
  
      String methodName = doc.select("h1").first().html();
      if (bDebug) { println("Method Name: " + methodName); }
      method.setString("Name", methodName);

      String methodDescription = doc.select("p").first().html();
      methodDescription = methodDescription.replace("<tt>", "");
      methodDescription = methodDescription.replace("</tt>", "");
      if (bDebug) { println("Method Description: " + methodDescription); }
      method.setString("Description", methodDescription);
  
      if (bDebug) { println("Method Documentation: " + methodUrl); }
      method.setString("Documentation", methodUrl);

      String endpoint = doc.select("h2 ~ div.odd").first().html();
      if (bDebug) { println("Method Endpoint: " + endpoint); }
      method.setString("Endpoint", endpoint);
  
      JSONArray parameters = new JSONArray();

      if (bDebug) { println(); }
  
      Elements parameterTable = doc.select("div.parameter");
      for (Element parameterElement : parameterTable) {
        JSONObject parameter = new JSONObject();

        Element param = parameterElement.select("span.param").first();
        String name = param.ownText();
        if (bDebug) { println("Parameter Name: " + name); }
        parameter.setString("Name", name);

        String description = parameterElement.select("p").first().html();
        description = description.replace("<tt>", "");
        description = description.replace("</tt>", "");
        if (bDebug) { println("Parameter Description: " + description); }
        parameter.setString("Description", description);

        boolean required = param.html().contains("required");
        if (bDebug) { println("Parameter Required: " + required + "\n"); }
        parameter.setBoolean("Required", true);

        parameters.append(parameter);
      }
      method.setJSONArray("Parameters", parameters);
    }
    return method;
  }

  @Override
  String getName() {
    return "Twitter";
  }
}

