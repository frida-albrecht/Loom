module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.267200e+02> : tensor<3x8x4xf32>}> : () -> tensor<3x8x4xf32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<2xi16>}> : () -> tensor<2xi16>
    %2 = "tosa.const"() <{values = dense<-88> : tensor<2xi16>}> : () -> tensor<2xi16>
    %3 = tosa.reciprocal %0 : (tensor<3x8x4xf32>) -> tensor<3x8x4xf32>
    %4 = tosa.logical_right_shift %1, %2 : (tensor<2xi16>, tensor<2xi16>) -> tensor<2xi16>
    %cast = tensor.cast %3 : tensor<3x8x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<2xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

