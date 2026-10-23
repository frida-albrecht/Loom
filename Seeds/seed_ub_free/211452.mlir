module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<88.0899963> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<138> : tensor<1x10x1xi32>}> : () -> tensor<1x10x1xi32>
    %2 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.ceil %2 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.add %3, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.rsqrt %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.floor %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.bitwise_not %1 : (tensor<1x10x1xi32>) -> tensor<1x10x1xi32>
    %cast = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<1x10x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

