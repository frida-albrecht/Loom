module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2.468000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-81.6399993> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-1.778000e+02> : tensor<9x1x8xf32>}> : () -> tensor<9x1x8xf32>
    %3 = tosa.pow %0, %1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %4 = tosa.reduce_min %2 {axis = 1 : i32} : (tensor<9x1x8xf32>) -> tensor<9x1x8xf32>
    %5 = tosa.add %3, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<9x1x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

