module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<10x5x8xi64>}> : () -> tensor<10x5x8xi64>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10x5x8xi64>) -> tensor<5x8xi32>
    %cast = tensor.cast %1 : tensor<5x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

