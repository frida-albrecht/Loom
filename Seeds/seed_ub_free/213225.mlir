module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.011000e+01> : tensor<2x3x2x4xf32>}> : () -> tensor<2x3x2x4xf32>
    %1 = "tosa.const"() <{values = dense<9> : tensor<7x4x3x10xi8>}> : () -> tensor<7x4x3x10xi8>
    %2 = "tosa.const"() <{values = dense<10> : tensor<1x4x1x10xi8>}> : () -> tensor<1x4x1x10xi8>
    %3 = tosa.reverse %0 {axis = 1 : i32} : (tensor<2x3x2x4xf32>) -> tensor<2x3x2x4xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x4x1x10xi8>}> : () -> tensor<1x4x1x10xi8>
    %cclamped_lower = tosa.maximum %2, %c0 : (tensor<1x4x1x10xi8>, tensor<1x4x1x10xi8>) -> tensor<1x4x1x10xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<1x4x1x10xi8>}> : () -> tensor<1x4x1x10xi8>
    %cclamped_shift = tosa.minimum %cclamped_lower, %c7 : (tensor<1x4x1x10xi8>, tensor<1x4x1x10xi8>) -> tensor<1x4x1x10xi8>
    %4 = tosa.logical_left_shift %1, %cclamped_shift : (tensor<7x4x3x10xi8>, tensor<1x4x1x10xi8>) -> tensor<7x4x3x10xi8>
    %5 = tosa.clamp %3 {max_val = 1.330000e+02 : f32, min_val = -1.000000e+00 : f32} : (tensor<2x3x2x4xf32>) -> tensor<2x3x2x4xf32>
    %cast = tensor.cast %4 : tensor<7x4x3x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<2x3x2x4xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}