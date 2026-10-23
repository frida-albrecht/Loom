module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.331300e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %1 = "tosa.const"() <{values = dense<1.462700e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %2 = tosa.pow %0, %1 : (tensor<1x7xf32>, tensor<1x7xf32>) -> tensor<1x7xf32>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<1x7xf32>) -> tensor<7xi32>
    %cast = tensor.cast %3 : tensor<7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

