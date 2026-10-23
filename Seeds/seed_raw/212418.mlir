module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.589600e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = tosa.floor %0 : (tensor<8xf32>) -> tensor<8xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.negate %1, %2, %3 : (tensor<8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<8xf32>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %6 = tosa.pow %5, %5 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

