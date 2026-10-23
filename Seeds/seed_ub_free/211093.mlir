module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<1x3x8x8xi8>}> : () -> tensor<1x3x8x8xi8>
    %1 = "tosa.const"() <{values = dense<1.374700e+02> : tensor<2x5x5xf32>}> : () -> tensor<2x5x5xf32>
    %2 = tosa.clz %0 : (tensor<1x3x8x8xi8>) -> tensor<1x3x8x8xi8>
    %3 = tosa.maximum %2, %2 : (tensor<1x3x8x8xi8>, tensor<1x3x8x8xi8>) -> tensor<1x3x8x8xi8>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = true} : (tensor<1x3x8x8xi8>, tensor<1x3x8x8xi8>) -> tensor<1x3x8x8xi8>
    %5 = tosa.sigmoid %1 : (tensor<2x5x5xf32>) -> tensor<2x5x5xf32>
    %6 = tosa.reduce_max %5 {axis = 1 : i32} : (tensor<2x5x5xf32>) -> tensor<2x1x5xf32>
    %7 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<1x3x8x8xi8>) -> tensor<1x3x8x8xi8>
    %cast = tensor.cast %6 : tensor<2x1x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x3x8x8xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

