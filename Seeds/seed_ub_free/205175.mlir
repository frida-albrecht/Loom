module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<105> : tensor<2x6x2xi64>}> : () -> tensor<2x6x2xi64>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<2x6x2xi64>) -> tensor<2x2xi32>
    %cast = tensor.cast %1 : tensor<2x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

