module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<11> : tensor<3x1x1x10xi8>}> : () -> tensor<3x1x1x10xi8>
    %1 = "tosa.const"() <{values = dense<4.905000e+01> : tensor<9x8x2x2xf32>}> : () -> tensor<9x8x2x2xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<3x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1x1x1x10xi8>, tensor<1x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %4 = tosa.sigmoid %1 : (tensor<9x8x2x2xf32>) -> tensor<9x8x2x2xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x1x1x10xi8>}> : () -> tensor<1x1x1x10xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x1x1x10xi8>}> : () -> tensor<1x1x1x10xi8>
    %a1 = tosa.maximum %3, %c0 : (tensor<1x1x1x10xi8>, tensor<1x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %a2 = tosa.minimum %a1, %c7 : (tensor<1x1x1x10xi8>, tensor<1x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %5 = tosa.logical_left_shift %3, %a2 : (tensor<1x1x1x10xi8>, tensor<1x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %6 = tosa.add %4, %4 : (tensor<9x8x2x2xf32>, tensor<9x8x2x2xf32>) -> tensor<9x8x2x2xf32>
    %7 = tosa.reverse %6 {axis = 2 : i32} : (tensor<9x8x2x2xf32>) -> tensor<9x8x2x2xf32>
    %8 = tosa.abs %7 : (tensor<9x8x2x2xf32>) -> tensor<9x8x2x2xf32>
    %9 = tosa.logical_right_shift %5, %a2 : (tensor<1x1x1x10xi8>, tensor<1x1x1x10xi8>) -> tensor<1x1x1x10xi8>
    %10 = tosa.reduce_sum %8 {axis = 2 : i32} : (tensor<9x8x2x2xf32>) -> tensor<9x8x1x2xf32>
    %11 = tosa.exp %10 : (tensor<9x8x1x2xf32>) -> tensor<9x8x1x2xf32>
    %12 = tosa.sigmoid %10 : (tensor<9x8x1x2xf32>) -> tensor<9x8x1x2xf32>
    %13 = tosa.reduce_max %12 {axis = 0 : i32} : (tensor<9x8x1x2xf32>) -> tensor<1x8x1x2xf32>
    %cast = tensor.cast %9 : tensor<1x1x1x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %11 : tensor<9x8x1x2xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %13 : tensor<1x8x1x2xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}