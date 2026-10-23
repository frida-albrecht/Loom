module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<3x2x2xi8>}> : () -> tensor<3x2x2xi8>
    %1 = tosa.argmax %0 {axis = 1 : i32} : (tensor<3x2x2xi8>) -> tensor<3x2xi32>
    %cast = tensor.cast %1 : tensor<3x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

