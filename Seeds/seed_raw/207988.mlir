module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7> : tensor<3xi8>}> : () -> tensor<3xi8>
    %1 = "tosa.const"() <{values = dense<19> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<1.509800e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.logical_right_shift %0, %1 : (tensor<3xi8>, tensor<1xi8>) -> tensor<3xi8>
    %4 = tosa.rsqrt %2 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<3xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

