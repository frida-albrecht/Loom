module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.729000e+01> : tensor<3x3x2xf32>}> : () -> tensor<3x3x2xf32>
    %1 = "tosa.const"() <{values = dense<-7.472000e+01> : tensor<3x3x2xf32>}> : () -> tensor<3x3x2xf32>
    %2 = tosa.minimum %0, %1 : (tensor<3x3x2xf32>, tensor<3x3x2xf32>) -> tensor<3x3x2xf32>
    %3 = tosa.reduce_sum %2 {axis = 1 : i32} : (tensor<3x3x2xf32>) -> tensor<3x1x2xf32>
    %cast = tensor.cast %3 : tensor<3x1x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

