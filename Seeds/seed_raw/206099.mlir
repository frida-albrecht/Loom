module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.733500e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %1 = "tosa.const"() <{values = dense<129> : tensor<5x10x4xi16>}> : () -> tensor<5x10x4xi16>
    %2 = "tosa.const"() <{values = dense<-26> : tensor<5x1x4xi16>}> : () -> tensor<5x1x4xi16>
    %3 = tosa.reverse %0 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<9xf32>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<9xf32>
    %5 = tosa.logical_left_shift %1, %2 : (tensor<5x10x4xi16>, tensor<5x1x4xi16>) -> tensor<5x10x4xi16>
    %6 = tosa.bitwise_or %5, %5 : (tensor<5x10x4xi16>, tensor<5x10x4xi16>) -> tensor<5x10x4xi16>
    %cast = tensor.cast %4 : tensor<9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<5x10x4xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

