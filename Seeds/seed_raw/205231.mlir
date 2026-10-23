module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-33> : tensor<6x5x4xi32>}> : () -> tensor<6x5x4xi32>
    %1 = "tosa.const"() <{values = dense<123> : tensor<6x1x4xi32>}> : () -> tensor<6x1x4xi32>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<6x5x4xi32>, tensor<6x1x4xi32>) -> tensor<6x5x4xi32>
    %cast = tensor.cast %2 : tensor<6x5x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

