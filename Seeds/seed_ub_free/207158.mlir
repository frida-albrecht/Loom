module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.979000e+01> : tensor<10x7x8xf32>}> : () -> tensor<10x7x8xf32>
    %1 = tosa.exp %0 : (tensor<10x7x8xf32>) -> tensor<10x7x8xf32>
    %2 = tosa.sub %1, %1 : (tensor<10x7x8xf32>, tensor<10x7x8xf32>) -> tensor<10x7x8xf32>
    %cast = tensor.cast %2 : tensor<10x7x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

