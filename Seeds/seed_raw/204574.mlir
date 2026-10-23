module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<110> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = tosa.clz %0 : (tensor<3xi32>) -> tensor<3xi32>
    %cast = tensor.cast %1 : tensor<3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

