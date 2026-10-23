module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-189> : tensor<3x3x4x6xi16>}> : () -> tensor<3x3x4x6xi16>
    %1 = "tosa.const"() <{values = dense<-1.631300e+02> : tensor<7x8x9xf32>}> : () -> tensor<7x8x9xf32>
    %2 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<3x3x4x6xi16>) -> tensor<3x3x1x6xi16>
    %3 = tosa.tanh %1 : (tensor<7x8x9xf32>) -> tensor<7x8x9xf32>
    %4 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<3x3x1x6xi16>, tensor<3x3x1x6xi16>) -> tensor<3x3x1x6xi16>
    %5 = tosa.bitwise_or %4, %4 : (tensor<3x3x1x6xi16>, tensor<3x3x1x6xi16>) -> tensor<3x3x1x6xi16>
    %6 = tosa.reciprocal %3 : (tensor<7x8x9xf32>) -> tensor<7x8x9xf32>
    %cast = tensor.cast %5 : tensor<3x3x1x6xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<7x8x9xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

