module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.393100e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = tosa.floor %0 : (tensor<5xf32>) -> tensor<5xf32>
    %2 = tosa.tanh %1 : (tensor<5xf32>) -> tensor<5xf32>
    %3 = tosa.sub %2, %1 : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

