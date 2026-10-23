module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.010200e+02> : tensor<8x2xf32>}> : () -> tensor<8x2xf32>
    %1 = "tosa.const"() <{values = dense<-126> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<31> : tensor<i16>}> : () -> tensor<i16>
    %3 = tosa.floor %0 : (tensor<8x2xf32>) -> tensor<8x2xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i16>}> : () -> tensor<i16>
    %a1 = tosa.maximum %2, %c0 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %c15 = "tosa.const"() <{values = dense<15> : tensor<i16>}> : () -> tensor<i16>
    %a2 = tosa.minimum %a1, %c15 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.logical_right_shift %1, %a2 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %cast = tensor.cast %3 : tensor<8x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<i16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}