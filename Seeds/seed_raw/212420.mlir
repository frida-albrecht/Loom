module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.604600e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<77> : tensor<3x1x3xi16>}> : () -> tensor<3x1x3xi16>
    %2 = "tosa.const"() <{values = dense<187> : tensor<3x1x3xi16>}> : () -> tensor<3x1x3xi16>
    %3 = tosa.exp %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.bitwise_xor %1, %2 : (tensor<3x1x3xi16>, tensor<3x1x3xi16>) -> tensor<3x1x3xi16>
    %5 = tosa.argmax %4 {axis = 1 : i32} : (tensor<3x1x3xi16>) -> tensor<3x3xi32>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<3x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

