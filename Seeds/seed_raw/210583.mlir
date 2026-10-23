module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-35> : tensor<5x5x10xi32>}> : () -> tensor<5x5x10xi32>
    %1 = "tosa.const"() <{values = dense<-83> : tensor<5x1x1xi32>}> : () -> tensor<5x1x1xi32>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<5x5x10xi32>, tensor<5x1x1xi32>) -> tensor<5x5x10xi32>
    %cast = tensor.cast %2 : tensor<5x5x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

