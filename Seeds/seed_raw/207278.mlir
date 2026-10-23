module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.521800e+02> : tensor<3x2x4xf32>}> : () -> tensor<3x2x4xf32>
    %1 = tosa.floor %0 : (tensor<3x2x4xf32>) -> tensor<3x2x4xf32>
    %2 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<3x2x4xf32>) -> tensor<3x1x4xf32>
    %cast = tensor.cast %2 : tensor<3x1x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

