module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.143100e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<93> : tensor<6x2x3xi32>}> : () -> tensor<6x2x3xi32>
    %2 = "tosa.const"() <{values = dense<99> : tensor<1x1x3xi32>}> : () -> tensor<1x1x3xi32>
    %3 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.log %3 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.intdiv %1, %2 : (tensor<6x2x3xi32>, tensor<1x1x3xi32>) -> tensor<6x2x3xi32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x2x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

