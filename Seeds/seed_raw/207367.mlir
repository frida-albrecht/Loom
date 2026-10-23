module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<132> : tensor<7x2x10xi32>}> : () -> tensor<7x2x10xi32>
    %1 = tosa.identity %0 : (tensor<7x2x10xi32>) -> tensor<7x2x10xi32>
    %cast = tensor.cast %1 : tensor<7x2x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

