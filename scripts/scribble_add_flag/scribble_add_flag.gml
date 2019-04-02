/// Defines a flag name, allowing for behaviours to be set per-character when calling scribble_create()
///
///
///
/// @param name    Event name, as a string
/// @param index   Integer flag index, from 1 to SCRIBBLE_MAX_FLAGS-1 inclusive

var _name  = argument0;
var _index = argument1;

if ( !variable_global_exists("__scribble_init_complete") )
{
    show_error("Scribble:\n\nscribble_add_custom_flag_name() should be called after initialising Scribble.\n ", false);
    exit;
}

if ( !is_string(_name) )
{
    show_error("Scribble:\n\nCustom flag names should be strings.\n ", false);
    exit;
}

if (!is_real(_index) || (_index != floor(_index)) || (_index < 1) || (_index > (SCRIBBLE_MAX_FLAGS-1)))
{
    show_error("Scribble:\n\nCustom flag indexes should be an integer from 1 to " + string(SCRIBBLE_MAX_FLAGS-1) + " (inclusive).\nTo increase the maximum number of flags, see __scribble_config()\n(Index was \"" + string(_index) + "\")\n ", false);
    exit;
}

var _old_name = global.__scribble_flags[? _index ];
if (_old_name != undefined)
{
    show_debug_message("Scribble: WARNING! Overwriting flag index " + string(_index) + " \"" + _old_name + "\"");
    ds_map_delete(global.__scribble_flags, _old_name);
}

//Bidrectional lookup in the same map made possible because the datatypes are different
global.__scribble_flags[? _index ] = _name;
global.__scribble_flags[? _name  ] = _index;

show_debug_message("Scribble: Added flag name \"" + _name + "\" as index " + string(_index));