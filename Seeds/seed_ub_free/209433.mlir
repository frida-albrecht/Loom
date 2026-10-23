module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<3x10xi16>}> : () -> tensor<3x10xi16>
    %1 = "tosa.const"() <{values = dense<-7.876000e+01> : tensor<4x5x1x6xf32>}> : () -> tensor<4x5x1x6xf32>
    %2 = tosa.clz %0 : (tensor<3x10xi16>) -> tensor<3x10xi16>
    %3 = tosa.add %2, %2 : (tensor<3x10xi16>, tensor<3x10xi16>) -> tensor<3x10xi16>
    %4 = tosa.logical_left_shift %3, %2 : (tensor<3x10xi16>, tensor<3x10xi16>) -> tensor<3x10xi16>
    %5 = tosa.tanh %1 : (tensor<4x5x1x6xf32>) -> tensor<4x5x1x6xf32>
    %6 = tosa.log %5 : (tensor<4x5x1x6xf32>) -> tensor<4x5x1x6xf32>
    %cast = tensor.cast %4 : tensor<3x10xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<4x5x1x6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

