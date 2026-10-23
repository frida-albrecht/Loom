module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<18> : tensor<8x1xi8>}> : () -> tensor<8x1xi8>
    %1 = "tosa.const"() <{values = dense<8.655000e+01> : tensor<3x2x9xf32>}> : () -> tensor<3x2x9xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<8x1xi8>) -> tensor<1x1xi8>
    %3 = tosa.log %1 : (tensor<3x2x9xf32>) -> tensor<3x2x9xf32>
    %4 = tosa.identity %3 : (tensor<3x2x9xf32>) -> tensor<3x2x9xf32>
    %5 = tosa.reduce_sum %4 {axis = 2 : i32} : (tensor<3x2x9xf32>) -> tensor<3x2x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %tmp1 = tosa.maximum %2, %c0 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %tmp2 = tosa.minimum %tmp1, %c7 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %6 = tosa.logical_right_shift %2, %tmp2 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %7 = tosa.minimum %6, %2 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %cast = tensor.cast %5 : tensor<3x2x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}