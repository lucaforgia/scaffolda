class Main {
  public static inline var templatesRepoUrl = "https://raw.githubusercontent.com/lucaforgia/scaffolda-templates/master/templates/";
  public static inline var environment = "";

  static public function main():Void{

    var args = Sys.args();
    var firstArg = args[0];

    if(firstArg == null){
      showHelp();
    }
    else{
      switch firstArg {
        case "-h", "--help": showHelp();
        case "--example", "-e": Utils.getTemplateExample();
        default: createProject(firstArg);
      }
    }
  }


  private static function createProject(fileName:String) {
    try{
      Utils.getTemplateFile(fileName, function (fileContent:String){
        Utils.parseTemplate(fileContent);
      });
    }catch(msg:String){
      Sys.println(msg);
    }

  }

  private static function showHelp() {
    Sys.println('
    Scaffolda is a command line tool to create empty projects (scaffolding) from a provided template.

    usage: scaffolda <file_name_url_or_option>

    <file_name_url_or_option> can be a local file, an http-url, or the name of a template from 
    the official repository (${Main.templatesRepoUrl})

    options:
      -e, --example,  add a template file example (scaffolda_example.xml) in the current location
      -h, --help      show the help

    How it works.
    The app check if <file_name_url_or_option> is a file in the current location, to use as template.
    If not, the app checks if <file_name_url_or_option> contains /http/, and in this case it will try to 
    download and then use the file as template.
    If not, the app will fallback to check if the file with name <file_name_url_or_option> is present on 
    the official repository.
    If none of these work... good luck.
        ');
  }

}