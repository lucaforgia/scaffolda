# scaffolda
 Very simple command line app for scaffolding project, written in haxe.

This app doesn't aim to compete with more mature and complex apps like maven, but to be a simple and independent (no nodejs, no java) app to start a new project, whatever the programming language.
Written in haxe, it's platform free and language free. The app doesn't run scrips or compile stuff. It just builds the structure directory you want with the files you want.

You can provide the xml template. Or provide an url to get it. Or just write the name of a template in the "official" repo (https://github.com/lucaforgia/scaffolda-templates). Send me an email to add a template on the repo.

It accepts only ONE parameter, and as said it can be the file name of the template, an url, or the name of the template from the repo.

Example (assuming you have the scaffolda command setted):

	scaffolda my_local_template_file.xml
	
or

	scaffolda http://some_url/template_file.xml
	
or

	scaffolda scaffolda_example
	
In the last example, the app will get the scaffolda_exemple.xml template from the repo:

https://github.com/lucaforgia/scaffolda-templates
