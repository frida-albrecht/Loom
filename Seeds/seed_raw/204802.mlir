module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<9x7x3x3xi32>}> : () -> tensor<9x7x3x3xi32>
    %1 = "tosa.const"() <{values = dense<6.750000e+00> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<9x7x3x3xi32>) -> tensor<9x7x3x3xi32>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<9x7x3x3xi32>) -> tensor<1x7x3x3xi32>
    %4 = tosa.reciprocal %1 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<1x7x3x3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

