module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-66> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<29> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<1.411800e+02> : tensor<9x9xf32>}> : () -> tensor<9x9xf32>
    %c6 = "tosa.const"() <{values = dense<0> : tensor<i16>}> : () -> tensor<i16>
    %s7 = tosa.maximum %1, %c6 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %c8 = "tosa.const"() <{values = dense<15> : tensor<i16>}> : () -> tensor<i16>
    %s9 = tosa.minimum %s7, %c8 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %3 = tosa.logical_right_shift %0, %s9 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %4 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<9x9xf32>) -> tensor<1x9xf32>
    %5 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<1x9xf32>) -> tensor<1x9xf32>
    %cast = tensor.cast %3 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<1x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}