module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.870000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<1.041700e+02> : tensor<2x4x7x4xf32>}> : () -> tensor<2x4x7x4xf32>
    %2 = tosa.exp %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<2x4x7x4xf32>) -> tensor<2x1x7x4xf32>
    %4 = tosa.minimum %3, %3 : (tensor<2x1x7x4xf32>, tensor<2x1x7x4xf32>) -> tensor<2x1x7x4xf32>
    %5 = tosa.identity %3 : (tensor<2x1x7x4xf32>) -> tensor<2x1x7x4xf32>
    %6 = tosa.abs %5 : (tensor<2x1x7x4xf32>) -> tensor<2x1x7x4xf32>
    %7 = tosa.add %6, %6 : (tensor<2x1x7x4xf32>, tensor<2x1x7x4xf32>) -> tensor<2x1x7x4xf32>
    %8 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<2x1x7x4xf32>) -> tensor<2x1x7x4xf32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<2x1x7x4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<2x1x7x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

