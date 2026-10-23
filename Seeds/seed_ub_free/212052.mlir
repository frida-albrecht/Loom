module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.233000e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<-83> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.pad %0, %2, %3 : (tensor<4xf32>, !tosa.shape<2>, tensor<1xf32>) -> tensor<4xf32>
    %5 = tosa.identity %4 : (tensor<4xf32>) -> tensor<4xf32>
    %cast = tensor.cast %5 : tensor<4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

