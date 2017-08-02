package model.types;

@:enum
abstract OperationsEnum(String) to String from String {
    var PLUS = "+";
    var MINUS = "-";
    var DIVIDE = "÷";
    var MULTIPLY = "x";
}
