module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<9x5x5x2xi1>}> : () -> tensor<9x5x5x2xi1>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<9x5x5x2xi1>) -> tensor<5x5x2xi32>
    %cast = tensor.cast %1 : tensor<5x5x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

