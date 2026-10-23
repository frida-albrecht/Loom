module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.841000e+01> : tensor<5x2x9xf32>}> : () -> tensor<5x2x9xf32>
    %1 = "tosa.const"() <{values = dense<-1.511000e+01> : tensor<1x2x1xf32>}> : () -> tensor<1x2x1xf32>
    %2 = tosa.minimum %0, %1 : (tensor<5x2x9xf32>, tensor<1x2x1xf32>) -> tensor<5x2x9xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %5 = tosa.negate %2, %3, %4 : (tensor<5x2x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<5x2x9xf32>
    %6 = tosa.add %5, %5 : (tensor<5x2x9xf32>, tensor<5x2x9xf32>) -> tensor<5x2x9xf32>
    %cast = tensor.cast %6 : tensor<5x2x9xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

