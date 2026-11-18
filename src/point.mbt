///|
type Point FixedArray[UInt]

///|
pub impl Show for Point with fn output(self : Point, logger : &@builtin.Logger) -> Unit {
  logger.write_string("(")
  logger.write_string(self.row().to_string())
  logger.write_string(", ")
  logger.write_string(self.column().to_string())
  logger.write_string(")")
}

///|
fn Point::_new(row : UInt32, column : UInt32) -> Point {
  [row, column]
}

///|
pub fn Point::new(row : Int32, column : Int32) -> Point {
  Point::_new(int_to_uint(row), int_to_uint(column))
}

///|
fn Point::_row(self : Point) -> UInt32 {
  self._[0]
}

///|
pub fn Point::row(self : Point) -> Int32 {
  uint_to_int(self._row())
}

///|
fn Point::_column(self : Point) -> UInt32 {
  self._[1]
}

///|
pub fn Point::column(self : Point) -> Int32 {
  uint_to_int(self._column())
}
