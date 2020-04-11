import haxe.Http;
import sys.FileSystem;
import sys.io.File;

class Utils{

  public static function getTemplateExample() {
    File.saveContent('./scaffolda_example.xml', haxe.Resource.getString("template_example"));
    Sys.println("scaffolda_example.xml created");
  }

  public static function getTemplateFile(fileNameOrUrl:String, callback:String->Void){
    var fileContent:String = "";

    if(FileSystem.exists(fileNameOrUrl)){
      fileContent = File.getContent(fileNameOrUrl);
      callback(fileContent);
    }
    else{
      Sys.println('### No file in ${FileSystem.absolutePath(fileNameOrUrl)}.');
      var url:String = "";
      if(fileNameOrUrl.indexOf("http") == 0){
        Sys.println('### File name containing http. Searching online the template on url ${fileNameOrUrl}');
        url = fileNameOrUrl;
      }
      else{
        var fileExtension = fileNameOrUrl.indexOf(".xml") == -1 ? ".xml" : "";
        url = Main.templatesRepoUrl + fileNameOrUrl + fileExtension;
        Sys.println('### Provided template name. Searching template on official repository');
      }

      var req = new Http(url);

      req.onData = function(response:String) {  
        callback(response);
      };
      req.onError = function (msg:String){
        throw "### Error on call " + url + " -> " + msg;
      };
      req.request( false ); 
    }
  }

  private static function buildStructure(buildPath:String, xmlElement:Xml) {

    var children = xmlElement.elements();

    for(element in children){
      var currentNodeName = element.nodeName;
      var filePath = haxe.io.Path.join([buildPath, element.get("name")]);
      
      if(currentNodeName == "file"){
        if(FileSystem.exists(filePath)){
          Sys.println('${filePath} already exist, skip creation');
        }
        else{
          File.saveContent(filePath, element.firstChild().nodeValue);
        }
      }
      else if(currentNodeName == "dir"){
        FileSystem.createDirectory(filePath);
        buildStructure(filePath, element);
      }
    }
  }

  public static function parseTemplate(fileContent: String) {
    var buildPath = FileSystem.fullPath(Main.environment == "dev" ?  "./build" : ".");
    var xmlTemplate = Xml.parse(fileContent);
    // var access = new haxe.xml.Access(xmlTemplate.firstElement());
    var rootElement = xmlTemplate.firstElement();

    if(rootElement.nodeName != "scaffolda-template"){
      throw "### Error: the xml provided is not a Scaffolda template, the root element is not scaffolda-template but " + rootElement.nodeName;
    }
    buildStructure(buildPath, rootElement.elementsNamed('direrctory-structure').next());
    Sys.println("### Scaffolda: done!");
  }

}