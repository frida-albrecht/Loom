module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<3.605000e+01> : tensor<8x1x10xf32>}> : () -> tensor<8x1x10xf32>
    %2 = tosa.identity %0 : (tensor<4xi8>) -> tensor<4xi8>
    %3 = tosa.reciprocal %1 : (tensor<8x1x10xf32>) -> tensor<8x1x10xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<8x1x10xf32>) -> tensor<8x1x10xf32>
    %5 = tosa.identity %2 : (tensor<4xi8>) -> tensor<4xi8>
    %6 = tosa.bitwise_not %5 : (tensor<4xi8>) -> tensor<4xi8>
    %7 = tosa.logical_left_shift %6, %2 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %cast = tensor.cast %4 : tensor<8x1x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<4xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

