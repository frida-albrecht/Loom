module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.900500e+02> : tensor<6x7x1x3xf32>}> : () -> tensor<6x7x1x3xf32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<6x7x1x3xf32>) -> tensor<7x1x3xi32>
    %2 = tosa.sub %1, %1 : (tensor<7x1x3xi32>, tensor<7x1x3xi32>) -> tensor<7x1x3xi32>
    %cast = tensor.cast %2 : tensor<7x1x3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

