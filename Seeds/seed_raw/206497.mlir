module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<42> : tensor<7x5x4xi16>}> : () -> tensor<7x5x4xi16>
    %1 = "tosa.const"() <{values = dense<1.383000e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.identity %0 : (tensor<7x5x4xi16>) -> tensor<7x5x4xi16>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<7x5x4xi16>, tensor<7x5x4xi16>) -> tensor<14x5x4xi16>
    %4 = tosa.concat %3, %3 {axis = 2 : i32} : (tensor<14x5x4xi16>, tensor<14x5x4xi16>) -> tensor<14x5x8xi16>
    %5 = tosa.abs %4 : (tensor<14x5x8xi16>) -> tensor<14x5x8xi16>
    %6 = tosa.ceil %1 : (tensor<8xf32>) -> tensor<8xf32>
    %7 = tosa.logical_left_shift %5, %5 : (tensor<14x5x8xi16>, tensor<14x5x8xi16>) -> tensor<14x5x8xi16>
    %cast = tensor.cast %6 : tensor<8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<14x5x8xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

