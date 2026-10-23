module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-74> : tensor<3x7x9x6xi16>}> : () -> tensor<3x7x9x6xi16>
    %1 = tosa.argmax %0 {axis = 2 : i32} : (tensor<3x7x9x6xi16>) -> tensor<3x7x6xi32>
    %cast = tensor.cast %1 : tensor<3x7x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

