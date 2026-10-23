module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.069200e+02> : tensor<5x1xf32>}> : () -> tensor<5x1xf32>
    %1 = tosa.tanh %0 : (tensor<5x1xf32>) -> tensor<5x1xf32>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<5x1xf32>) -> tensor<1xi32>
    %cast = tensor.cast %2 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

