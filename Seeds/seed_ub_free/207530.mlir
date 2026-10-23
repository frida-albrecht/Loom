module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %1 = tosa.abs %0 : (tensor<3x2xi32>) -> tensor<3x2xi32>
    %2 = tosa.clz %1 : (tensor<3x2xi32>) -> tensor<3x2xi32>
    %cast = tensor.cast %2 : tensor<3x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

