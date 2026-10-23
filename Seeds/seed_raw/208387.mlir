module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.677300e+02> : tensor<6x1x5x1xf32>}> : () -> tensor<6x1x5x1xf32>
    %1 = "tosa.const"() <{values = dense<1.271800e+02> : tensor<6x1x11x1xf32>}> : () -> tensor<6x1x11x1xf32>
    %2 = tosa.concat %0, %1 {axis = 2 : i32} : (tensor<6x1x5x1xf32>, tensor<6x1x11x1xf32>) -> tensor<6x1x16x1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<6x1x16x1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<6x1x16x1xf32>
    %cast = tensor.cast %5 : tensor<6x1x16x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

