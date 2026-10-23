module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.330700e+02> : tensor<10x1x10x7xf32>}> : () -> tensor<10x1x10x7xf32>
    %1 = "tosa.const"() <{values = dense<4> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.pad %0, %2, %3 : (tensor<10x1x10x7xf32>, !tosa.shape<8>, tensor<1xf32>) -> tensor<10x1x10x7xf32>
    %5 = tosa.log %4 : (tensor<10x1x10x7xf32>) -> tensor<10x1x10x7xf32>
    %cast = tensor.cast %5 : tensor<10x1x10x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

