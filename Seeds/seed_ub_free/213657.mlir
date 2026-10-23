module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<94> : tensor<5x6x7xi32>}> : () -> tensor<5x6x7xi32>
    %1 = "tosa.const"() <{values = dense<12> : tensor<1x1x1xi32>}> : () -> tensor<1x1x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<5x6x7xi32>, tensor<1x1x1xi32>) -> tensor<5x6x7xi32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<5x6x7xi32>, tensor<5x6x7xi32>) -> tensor<5x6x7xi32>
    %cast = tensor.cast %3 : tensor<5x6x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

