module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.792000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = "tosa.const"() <{values = dense<173> : tensor<1x2xi32>}> : () -> tensor<1x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.pad %0, %2, %3 : (tensor<1xf32>, !tosa.shape<2>, tensor<1xf32>) -> tensor<1xf32>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %6 = tosa.identity %5 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

