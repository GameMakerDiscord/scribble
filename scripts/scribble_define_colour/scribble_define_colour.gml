/// Adds a custom colour for use as an in-line colour definition for scribble_create_static() 
///
/// This script allows for the definition of a custom colour that can be referenced by name in scribble_create_static()
/// This script assumes you're *NOT* using GameMaker's wacky BGR colour format.
///
/// @param name                     String name of the colour
/// @param colour                   The colour itself as a 24-bit integer
/// @param [colourIsGameMakerBGR]   Whether the colour is a native GM colour value. Defaults to <false>
///
/// All optional arguments accept <undefined> to indicate that the default value should be used.

var _name   = argument[0];
var _colour = argument[1];
var _native = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : false;

if (variable_global_get("__scribble_global_count") == undefined)
{
    show_error("Scribble:\nscribble_define_colour() should be called after initialising Scribble.\n ", false);
    exit;
}

if (!is_string(_name))
{
    show_error("Scribble:\nCustom colour names should be strings.\n ", false);
    exit;
}

if (!is_real(_colour))
{
    show_error("Scribble:\nCustom colours should be specificed as 24-bit integers.\n ", false);
    exit;
}

if (!_native)
{
    _colour = make_colour_rgb(colour_get_blue(_colour), colour_get_green(_colour), colour_get_red(_colour));
}

if (ds_map_exists(global.__scribble_events, _name))
{
    show_debug_message("Scribble: WARNING! Colour name \"" + _name + "\" has already been defined as an event");
    exit;
}

if (ds_map_exists(global.__scribble_flags, _name))
{
    show_debug_message("Scribble: WARNING! Colour name \"" + _name + "\" has already been defined as a flag");
    exit;
}

var _old_colour = global.__scribble_colours[? _name];
if (is_real(_old_colour))
{
    show_debug_message("Scribble: WARNING! Overwriting colour \"" + _name + "\" (" + string(colour_get_red(_old_colour)) + "," + string(colour_get_green(_old_colour)) + "," + string(colour_get_blue(_old_colour)) + ", u32=" + string(_old_colour) + ")");
}

global.__scribble_colours[? _name] = $ff000000 | _colour; //Include alpha (at 100%) to make things a bit faster in scribble_create_static()

if (SCRIBBLE_VERBOSE) show_debug_message("Scribble: Added colour \"" + _name + "\" as " + string(colour_get_red(_colour)) + "," + string(colour_get_green(_colour)) + "," + string(colour_get_blue(_colour)) + ", u32=" + string(_colour));