/// @param string
/// @param [returnString=true]

function scr_stringSha512(_string, _return_string = true)
{
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    return scr_bufferSha512(_buffer, undefined, undefined, true, _return_string);
}