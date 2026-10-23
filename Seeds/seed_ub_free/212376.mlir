module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.288000e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<18> : tensor<8x1x5x1xi8>}> : () -> tensor<8x1x5x1xi8>
    %2 = tosa.rsqrt %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.sub %2, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.ceil %3 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.const_shape  {values = dense<3> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %1, %5 : (tensor<8x1x5x1xi8>, !tosa.shape<4>) -> tensor<24x3x15x3xi8>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<24x3x15x3xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

