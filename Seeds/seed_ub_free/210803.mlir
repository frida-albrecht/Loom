module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.953000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-60> : tensor<9x2x3x5xi32>}> : () -> tensor<9x2x3x5xi32>
    %2 = tosa.rsqrt %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_min %1 {axis = 3 : i32} : (tensor<9x2x3x5xi32>) -> tensor<9x2x3x1xi32>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<9x2x3x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

