module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.021700e+02> : tensor<7x8xf32>}> : () -> tensor<7x8xf32>
    %1 = "tosa.const"() <{values = dense<1.757700e+02> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %2 = tosa.maximum %0, %1 : (tensor<7x8xf32>, tensor<1x1xf32>) -> tensor<7x8xf32>
    %3 = tosa.reciprocal %2 : (tensor<7x8xf32>) -> tensor<7x8xf32>
    %4 = tosa.add %3, %3 : (tensor<7x8xf32>, tensor<7x8xf32>) -> tensor<7x8xf32>
    %cast = tensor.cast %4 : tensor<7x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

