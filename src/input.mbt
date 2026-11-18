///|
struct Input[DecodeFunction] {
  read : (UInt32, Point) -> Bytes
  decode : DecodeFunction
}

///|
pub fn Input::new[DecodeFunction](
  read : (Int, Point) -> Bytes,
  decode : DecodeFunction
) -> Input[DecodeFunction] {
  {
    read: fn(byte, point) {
      let byte = uint_to_int(byte)
      read(byte, point)
    },
    decode,
  }
}

///|
type InputEdit FixedArray[UInt]

///|
fn InputEdit::_new(
  start_byte : UInt32,
  old_end_byte : UInt32,
  new_end_byte : UInt32,
  start_point : Point,
  old_end_point : Point,
  new_end_point : Point,
) -> InputEdit {
  [
    start_byte,
    old_end_byte,
    new_end_byte,
    start_point._row(),
    start_point._column(),
    old_end_point._row(),
    old_end_point._column(),
    new_end_point._row(),
    new_end_point._column(),
  ]
}

///|
pub fn InputEdit::new(
  start_byte~ : Int32,
  old_end_byte~ : Int32,
  new_end_byte~ : Int32,
  start_point~ : Point,
  old_end_point~ : Point,
  new_end_point~ : Point,
) -> InputEdit {
  let start_byte = int_to_uint(start_byte)
  let old_end_byte = int_to_uint(old_end_byte)
  let new_end_byte = int_to_uint(new_end_byte)
  InputEdit::_new(
    start_byte, old_end_byte, new_end_byte, start_point, old_end_point, new_end_point,
  )
}

///|
pub(all) struct DecodeResult {
  code_point : Int32
  bytes_read : Int32
}

///|
/// This function signature reads one code point from the given bytes,
/// returning the number of bytes consumed and the code point
/// to the `code_point` pointer. If the input is valid, return `None`.
pub(open) trait DecodeFunction {
  fn input_encoding(Self) -> InputEncoding
  fn decode(Bytes) -> DecodeResult?
}

///|
impl DecodeFunction with fn input_encoding(self) -> InputEncoding {
  ignore(self)
  Custom
}

///|
pub(all) enum InputEncoding {
  UTF8
  UTF16LE
  UTF16BE
  Custom
}

///|
impl DecodeFunction for InputEncoding with fn input_encoding(self) -> InputEncoding {
  self
}

///|
impl DecodeFunction for InputEncoding with fn decode(bytes) -> DecodeResult? {
  ignore(bytes)
  None
}

///|
fn InputEncoding::to_uint(self : InputEncoding) -> UInt32 {
  match self {
    UTF8 => 0
    UTF16LE => 1
    UTF16BE => 2
    Custom => 3
  }
}
