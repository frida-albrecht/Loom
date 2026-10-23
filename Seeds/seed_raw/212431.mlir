module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.637900e+02> : tensor<6x1x8xf32>}> : () -> tensor<6x1x8xf32>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<6x1x8xf32>) -> tensor<6x1x8xf32>
    %2 = tosa.maximum %1, %1 : (tensor<6x1x8xf32>, tensor<6x1x8xf32>) -> tensor<6x1x8xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<6x1x8xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<6x1x8xf32>
    %6 = tosa.rsqrt %5 : (tensor<6x1x8xf32>) -> tensor<6x1x8xf32>
    %cast = tensor.cast %6 : tensor<6x1x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

