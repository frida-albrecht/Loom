module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<26> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = "tosa.const"() <{values = dense<3> : tensor<7xi32>}> : () -> tensor<7xi32>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %cast = tensor.cast %2 : tensor<7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

