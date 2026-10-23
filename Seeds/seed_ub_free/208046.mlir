module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<127> : tensor<9x9x5xi16>}> : () -> tensor<9x9x5xi16>
    %1 = "tosa.const"() <{values = dense<41> : tensor<9x9x1xi16>}> : () -> tensor<9x9x1xi16>
    %2 = "tosa.const"() <{values = dense<-8.308000e+01> : tensor<9xf32>}> : () -> tensor<9xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<9x9x1xi16>}> : () -> tensor<9x9x1xi16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<9x9x1xi16>}> : () -> tensor<9x9x1xi16>
    %b0 = tosa.maximum %1, %c0 : (tensor<9x9x1xi16>, tensor<9x9x1xi16>) -> tensor<9x9x1xi16>
    %b1 = tosa.minimum %b0, %c15 : (tensor<9x9x1xi16>, tensor<9x9x1xi16>) -> tensor<9x9x1xi16>
    %3 = tosa.arithmetic_right_shift %0, %b1 {round = false} : (tensor<9x9x5xi16>, tensor<9x9x1xi16>) -> tensor<9x9x5xi16>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<9x9x5xi16>) -> tensor<9x9x5xi16>
    %5 = tosa.bitwise_not %4 : (tensor<9x9x5xi16>) -> tensor<9x9x5xi16>
    %6 = tosa.reciprocal %2 : (tensor<9xf32>) -> tensor<9xf32>
    %cast = tensor.cast %5 : tensor<9x9x5xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}