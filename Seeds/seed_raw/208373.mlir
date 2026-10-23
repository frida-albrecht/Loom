module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<60> : tensor<2xi64>}> : () -> tensor<2xi64>
    %1 = "tosa.const"() <{values = dense<92> : tensor<2xi64>}> : () -> tensor<2xi64>
    %2 = tosa.minimum %0, %1 : (tensor<2xi64>, tensor<2xi64>) -> tensor<2xi64>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<2xi64>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

