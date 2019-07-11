<h1 align="center">Scribble 4.7.3</h1>

### @jujuadams

Vertex buffer-based text engine. Faster and more comprehensive than GameMaker native rendering. Shader-based processing allows for efficient and flexible dynamic effects without lots of draw_text() calls.

With thanks to glitchroy, Mark Turner, DragoniteSpam, sp202, and Rob van Saaze for testing.

&nbsp;

**How do I import Scribble into my game?**

GameMaker Studio 2.2.3 allows you to import assets, including scripts and shaders, directly into your project via the "Local Package" system. From the [Releases](https://github.com/JujuAdams/scribble/releases) tab for this repo, download the .yymp file for the latest version. In the GMS2 IDE, load up your project and click on "Tools" on the main window toolbar. Select "Import Local Package" from the drop-down menu then import all scripts and shaders from the Scribble package. Now you're all set up!

&nbsp;

**How do I set up Scribble?**

Scribble is made from 8 mandatory scripts and a shader. There are 12 optional scripts that unlock more advanced functionality, though they're not needed for basic use.

Scribble requires that you define fonts specifically for use with Scribble. This is a three-step process:

1) Add a typical GameMaker font resource through the IDE
2) Add the font's .yy file as an Included File (found in the font's folder in the project directory)
3) Add some code that instructs Scribble to use the font.

Let's take this step by step. You're hopefully already familiar with adding resources to the GameMaker IDE.

Scribble needs to access information that GameMaker generates. All this information is contained in a single .yy file in the font's folder on disk inside the project directory. This file can sometimes be frustrating to locate, but fortunately there's a shortcut we can take. In the IDE, Navigate to the font resource you wish to add and right click on it. From the drop-down menu, select "Show In Explorer". A window will open showing various files for the font resource. You can drag-and-drop the .yy file into the GameMaker IDE to add it as an Included File.

***Please note** that if you change any font properties then the associated .yy file in Included Files will need to be updated too. This is the number one cause of rendering glitches.*

Finally, we need to add some code that tells Scribble how to initialise the font. This is done through a trio of functions: scfibble_init_start(), scribble_init_add_font(), scribble_init_end(). All font definitions must be executed after scribble_init_start() and before scribble_init_end(). Scribble can only be initialised once which means all Scribble fonts should be defined at the same time.

e.g.
```
//Start initialisation:
//  The font directory is set as the root of the sandbox
//  The default font is set as "fnt_dialogue"
//  Automatic scanning for fonts ("autoscan") is turned off
scribble_init_begin("", “fnt_dialogue”, false);

//Add the font called "fnt_dialogue" to Scribble
scribble_init_add_font("fnt_dialogue");`

//Finish initialisation
scribble_init_end();
```

&nbsp;

**How do I use spritefonts?**

Spritefonts work similarly to standard fonts and they are functionally interchangeable when drawing text. They do, however, have some key differences during setup:

1) Spritefonts use a sprite asset rather than a font asset
2) Sprite fonts do not require a .yy file to be added as an included file
3) Use scribble_init_add_spritefont() instead of scribble_init_add_font()

***Please note** that a sprite used for a spritefont must have its collision type set to "Precise Per Frame"*

Here is an example of the code required to initialise a spritefont in Scribble:

```
//Start initialisation:
//  The font directory is set as the root of the sandbox
//  The default font is set as "fnt_score"
//  Automatic scanning for fonts ("autoscan") is turned off
scribble_init_begin("", “fnt_score”, false);

//Add the spritefont called "fnt_dialogue" to Scribble
scribble_init_add_spritefont("fnt_score");`

//Finish initialisation
scribble_init_end();
```
